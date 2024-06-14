-------------------------------------------------------
-- Package AFDS.ALTITUDE
--
-- Set the desired vertical speed to reach the desired altitude
-------------------------------------------------------

private package AFDS.altitude is

   procedure step;
   -- Step function for the auto-altitude function

   procedure reset;
   -- Reset internal state

end AFDS.altitude;
