-------------------------------------------------------
-- Package GCAS.IFACE.GCAS
--
-------------------------------------------------------

with COMIF.GCAS;

package GCAS.iface.GCAS is

   subtype t_GCAS_status  is COMIF.GCAS.t_GCAS_status;

   status  : t_GCAS_status;

   procedure reset;
   procedure read;
   procedure write;

end GCAS.iface.GCAS;
