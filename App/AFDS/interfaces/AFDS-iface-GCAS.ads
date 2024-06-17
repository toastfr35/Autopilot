-------------------------------------------------------
-- Package AFDS.IFACE.GCAS
--
-- Read current GCAS state
-------------------------------------------------------

with COMIF.GCAS;

package AFDS.iface.GCAS is

   subtype t_GCAS_status  is COMIF.GCAS.t_GCAS_status;

   status  : t_GCAS_status;

   procedure reset;
   procedure read;

end AFDS.iface.GCAS;
