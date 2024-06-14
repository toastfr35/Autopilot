-------------------------------------------------------
-- Package GCAS.IFACE.GCAS
--
-------------------------------------------------------

with types; use types;

package GCAS.iface.GCAS is

   procedure reset;

   procedure read;

   procedure write;

   procedure set_state (v : t_GCAS_state);

   function get_state return t_GCAS_state;

end GCAS.iface.GCAS;
