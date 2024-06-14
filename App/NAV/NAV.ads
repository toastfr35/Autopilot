-------------------------------------------------------
-- Package NAV
--
-- Waypoints navigation
-------------------------------------------------------

package NAV is

   procedure step;
   pragma Import (C, step, "NAV_step");
   -- Step for the autopilot function

   procedure reset;
   pragma Import (C, reset, "NAV_reset");
   -- Reset internal state

end NAV;
