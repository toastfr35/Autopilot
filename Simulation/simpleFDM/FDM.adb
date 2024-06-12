-------------------------------------------
-- A very simplistic Flight Dynamic Model
-- For simulation/testing only
-------------------------------------------

with aircraft_interface;
with math; use math;
with average;

package body FDM is

   roll_speed : Float := 0.0;
   pitch_speed : Float := 0.0;

   dt : Float;

   package avg_roll_speed is new average(10);
   package avg_heading is new average(10);


   -------------------------------
   -- set the aircraft state
   -------------------------------
   procedure set (latitude  : aircraft.t_latitude;
                  longitude : aircraft.t_longitude;
                  altitude  : aircraft.t_altitude;
                  heading   : aircraft.t_heading;
                  velocity  : aircraft.t_velocity)
   is
   begin
      aircraft_interface.set_aileron (0.0);
      aircraft_interface.set_elevator (0.0);
      aircraft_interface.set_rudder (0.0);
      aircraft_interface.set_throttle1 (50.0);
      aircraft_interface.set_throttle2 (50.0);
      aircraft_interface.set_latitude (latitude);
      aircraft_interface.set_longitude (longitude);
      aircraft_interface.set_altitude (altitude);
      aircraft_interface.set_heading (heading);
      aircraft_interface.set_velocity (velocity);
      aircraft_interface.set_roll (0.0);
      aircraft_interface.set_pitch (0.0);
      aircraft_interface.set_vertspeed (0.0);
      roll_speed := 0.0;
      pitch_speed := 0.0;
      avg_roll_speed.reset;
      avg_heading.reset;
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
   -- pitch + throttle => velocity
   -------------------------------
   procedure update_velocity is
      use type aircraft.t_pitch;
      v : constant Float := Float (aircraft.status.velocity);
      airbraking : constant Float := Float(aircraft.status.velocity) * Float(aircraft.status.velocity) / 50000.0;
      acceleration : constant Float := Float(aircraft.status.throttle1) / 8.0;
      dv : Float := (acceleration - airbraking) / 10.0;
   begin
      if dv > 0.0 then
         -- accelerating
         if aircraft.status.pitch < 0.0 then
            -- pointing up
            dv := dv * fcos_deg(fabs(float(aircraft.status.pitch)));
         else
            -- pointing down
            dv := dv * (1.0 + fsin_deg(fabs(float(aircraft.status.pitch))));
         end if;

      elsif dv < 0.0 then
         -- deccelerating
         if aircraft.status.pitch < 0.0 then
            -- pointing up
            dv := dv * (1.0 + fsin_deg(fabs(float(aircraft.status.pitch))));
         else
            -- pointing down
            dv := dv * fcos_deg(fabs(float(aircraft.status.pitch)));
         end if;
      end if;

      aircraft_interface.set_velocity (aircraft.t_velocity(v + dv));
   end update_velocity;


   -------------------------------
   -- pitch + velocity => vertspeed
   -------------------------------
   procedure update_vertspeed is
      use type aircraft.t_pitch;
      v : Float := Float (aircraft.status.vertspeed);
      n_v : Float;
      velocity : constant Float := Float (aircraft.status.velocity);
   begin
      if aircraft.status.pitch < 0.0 then
         -- going up
         n_v := velocity * fsin_deg (fabs(Float(aircraft.status.pitch)));
      else
         -- going down
         n_v := - (velocity * fsin_deg (Float(aircraft.status.pitch)));
         n_v := n_v * 1.2;
      end if;
      v := n_v / 2.0;
      saturate (v, -250.0, 150.0);
      aircraft_interface.set_vertspeed (aircraft.t_vertspeed(v));
   end update_vertspeed;


   -------------------------------
   -- elevator => pitch_speed
   -------------------------------
   procedure update_pitch_speed is
      use type aircraft.t_elevator;
   begin
      if aircraft.status.elevator > 0.0 then
         -- going up => pitch--
         pitch_speed := - (Float(aircraft.status.elevator) / 25.0);
      else
         -- going down => pitch++
         pitch_speed := - (Float(aircraft.status.elevator) / 15.0);
      end if;
   end update_pitch_speed;


   -------------------------------
   -- pitch_speed => pitch
   -------------------------------
   procedure update_pitch is
      v : Float;
   begin
      v := Float(aircraft.status.pitch) + pitch_speed * dt;
      saturate (v, Float(aircraft.t_pitch'First), Float(aircraft.t_pitch'Last));
      aircraft_interface.set_pitch (aircraft.t_pitch (v));
   end update_pitch;


   -------------------------------
   -- vertspeed => altitude
   -------------------------------
   procedure update_altitude is
      v : Float;
   begin
      v := Float(aircraft.status.altitude) + Float(aircraft.status.vertspeed) * dt;
      aircraft_interface.set_altitude (aircraft.t_altitude (v));
   end update_altitude;


   -------------------------------
   -- aileron => roll_speed
   -------------------------------
   procedure update_roll_speed is
      v : Float;
   begin
      -- aileron > 0 => roll right : roll angle --
      -- ailreon < 0 => roll left  : roll angle ++
      v := - Float(aircraft.status.aileron) * 2.0;
      avg_roll_speed.add (v);
      roll_speed := avg_roll_speed.get;
   end update_roll_speed;


   -------------------------------
   -- roll_speed => roll
   -------------------------------
   procedure update_roll is
      v : Float;
   begin
      v := Float(aircraft.status.roll) + roll_speed * dt;
      saturate (v, Float(aircraft.t_roll'First), Float(aircraft.t_roll'Last));
      aircraft_interface.set_roll (aircraft.t_roll (v));
   end update_roll;


   -------------------------------
   -- roll + elevator + rudder => heading
   -------------------------------
   procedure update_heading is
      v : Float := Float (aircraft.status.heading);
      d_h1 : Float;
      d_h2 : Float;
   begin
      -- roll + elevator
      -- roll < 0: heading++
      -- roll > 0: heading--
      d_h1 := -1.0 * fsin_deg(Float(aircraft.status.roll)) * Float(aircraft.status.elevator);
      d_h1 := d_h1 / 25.0;

      -- rudder
      d_h2 := (Float(aircraft.status.rudder) / 100.0);

      if d_h2 /= 0.0 then
         v := v + d_h2;
      else
         v := v + d_h1;
      end if;

      if v < 0.0 then
         v := 360.0 + v;
      elsif v > 360.0 then
         v := v - 360.0;
      end if;

      --log.log (log.FDM, 50, 0, "E:" & img.Image(d_h1) & "  R:" & img.Image(d_h2) & " => " & img.Image(v));

      --avg_heading.add(v);
      --aircraft_interface.set_heading (aircraft.t_heading(avg_heading.get));
      aircraft_interface.set_heading (aircraft.t_heading(v));
   end update_heading;


   -------------------------------
   -- heading + velocity => latitude
   -------------------------------
   procedure update_latitude is
      velocity_ms : constant Float := Float(aircraft.status.velocity) * 0.514444; -- knots -> m/s
      northward_velocity_ms : constant Float := velocity_ms * fcos_deg(Float(aircraft.status.heading));
      latitude_change_m : constant Float := northward_velocity_ms * dt;
      latitude_change_deg : constant Float := latitude_change_m / 111139.0;
      latitude_deg : Float := Float(aircraft.status.latitude);
   begin
      latitude_deg := latitude_deg + latitude_change_deg;
      if latitude_deg > 90.0 then
         latitude_deg := latitude_deg - 180.0;
      end if;
      if latitude_deg < -90.0 then
         latitude_deg := latitude_deg + 180.0;
      end if;
      aircraft_interface.set_latitude (aircraft.t_latitude (latitude_deg));
   end update_latitude;


   -------------------------------
   -- heading + velocity => longitude
   -------------------------------
   procedure update_longitude is
      velocity_ms : constant Float := Float(aircraft.status.velocity) * 0.514444; -- knots -> m/s
      eastward_velocity_ms : constant Float := velocity_ms * fsin_deg(Float(aircraft.status.heading));
      longitude_change_m : constant Float := eastward_velocity_ms * dt;
      longitude_change_deg : constant Float := longitude_change_m / (111320.0 * fcos_deg(Float(aircraft.status.latitude)));
      longitude_deg : Float := Float(aircraft.status.longitude);
   begin
      longitude_deg := longitude_deg + longitude_change_deg;
      if longitude_deg > 180.0 then
         longitude_deg := longitude_deg - 360.0;
      end if;
      if longitude_deg < -180.0 then
         longitude_deg := longitude_deg + 360.0;
      end if;
      aircraft_interface.set_longitude (aircraft.t_longitude (longitude_deg));
   end update_longitude;


   -------------------------------
   -- update the aircraft state
   -------------------------------
   procedure update(hz : Natural) is
   begin
      dt := 1.0 / Float(hz);

      update_longitude;
      update_latitude;

      update_heading;
      update_altitude;

      update_roll;
      update_pitch;

      update_velocity;
      update_vertspeed;
      update_roll_speed;
      update_pitch_speed;

      -- loopback control to status (simulating 0 delay effect of controls)
      declare
         aileron   : aircraft.t_aileron;
         elevator  : aircraft.t_elevator;
         rudder    : aircraft.t_rudder;
         throttle1 : aircraft.t_throttle;
         throttle2 : aircraft.t_throttle;
      begin
         aircraft_interface.get_control (aileron, elevator, rudder, throttle1, throttle2);
         aircraft_interface.set_aileron (aileron);
         aircraft_interface.set_elevator (elevator);
         aircraft_interface.set_rudder (rudder);
         aircraft_interface.set_throttle1 (throttle1);
         aircraft_interface.set_throttle2 (throttle2);
      end;

   end update;

end FDM;
