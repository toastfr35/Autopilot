with HW;

package body COMIF.CDU is

   COMIF_CDU_status : t_CDU_status;
   for COMIF_CDU_status'Address use HW.CDU_status'Address;
   pragma Volatile (COMIF_CDU_status);

   function read_status (component : t_component) return t_CDU_status is
   begin
      pragma Assert (read_access_status (component));
      return COMIF_CDU_status;
   end read_status;

   procedure write_status (component : t_component; status : t_CDU_status) is
   begin
      pragma Assert (write_access_status (component));
      COMIF_CDU_status := status;
   end write_status;

   procedure reset is
   begin
      COMIF_CDU_status := (False, False, False, CDU_act_NONE, False, null_action_data);
   end reset;

end COMIF.CDU;
