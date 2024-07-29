-------------------------------------------
-- A very simplistic Flight Dynamic Model
-- For simulation/testing only
-------------------------------------------

with components; use components;
with COMIF.ACS; use COMIF.ACS;
with COMIF.ACC; use COMIF.ACC;
with COMIF.GPS; use COMIF.GPS;
with COMIF.TMAP; use COMIF.TMAP;
with math; use math;
with average;
with errorlog;
with terrain_data;

package body FDM is

   roll_speed : Float := 0.0;
   pitch_speed : Float := 0.0;
   vertical_speed : Float := 0.0;
   horizontal_speed : Float := 0.0;

   wind_speed_ms : constant Float := 12.0;
   wind_heading  : constant Float := 0.0;

   dt : Float;
   aircraft_status : COMIF.ACS.t_ACS_status;
   GPS_status : COMIF.GPS.t_GPS_status;

   -- TMAP
   tmap_full_reload_next_idx : Integer := -1;


   package avg_roll_speed is new average(10);

   -------------------------------
   -- set the aircraft state
   -------------------------------
   procedure set (latitude  : t_latitude;
                  longitude : t_longitude;
                  altitude  : t_altitude;
                  heading   : t_heading;
                  speed     : t_hspeed)
   is
      aircraft_status : t_ACS_status;
      GPS_status : t_GPS_status;
   begin
      aircraft_status.aileron   := 0.0;
      aircraft_status.elevator  := 0.0;
      aircraft_status.rudder    := 0.0;
      aircraft_status.throttle1 := 50.0;
      aircraft_status.throttle2 := 50.0;
      aircraft_status.heading   := heading;
      aircraft_status.airspeed  := speed;
      aircraft_status.roll      := 0.0;
      aircraft_status.pitch     := 0.0;
      GPS_status.latitude := latitude;
      GPS_status.longitude := longitude;
      GPS_status.altitude := altitude;
      GPS_status.hspeed := speed;
      horizontal_speed := Float(speed);
      GPS_status.vspeed := 0.0;
      vertical_speed := 0.0;
      COMIF.ACS.write (Comp_FDM, aircraft_status);
      COMIF.GPS.write (Comp_FDM, GPS_status);
      roll_speed := 0.0;
      pitch_speed := 0.0;
      avg_roll_speed.reset;
      tmap_full_reload_next_idx := -1;
   end set;


   -------------------------------
   -- initialize the aircraft state
   -------------------------------
   procedure init is
   begin
      set (0.0, 0.0, 0.0, 0.0, 0.0);
   end init;


   -------------------------------
   -- saturate a float
   -------------------------------
   procedure saturate (v : in out Float; min, max : Float) is
   begin
      if v > max then
         v := max;
      elsif v < min then
         v := min;
      end if;
   end saturate;


   -------------------------------
   -- pitch + throttle => speed
   -------------------------------
   procedure update_speed is
      v : constant Float := horizontal_speed;
      pitch : constant Float := Float (aircraft_status.pitch);
      airbraking : constant Float := (v*v) / 50000.0;
      acceleration : constant Float := (Float(aircraft_status.throttle1) + Float(aircraft_status.throttle2)) / 16.0;
      dv : Float := (acceleration - airbraking) / 10.0;
   begin
      if dv > 0.0 then
         -- accelerating
         if pitch < 0.0 then
            -- pointing up
            dv := dv * fcos_deg(fabs(pitch));
         else
            -- pointing down
            dv := dv * (1.0 + fsin_deg(fabs(pitch)));
         end if;

      elsif dv < 0.0 then
         -- deccelerating
         if pitch < 0.0 then
            -- pointing up
            dv := dv * (1.0 + fsin_deg(fabs(pitch)));
         else
            -- pointing down
            dv := dv * fcos_deg(fabs(pitch));
         end if;
      end if;

      horizontal_speed := v + dv;
   end update_speed;


   -------------------------------
   -- pitch + speed => vertspeed
   -------------------------------
   procedure update_vertspeed is
      n_v : Float;
      speed : constant Float := horizontal_speed;
      pitch : constant Float := Float (aircraft_status.pitch);
   begin
      if pitch < 0.0 then
         -- going up
         n_v := speed * fsin_deg (fabs(pitch));
      else
         -- going down
         n_v := - (speed * fsin_deg (pitch));
         n_v := n_v * 1.2;
      end if;
      vertical_speed := n_v / 2.0;
      saturate (vertical_speed, -250.0, 150.0);
   end update_vertspeed;


   -------------------------------
   -- elevator => pitch_speed
   -------------------------------
   procedure update_pitch_speed is
      elevator : constant Float := Float(aircraft_status.elevator);
   begin
      if elevator > 0.0 then
         -- going up => pitch--
         pitch_speed := - (elevator / 25.0);
      else
         -- going down => pitch++
         pitch_speed := - (elevator / 15.0);
      end if;
   end update_pitch_speed;


   -------------------------------
   -- pitch_speed => pitch
   -------------------------------
   procedure update_pitch is
      pitch : constant Float := Float (aircraft_status.pitch);
      v : Float;
   begin
      v := pitch + pitch_speed * dt;
      saturate (v, Float(t_pitch'First), Float(t_pitch'Last));
      aircraft_status.pitch := t_pitch (v);
   end update_pitch;


   -------------------------------
   -- vertspeed => altitude
   -------------------------------
   procedure update_altitude is
      v : Float;
   begin
      v := Float(GPS_status.altitude) + vertical_speed * dt;
      GPS_status.altitude := t_altitude (v);
   end update_altitude;


   -------------------------------
   -- aileron => roll_speed
   -------------------------------
   procedure update_roll_speed is
      v : Float;
   begin
      -- aileron > 0 => roll right : roll angle --
      -- ailreon < 0 => roll left  : roll angle ++
      v := - Float(aircraft_status.aileron) * 2.0;
      avg_roll_speed.add (v);
      roll_speed := avg_roll_speed.get;
   end update_roll_speed;


   -------------------------------
   -- roll_speed => roll
   -------------------------------
   procedure update_roll is
      v : Float;
   begin
      v := Float(aircraft_status.roll) + roll_speed * dt;
      saturate (v, Float(t_roll'First), Float(t_roll'Last));
      aircraft_status.roll := t_roll (v);
   end update_roll;


   -------------------------------
   -- roll + elevator + rudder => heading
   -------------------------------
   procedure update_heading is
      h : Float := Float (aircraft_status.heading);
      d_h1 : Float;
      d_h2 : Float;
   begin
      -- roll + elevator
      -- roll < 0: heading++
      -- roll > 0: heading--
      d_h1 := -1.0 * fsin_deg(Float(aircraft_status.roll)) * Float(aircraft_status.elevator);
      d_h1 := d_h1 / 25.0;

      -- rudder
      d_h2 := (Float(aircraft_status.rudder) / 100.0);

      if d_h2 /= 0.0 then
         h := h + d_h2;
      else
         h := h + d_h1;
      end if;

      if h < 0.0 then
         h := 360.0 + h;
      elsif h > 360.0 then
         h := h - 360.0;
      end if;
      aircraft_status.heading := t_heading(h);
   end update_heading;


   -------------------------------
   -- heading + speed => latitude
   -------------------------------
   procedure update_latitude is
      speed_ms : constant Double := Double(horizontal_speed) * 0.514444; -- knots -> m/s
      northward_speed_ms : constant Double := speed_ms * Double(fcos_deg(Float(aircraft_status.heading)));
      northward_windspeed_ms : constant Double := Double(wind_speed_ms) * Double(fcos_deg(Float(wind_heading)));
      latitude_change_m : constant Double := (northward_speed_ms + northward_windspeed_ms) * Double(dt);
      latitude_change_deg : constant Double := latitude_change_m / 111139.0;
      latitude_deg : Double := Double(GPS_status.latitude);
   begin
      latitude_deg := latitude_deg + latitude_change_deg;
      if latitude_deg > 90.0 then
         latitude_deg := latitude_deg - 180.0;
      end if;
      if latitude_deg < -90.0 then
         latitude_deg := latitude_deg + 180.0;
      end if;
      GPS_status.latitude := t_latitude (latitude_deg);
   end update_latitude;


   -------------------------------
   -- heading + speed => longitude
   -------------------------------
   procedure update_longitude is
      speed_ms : constant Double := Double(horizontal_speed) * 0.514444; -- knots -> m/s
      eastward_speed_ms : constant Double := speed_ms * Double(fsin_deg(Float(aircraft_status.heading)));
      eastward_windspeed_ms : constant Double := double(wind_speed_ms) * Double(fsin_deg(Float(wind_heading)));
      longitude_change_m : constant Double := (eastward_speed_ms + eastward_windspeed_ms) * Double(dt);
      longitude_change_deg : constant Double := longitude_change_m / (111320.0 * Double(fcos_deg(Float(GPS_status.latitude))));
      longitude_deg : Double := Double(GPS_status.longitude);
   begin
      longitude_deg := longitude_deg + longitude_change_deg;
      if longitude_deg > 180.0 then
         longitude_deg := longitude_deg - 360.0;
      end if;
      if longitude_deg < -180.0 then
         longitude_deg := longitude_deg + 360.0;
      end if;
      --Put_Line (">> " & longitude_change_m'Img & "    " & speed_ms'Img & "   " & longitude_change_deg'Img & "  " & longitude_deg'Img);
      GPS_status.longitude := t_longitude (longitude_deg);
   end update_longitude;

   -------------------------------
   -- serve one TMAP query
   -------------------------------
   function latlon_to_data(v : Interfaces.Integer_32) return Natural
   is
      use Interfaces;
      mirrored : Boolean;
      DATA_SIZE : Integer_32 := Integer_32(terrain_data.DATA_SIZE);
   begin
      if v >= 0 then
         -- positive
         mirrored := (((v/DATA_SIZE) mod 2) /= 0);
         if mirrored then
            return Natural((DATA_SIZE-1)-(v mod DATA_SIZE));
         else
            return Natural(v mod DATA_SIZE);
         end if;
      else
         -- negative
         mirrored := (((abs(v)/DATA_SIZE) mod 2) = 0);
         if mirrored then
            return Natural(abs(v) mod DATA_SIZE);
         else
			return Natural((DATA_SIZE-1)-(abs(v) mod DATA_SIZE));
         end if;
      end if;
   end latlon_to_data;


   function get_data (ilat : t_ilatitude; ilon : t_ilongitude) return Interfaces.Unsigned_8 is
   begin
      return terrain_data.data(latlon_to_data(Interfaces.Integer_32(ilat)),
                               latlon_to_data(Interfaces.Integer_32(ilon)));
   end get_data;


   function process_request (req : in out COMIF.TMAP.t_map_request;
                             data : in out COMIF.TMAP.t_TMAP_status)
                             return Boolean
   is
      use Interfaces;
      idx : Natural := 0;
   begin
      --Put_Line ("TMAP server: req (" & req.ilat1'Img &".." & req.ilat2'Img & ")  (" & req.ilon1'Img & ".." & req.ilon2'Img & ")");

      data.response.ilat1 := req.ilat1;
      data.response.ilat2 := req.ilat2;
      data.response.ilon1 := req.ilon1;
      data.response.ilon2 := req.ilon2;

      if req.ilat1 = req.ilat2 then
         for ilon in req.ilon1 .. req.ilon2 loop
            idx := idx + 1;
            data.response.data(idx) := get_data(req.ilat1,ilon);
         end loop;
         data.response.valid := True;
         return True;

      elsif req.ilon1 = req.ilon2 then
         for ilat in req.ilat1 .. req.ilat2 loop
            idx := idx + 1;
            data.response.data(idx) := get_data(ilat,req.ilon1);
         end loop;
         data.response.valid := True;
         return True;

      else
         for ilon in req.ilon1 .. req.ilon2 loop
            idx := idx + 1;
			  data.response.data(idx) := get_data(req.ilat1,ilon);
         end loop;
         data.response.ilat1 := req.ilat1;
         data.response.ilat2 := req.ilat1;
         data.response.valid := True;
         req.ilat1 := req.ilat1 + 1;
         return False;

      end if;
   end process_request;


   procedure tmap_server is
      data : COMIF.TMAP.t_TMAP_status := COMIF.TMAP.read(Comp_FDM);
      req  : COMIF.TMAP.t_map_request := data.requests(data.requests'First);
   begin
      if data.response.valid then
         errorlog.log ("TMAP server : previous response not used yet");
      end if;
      if req.valid then
         if process_request (req, data) then
            -- request fully processed, remove it from the queue
            for i in data.requests'First .. data.requests'Last-1 loop
               data.requests(i) := data.requests(i+1);
            end loop;
            data.requests(data.requests'Last).valid := False;
         else
            -- request partially processed, update it in the queue
            data.requests(data.requests'First) := req;
         end if;
      end if;
      COMIF.TMAP.write(Comp_FDM, data);
   end tmap_server;


   -------------------------------
   -- update the aircraft state
   -------------------------------
   procedure update(hz : Natural) is
      control : constant COMIF.ACC.t_ACC_control := COMIF.ACC.read (Comp_FDM);
   begin
      dt := 1.0 / Float(hz);

      aircraft_status := COMIF.ACS.read (Comp_FDM);
      GPS_status := COMIF.GPS.read (Comp_FDM);

      -- simulating 0 delay effect of controls
      aircraft_status.aileron   := control.command_aileron;
      aircraft_status.elevator  := control.command_elevator;
      aircraft_status.rudder    := control.command_rudder;
      aircraft_status.throttle1 := control.command_throttle1;
      aircraft_status.throttle2 := control.command_throttle2;

      -- update the aircraft status

      update_roll;
      update_pitch;

      update_speed;
      update_vertspeed;
      update_roll_speed;
      update_pitch_speed;

      update_longitude;
      update_latitude;
      update_heading;
      update_altitude;

      aircraft_status.airspeed := t_hspeed (horizontal_speed);

      COMIF.ACS.write (Comp_FDM, aircraft_status);
      COMIF.GPS.write (Comp_FDM, GPS_status);

      tmap_server;
   end update;

end FDM;
