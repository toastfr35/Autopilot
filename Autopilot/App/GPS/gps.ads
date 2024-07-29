-------------------------------------------------------
-- Package GPS
--
-- Global Positioning System
-------------------------------------------------------

package GPS is

   procedure step
      with Import => True, Convention => C, External_Name => "GPS_step";
   -- Step for the GPS function

   procedure reset
      with Import => True, Convention => C, External_Name => "GPS_reset";
   -- Reset internal state

end GPS;
