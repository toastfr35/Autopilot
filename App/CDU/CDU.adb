-------------------------------------------------------
-- Package CDU
--
-- Control Display Unit
-- Enabled/Disable AFDS, NAV, GCAS
-- Edit waypoints
-------------------------------------------------------

with CDU.iface;
with CDU.impl;

package body CDU is

   -------------------------------
   -- Step for the CDU function
   -------------------------------
   procedure step is
   begin
      CDU.iface.read;
      CDU.impl.step;
      CDU.iface.write;
   end step;


   -------------------------------
   -- Reset internal state
   -------------------------------
   procedure reset is
   begin
      CDU.iface.reset;
      CDU.impl.reset;
   end reset;

end CDU;
