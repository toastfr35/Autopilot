-------------------------------------------------------
-- Package AFDS.IFACE.NAV
--
-- Read current NAV configuration
-------------------------------------------------------

with COMIF.NAV;

package AFDS.iface.NAV is

   subtype t_NAV_status  is COMIF.NAV.t_NAV_status;

   status  : t_NAV_status;

   procedure reset;
   procedure read;

end AFDS.iface.NAV;
