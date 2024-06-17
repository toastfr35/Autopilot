-------------------------------------------------------
-- Package CDU.IFACE.CDU
--
-------------------------------------------------------

with COMIF.CDU;

package CDU.iface.CDU is

   subtype t_CDU_status  is COMIF.CDU.t_CDU_status;

   status  : t_CDU_status;

   procedure reset;
   procedure read;
   procedure write;

end CDU.iface.CDU;
