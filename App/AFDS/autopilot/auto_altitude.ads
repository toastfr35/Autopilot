-------------------------------------------------------
-- Package AUTO_ALTITUDE
--
-- Set the desired vertical speed to reach the desired altitude
-------------------------------------------------------

package auto_altitude is

   procedure step;
   -- Step function for the auto-altitude function

   procedure reset;
   -- Reset internal state

end auto_altitude;
