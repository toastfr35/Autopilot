-------------------------------------------------------
-- Package AUTO_PITCH
--
-- Set the desired elevator control to reach the desired pitch
-------------------------------------------------------

with aircraft;

package auto_pitch is

   procedure set_target (pitch_angle : aircraft.t_pitch);
   -- Set the desired pitch angle

   procedure set_roll_elevator (v  : aircraft.t_elevator);
   -- Set the elevator control required for roll turn maneuver

   procedure set_emergency_override (enabled : Boolean; pitch_angle : aircraft.t_pitch);
   -- Set the emergency pitch angle

   procedure step;
   -- Step for the auto-pitch function

   procedure reset;
   -- Reset internal state

end auto_pitch;
