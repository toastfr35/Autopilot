-------------------------------------------------------
-- Package AFDS.IFACE.GCAS
--
-- Read current GCAS state
-------------------------------------------------------

with IFACE.GCAS;

package body AFDS.iface.GCAS is

   -------------------------------
   --
   -------------------------------
   state : t_GCAS_state;

   function get_state return t_GCAS_state is
   begin
      return state;
   end get_state;


   -------------------------------
   --
   -------------------------------
   procedure reset is
   begin
      state := GCAS_state_disengaged;
   end reset;


   -------------------------------
   --
   -------------------------------
   procedure read is
   begin
      state := Standard.IFACE.GCAS.get_state;
   end read;


end AFDS.iface.GCAS;
