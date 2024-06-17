with HW;

package body COMIF.GCAS is

   COMIF_GCAS_status : t_GCAS_status;
   for COMIF_GCAS_status'Address use HW.GCAS_status'Address;
   pragma Volatile (COMIF_GCAS_status);

   function read_status (component : t_component) return t_GCAS_status is
   begin
      pragma Assert (read_access_status (component));
      return COMIF_GCAS_status;
   end read_status;

   procedure write_status (component : t_component; status : t_GCAS_status) is
   begin
      pragma Assert (write_access_status (component));
      COMIF_GCAS_status := status;
   end write_status;

   procedure reset is
   begin
      COMIF_GCAS_status := (False, types.GCAS_state_disengaged);
   end reset;

end COMIF.GCAS;
