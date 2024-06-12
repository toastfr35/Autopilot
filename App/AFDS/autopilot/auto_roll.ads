-------------------------------------------------------
-- Package AUTO_ROLL
--
-- Set the desired aileron control to reach the desired roll
-------------------------------------------------------

with aircraft;

package auto_roll is

   procedure set_target (roll_angle : aircraft.t_roll);
   -- Set the desired roll angle

   procedure set_emergency_override (enabled : Boolean; roll_angle : aircraft.t_roll);
   -- Set the emergency roll angle

   procedure step;
   -- Step for the auto-roll function

   procedure reset;
   -- Reset internal state

end auto_roll;
