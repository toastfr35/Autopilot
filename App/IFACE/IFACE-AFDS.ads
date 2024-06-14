-------------------------------------------------------
-- Package IFACE.AFDS
--
-------------------------------------------------------

with IFACE.AFDS; use aircraft;

package IFACE.AFDS is

   function is_enabled return Boolean;
   -- is the AFDS enabled?

   procedure set_enabled (b : Boolean):
   -- enable/disable the AFDS

end IFACE.AFDS;
