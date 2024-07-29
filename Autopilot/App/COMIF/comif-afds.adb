-------------------------------------------------------
-- Package COMIF.AFDS
--
-- This package provides R/W access to the AFDS status
-------------------------------------------------------

with HW;

package body COMIF.AFDS is

   COMIF_AFDS_status : t_AFDS_status;
   for COMIF_AFDS_status'Address use HW.AFDS_status'Address;
   pragma Volatile (COMIF_AFDS_status);

   function read (component : t_component) return t_AFDS_status is
   begin
      pragma Assert (read_access (component, Comp_AFDS));
      return COMIF_AFDS_status;
   end read;

   procedure write (component : t_component; status : t_AFDS_status) is
   begin
      pragma Assert (write_access (component, Comp_AFDS));
      COMIF_AFDS_status := status;
   end write;

   procedure reset is
   begin
      COMIF_AFDS_status := (False, False, (0.0, 0.0, 0.0));
   end reset;

end COMIF.AFDS;
