-------------------------------------------------------
-- Package AUTO_PITCH
--
-- Set the desired elevator control to reach the desired pitch
-------------------------------------------------------

with math; use math;

with aircraft; use aircraft;
with ctrl_elevator;


package body auto_pitch is

   type t_pitch_correction is delta 10.0 ** (-6) range -360.0 .. 360.0;

   subtype t_elevator_limit is Float range -70.0 ..70.0;
   subtype t_elevator_emergency_limit is Float range -70.0 ..100.0;

   target_pitch_angle : t_pitch := 0.0;
   roll_elevator : t_elevator := 0.0;
   emergency_pitch_angle : t_pitch := 0.0;
   emergency_enabled : Boolean := False;


   -------------------------------
   -- Reset internal state
   -------------------------------
   procedure reset is
   begin
      target_pitch_angle := 0.0;
      roll_elevator := 0.0;
      emergency_pitch_angle := 0.0;
      emergency_enabled := False;
   end reset;


   -------------------------------
   -- Target pitch angle to maintain
   -------------------------------
   procedure set_target (pitch_angle : aircraft.t_pitch) is
   begin
      if target_pitch_angle /= pitch_angle then
         target_pitch_angle := pitch_angle;
      end if;
   end set_target;


   -------------------------------
   -- Set the emergency pitch angle
   -------------------------------
   procedure set_emergency_override (enabled : Boolean; pitch_angle : aircraft.t_pitch) is
   begin
      emergency_enabled := enabled;
      emergency_pitch_angle := pitch_angle;
   end set_emergency_override;


   -------------------------------
   -- Set the elevator control required for roll turn maneuver
   -------------------------------
   procedure set_roll_elevator (v  : aircraft.t_elevator) is
   begin
      roll_elevator := v;
   end set_roll_elevator;


   -------------------------------
   -- Compute the pitch correction to apply
   -------------------------------
   function pitch_correction return t_pitch_correction is
   begin
      if emergency_enabled then
         aircraft.control.set_target_pitch (emergency_pitch_angle);
         return t_pitch_correction (emergency_pitch_angle - aircraft.status.pitch);
      else
         aircraft.control.set_target_pitch (target_pitch_angle);
         return t_pitch_correction (target_pitch_angle - aircraft.status.pitch);
      end if;
   end pitch_correction;


   -------------------------------
   -- Step for the auto-pitch function
   -------------------------------
   procedure step is
      correction : constant Float := Float(pitch_correction);
      target_elevator : Float := 0.0;
      G : constant Float := 1.5;
      G_roll : Float;
   begin
      -- correction > 0.0 then go down (elevator negative)
      -- correction < 0.0 then go up (elevator positive)
      target_elevator := G * (-correction);

      -- G_roll = 3 - 2 * cos(abs(R)) = 1 .. 3
      -- R = 0  deg => G_roll = 1    cos(R) = 1
      -- R = 90 deg => G_roll = 3    cos(R) = 0
      if fabs (Float (aircraft.status.roll)) < 90.0 then
         G_roll := 3.0 - 2.0 * fcos (fabs (Float (aircraft.status.roll) * Pi / 180.0));
      else
         G_roll := 1.0;
      end if;
      target_elevator := target_elevator * G_roll;

      -- increase the elevator control if required by roll turn maneuver
      if roll_elevator > 0.0 then
         if target_elevator < Float(roll_elevator) then
            target_elevator := Float(roll_elevator);
         end if;
      end if;

      -- enforce min/max
      if emergency_enabled then
         target_elevator := Float'Max(target_elevator, t_elevator_limit'First);
         target_elevator := Float'Min(target_elevator, t_elevator_limit'Last);
      else
         target_elevator := Float'Max(target_elevator, t_elevator_emergency_limit'First);
         target_elevator := Float'Min(target_elevator, t_elevator_emergency_limit'Last);
      end if;

      --pragma Debug (log.log (log.pitch, 100, 0, "ELEVATOR:" & img.Image(target_elevator)));

      ctrl_elevator.set_target (t_elevator(target_elevator));
   end step;

end auto_pitch;
