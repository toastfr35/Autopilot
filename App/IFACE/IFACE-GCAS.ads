-------------------------------------------------------
-- Package IFACE.GCAS
--
-------------------------------------------------------

with types; use types;

package IFACE.GCAS is

   function get_state return t_GCAS_state;

   procedure set_state (v : t_GCAS_state);

end IFACE.GCAS;
