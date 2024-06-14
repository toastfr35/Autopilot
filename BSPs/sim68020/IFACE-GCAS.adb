package body IFACE.GCAS is

   state : t_GCAS_state;


   procedure set_state (v : t_GCAS_state) is
   begin
      state := v;
   end set_state;


   function get_state return t_GCAS_state is
   begin
      return state;
   end get_state;


end IFACE.GCAS;
