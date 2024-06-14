-------------------------------------------------------
-- Package GCAS.IFACE.GCAS
--
-------------------------------------------------------

with IFACE.GCAS;

package body GCAS.iface.GCAS is

   state : t_GCAS_state;

   procedure set_state (v : t_GCAS_state) is
   begin
      state := v;
   end set_state;


   function get_state return t_GCAS_state is
   begin
      return state;
   end get_state;


   procedure reset is
   begin
      state := GCAS_state_disengaged;
   end reset;


   procedure read is
   begin
      state := Standard.IFACE.GCAS.get_state;
   end read;


   procedure write is
   begin
      Standard.IFACE.GCAS.set_state (state);
   end write;


end GCAS.iface.GCAS;
