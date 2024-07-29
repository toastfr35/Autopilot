-------------------------------------------------------
-- Package COMIF.ACS
--
-- This package provides R/W access to the aircraft status
-------------------------------------------------------

with HW;

package body COMIF.ACS is

   COMIF_ACS_status : t_ACS_status;
   for COMIF_ACS_status'Address use HW.aircraft_status'Address;
   pragma Volatile (COMIF_ACS_status);

   function read (component : t_component) return t_ACS_status is
   begin
      pragma Assert (read_access (component, Comp_ACS));
      return COMIF_ACS_status;
   end read;

   procedure write (component : t_component; status : t_ACS_status) is
   begin
      pragma Assert (write_access (component, Comp_ACS));
      COMIF_ACS_status := status;
   end write;

   procedure reset is
   begin
      COMIF_ACS_status  := (0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
   end reset;

end COMIF.ACS;

