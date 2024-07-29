-------------------------------------------------------
-- Package CDU
--
-- Control Display Unit
-- Enabled/Disable AFDS, NAV, GCAS
-- Edit waypoints
-------------------------------------------------------

package CDU.impl is

   procedure step;
   -- Step for the CDU function

   procedure reset;
   -- Reset internal state

end CDU.impl;
