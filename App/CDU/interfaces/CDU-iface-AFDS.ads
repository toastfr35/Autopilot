-------------------------------------------------------
-- Package CDU.IFACE.AFDS
--
-- Configure the AFDS parameters
-- Read current AFDS configuration
-------------------------------------------------------

with COMIF.AFDS;

package CDU.iface.AFDS is

   subtype t_AFDS_status is COMIF.AFDS.t_AFDS_status;

   status  : t_AFDS_status;

   procedure reset;
   procedure read;
   procedure write;

end CDU.iface.AFDS;
