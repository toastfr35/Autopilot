-------------------------------------------------------
-- Package CDU.IFACE.GCAS
--
-------------------------------------------------------

with COMIF.NAV;

package CDU.iface.NAV is

   subtype t_NAV_status  is COMIF.NAV.t_NAV_status;

   status  : t_NAV_status;

   procedure reset;
   procedure read;
   procedure write;

   -- DEBUG
   procedure dump;

end CDU.iface.NAV;
