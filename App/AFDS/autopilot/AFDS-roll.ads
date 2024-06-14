-------------------------------------------------------
-- Package AFDS.ROLL
--
-- Set the desired aileron control to reach the desired roll
-------------------------------------------------------

with types; use types;

private package AFDS.roll is

   procedure set_target (roll_angle : t_roll);
   -- Set the desired roll angle

   procedure set_emergency_override (enabled : Boolean; roll_angle : t_roll);
   -- Set the emergency roll angle

   procedure step;
   -- Step for the auto-roll function

   procedure reset;
   -- Reset internal state

end AFDS.roll;
