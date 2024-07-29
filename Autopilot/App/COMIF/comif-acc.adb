-------------------------------------------------------
-- Package COMIF.ACC
--
-- This package provides R/W access to the aircraft controls
-------------------------------------------------------

with HW;

package body COMIF.ACC is

   COMIF_ACC_control : t_ACC_control;
   for COMIF_ACC_control'Address use HW.aircraft_control'Address;
   pragma Volatile (COMIF_ACC_control);

   function read (component : t_component) return t_ACC_control is
   begin
      pragma Assert (read_access (component, Comp_ACC));
      return COMIF_ACC_control;
   end read;

   procedure write (component : t_component; control : t_ACC_control) is
   begin
      pragma Assert (write_access (component, Comp_ACC));
      COMIF_ACC_control := control;
   end write;

   procedure reset is
   begin
      COMIF_ACC_control := (0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
   end reset;

end COMIF.ACC;

