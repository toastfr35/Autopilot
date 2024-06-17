-------------------------------------------------------
-- Package AFDS.IFACE.AFDS
--
-- Read current AFDS configuration
-------------------------------------------------------

with COMIF.AFDS;

package AFDS.iface.AFDS is

   subtype t_AFDS_status  is COMIF.AFDS.t_AFDS_status;

   status  : t_AFDS_status;

   procedure reset;
   procedure read;
   procedure write;

end AFDS.iface.AFDS;
