-------------------------------------------------------
-- Package NAV
--
-- Waypoints navigation
-------------------------------------------------------

package NAV is

   procedure step
      with Import => True, Convention => C, External_Name => "NAV_step";
   -- Step for the autopilot function

   procedure reset
      with Import => True, Convention => C, External_Name => "NAV_reset";
   -- Reset internal state

end NAV;
