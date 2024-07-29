-------------------------------------------------------
-- Package COMIF.GPS
--
-- This package provides R/W access to the GPS status
-------------------------------------------------------

with HW;

package body COMIF.GPS is

   COMIF_GPS_status : t_GPS_status;
   for COMIF_GPS_status'Address use HW.GPS_status'Address;
   pragma Volatile (COMIF_GPS_status);

   function read (component : t_component) return t_GPS_status is
   begin
      pragma Assert (read_access (component, Comp_GPS));
      return COMIF_GPS_status;
   end read;

   procedure write (component : t_component; status : t_GPS_status) is
   begin
      pragma Assert (write_access (component, Comp_GPS));
      COMIF_GPS_status := status;
   end write;

   procedure reset is
   begin
      COMIF_GPS_status  := (0.0, 0.0, 0.0, 0.0, 0.0);
   end reset;

end COMIF.GPS;

