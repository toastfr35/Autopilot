-------------------------------------------------------
-- Package CDU.IFACE.GCAS
--
-------------------------------------------------------

with COMIF.GCAS;

package CDU.iface.GCAS is

   subtype t_GCAS_status  is COMIF.GCAS.t_GCAS_status;

   status  : t_GCAS_status;

   procedure reset;
   procedure read;
   procedure write;

end CDU.iface.GCAS;
