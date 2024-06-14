-------------------------------------------
-- A very simplistic Flight Dynamic Model
-- For simulation/testing only
-------------------------------------------

with IFACE.aircraft;
with math; use math;
with average;

package body FDM is

   roll_speed : Float := 0.0;
   pitch_speed : Float := 0.0;

   dt : Float;

   package avg_roll_speed is new average(10);

   -------------------------------
   -- set the aircraft state
   -------------------------------
   procedure set (latitude  : t_latitude;
                  longitude : t_longitude;
                  altitude  : t_altitude;
                  heading   : t_heading;
                  velocity  : t_velocity)
   is
   begin
      IFACE.aircraft.SIM.set_aileron (0.0);
      IFACE.aircraft.SIM.set_elevator (0.0);
      IFACE.aircraft.SIM.set_rudder (0.0);
      IFACE.aircraft.SIM.set_throttle1 (50.0);
      IFACE.aircraft.SIM.set_throttle2 (50.0);
      IFACE.aircraft.SIM.set_latitude (latitude);
      IFACE.aircraft.SIM.set_longitude (longitude);
      IFACE.aircraft.SIM.set_altitude (altitude);
      IFACE.aircraft.SIM.set_heading (heading);
      IFACE.aircraft.SIM.set_velocity (velocity);
      IFACE.aircraft.SIM.set_roll (0.0);
      IFACE.aircraft.SIM.set_pitch (0.0);
      IFACE.aircraft.SIM.set_vertspeed (0.0);
      roll_speed := 0.0;
      pitch_speed := 0.0;
      avg_roll_speed.reset;
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
      v : constant Float := Float (IFACE.aircraft.status.velocity);
      pitch : constant Float := Float (IFACE.aircraft.status.pitch);
      airbraking : constant Float := (v*v) / 50000.0;
      acceleration : constant Float := (Float(IFACE.aircraft.status.throttle1) + Float(IFACE.aircraft.status.throttle2)) / 16.0;
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

      IFACE.aircraft.SIM.set_velocity (t_velocity(v + dv));
   end update_velocity;


   -------------------------------
   -- pitch + velocity => vertspeed
   -------------------------------
   procedure update_vertspeed is
      v : Float := Float (IFACE.aircraft.status.vertspeed);
      n_v : Float;
      velocity : constant Float := Float (IFACE.aircraft.status.velocity);
      pitch : constant Float := Float (IFACE.aircraft.status.pitch);
   begin
      if pitch < 0.0 then
         -- going up
         n_v := velocity * fsin_deg (fabs(pitch));
      else
         -- going down
         n_v := - (velocity * fsin_deg (pitch));
         n_v := n_v * 1.2;
      end if;
      v := n_v / 2.0;
      saturate (v, -250.0, 150.0);
      IFACE.aircraft.SIM.set_vertspeed (t_vertspeed(v));
   end update_vertspeed;


   -------------------------------
   -- elevator => pitch_speed
   -------------------------------
   procedure update_pitch_speed is
      elevator : constant Float := Float(IFACE.aircraft.status.elevator);
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
      pitch : constant Float := Float (IFACE.aircraft.status.pitch);
      v : Float;
   begin
      v := pitch + pitch_speed * dt;
      saturate (v, Float(t_pitch'First), Float(t_pitch'Last));
      IFACE.aircraft.SIM.set_pitch (t_pitch (v));
   end update_pitch;


   -------------------------------
   -- vertspeed => altitude
   -------------------------------
   procedure update_altitude is
      v : Float;
   begin
      v := Float(IFACE.aircraft.status.altitude) + Float(IFACE.aircraft.status.vertspeed) * dt;
      IFACE.aircraft.SIM.set_altitude (t_altitude (v));
   end update_altitude;


   -------------------------------
   -- aileron => roll_speed
   -------------------------------
   procedure update_roll_speed is
      v : Float;
   begin
      -- aileron > 0 => roll right : roll angle --
      -- ailreon < 0 => roll left  : roll angle ++
      v := - Float(IFACE.aircraft.status.aileron) * 2.0;
      avg_roll_speed.add (v);
      roll_speed := avg_roll_speed.get;
   end update_roll_speed;


   -------------------------------
   -- roll_speed => roll
   -------------------------------
   procedure update_roll is
      v : Float;
   begin
      v := Float(IFACE.aircraft.status.roll) + roll_speed * dt;
      saturate (v, Float(t_roll'First), Float(t_roll'Last));
      IFACE.aircraft.SIM.set_roll (t_roll (v));
   end update_roll;


   -------------------------------
   -- roll + elevator + rudder => heading
   -------------------------------
   procedure update_heading is
      h : Float := Float (IFACE.aircraft.status.heading);
      d_h1 : Float;
      d_h2 : Float;
   begin
      -- roll + elevator
      -- roll < 0: heading++
      -- roll > 0: heading--
      d_h1 := -1.0 * fsin_deg(Float(IFACE.aircraft.status.roll)) * Float(IFACE.aircraft.status.elevator);
      d_h1 := d_h1 / 25.0;

      -- rudder
      d_h2 := (Float(IFACE.aircraft.status.rudder) / 100.0);

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

      IFACE.aircraft.SIM.set_heading (t_heading(h));
   end update_heading;


   -------------------------------
   -- heading + velocity => latitude
   -------------------------------
   procedure update_latitude is
      velocity_ms : constant Float := Float(IFACE.aircraft.status.velocity) * 0.514444; -- knots -> m/s
      northward_velocity_ms : constant Float := velocity_ms * fcos_deg(Float(IFACE.aircraft.status.heading));
      latitude_change_m : constant Float := northward_velocity_ms * dt;
      latitude_change_deg : constant Float := latitude_change_m / 111139.0;
      latitude_deg : Float := Float(IFACE.aircraft.status.latitude);
   begin
      latitude_deg := latitude_deg + latitude_change_deg;
      if latitude_deg > 90.0 then
         latitude_deg := latitude_deg - 180.0;
      end if;
      if latitude_deg < -90.0 then
         latitude_deg := latitude_deg + 180.0;
      end if;
      IFACE.aircraft.SIM.set_latitude (t_latitude (latitude_deg));
   end update_latitude;


   -------------------------------
   -- heading + velocity => longitude
   -------------------------------
   procedure update_longitude is
      velocity_ms : constant Float := Float(IFACE.aircraft.status.velocity) * 0.514444; -- knots -> m/s
      eastward_velocity_ms : constant Float := velocity_ms * fsin_deg(Float(IFACE.aircraft.status.heading));
      longitude_change_m : constant Float := eastward_velocity_ms * dt;
      longitude_change_deg : constant Float := longitude_change_m / (111320.0 * fcos_deg(Float(IFACE.aircraft.status.latitude)));
      longitude_deg : Float := Float(IFACE.aircraft.status.longitude);
   begin
      longitude_deg := longitude_deg + longitude_change_deg;
      if longitude_deg > 180.0 then
         longitude_deg := longitude_deg - 360.0;
      end if;
      if longitude_deg < -180.0 then
         longitude_deg := longitude_deg + 360.0;
      end if;
      IFACE.aircraft.SIM.set_longitude (t_longitude (longitude_deg));
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

      -- simulating 0 delay effect of controls
      IFACE.aircraft.SIM.apply_all_commands;
   end update;

end FDM;
