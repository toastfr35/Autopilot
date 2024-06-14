-------------------------------------------------------
-- Package AFDS.VELOCITY
--
-- Set the desired throttle control to reach the desired velocity
-------------------------------------------------------

private package AFDS.velocity is

   procedure set_emergency_override (enabled : Boolean);
   -- Set the emergency velocity

   procedure step;
   -- Step for the auto-velocity function

   procedure reset;
   -- Reset internal state

end AFDS.velocity;
