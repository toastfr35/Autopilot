-------------------------------------------------------
-- Package AUTO_VELOCITY
--
-- Set the desired throttle control to reach the desired velocity
-------------------------------------------------------

with aircraft; use aircraft;
with nav_AFDS;
with ctrl_throttle;

with log;
with img;

package body auto_velocity is

   type t_velocity_correction is delta 10.0 ** (-3) range -10000.0 .. 10000.0;

   current_throttle : Float := 100.0;
   emergency_enabled : Boolean := False;
   prev_target_velocity : t_velocity := 0.0;

   -------------------------------
   -- Reset internal state
   -------------------------------
   procedure reset is
   begin
      current_throttle := 100.0;
      emergency_enabled := False;
      prev_target_velocity := 0.0;
   end reset;


   -------------------------------
   -- Set the emergency velocity
   -------------------------------
   procedure set_emergency_override (enabled : Boolean) is
   begin
      emergency_enabled := enabled;
   end set_emergency_override;


   -------------------------------
   -- Compute the velocity correction to apply
   -------------------------------
   function velocity_correction return t_velocity_correction is
      v : constant t_velocity := aircraft.status.velocity;
      v_t : constant t_velocity := nav_AFDS.get_velocity;
   begin
      if v_t /=  prev_target_velocity then
         pragma Debug (log.log (log.velocity, 1, 0, "Target velocity:" & img.Image(float(v_t))));
         prev_target_velocity := v_t;
      end if;
      return t_velocity_correction (Float(v_t) - Float(v));
   end velocity_correction;


   -------------------------------
   -- Step for the auto-velocity function
   -------------------------------
   procedure step is
      correction : constant t_velocity_correction := velocity_correction;
      increment : constant Float := Float(correction) / 1000.0;
   begin
      current_throttle := current_throttle + increment;

      if current_throttle < 5.0 then
         current_throttle := 5.0;
      end if;

      if current_throttle > 100.0 then
         current_throttle := 100.0;
      end if;

      if emergency_enabled then
         current_throttle := 100.0;
      end if;

      --log.log ("VC:" & Image(correction) & "  TH:" & Image(current_throttle));

      ctrl_throttle.set_target (t_throttle(current_throttle), t_throttle(current_throttle));
   end step;

end auto_velocity;
