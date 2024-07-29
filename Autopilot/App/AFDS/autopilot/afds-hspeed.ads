-------------------------------------------------------
-- Package AFDS.HSPEED
--
-- Set the desired throttle control to reach the desired horizontal speed
-------------------------------------------------------

private package AFDS.hspeed is

   procedure set_emergency_override (enabled : Boolean);
   -- Set the emergency hspeed

   procedure step;
   -- Step for the auto-hspeed function

   procedure reset;
   -- Reset internal state

end AFDS.hspeed;
