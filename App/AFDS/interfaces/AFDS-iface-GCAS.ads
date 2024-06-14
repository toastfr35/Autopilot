-------------------------------------------------------
-- Package AFDS.IFACE.GCAS
--
-- Read current GCAS state
-------------------------------------------------------

with types; use types;

package AFDS.iface.GCAS is

   procedure reset;
   -- reset internal state

   procedure read;

   function get_state return t_GCAS_state;

end AFDS.iface.GCAS;
