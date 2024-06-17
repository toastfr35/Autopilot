with HW;

package body COMIF.AFDS is

   COMIF_AFDS_status : t_AFDS_status;
   for COMIF_AFDS_status'Address use HW.AFDS_status'Address;
   pragma Volatile (COMIF_AFDS_status);

   function read_status (component : t_component) return t_AFDS_status is
   begin
      pragma Assert (read_access_status (component));
      return COMIF_AFDS_status;
   end read_status;

   procedure write_status (component : t_component; status : t_AFDS_status) is
   begin
      pragma Assert (write_access_status (component));
      COMIF_AFDS_status := status;
   end write_status;

   procedure reset is
   begin
      COMIF_AFDS_status := (False, False, (0.0, 0.0, 0.0));
   end reset;

end COMIF.AFDS;
