with HW;

package body COMIF.aircraft is

   COMIF_aircraft_status : t_aircraft_status;
   for COMIF_aircraft_status'Address use HW.aircraft_status'Address;
   pragma Volatile (COMIF_aircraft_status);

   COMIF_aircraft_control : t_aircraft_control;
   for COMIF_aircraft_control'Address use HW.aircraft_control'Address;
   pragma Volatile (COMIF_aircraft_control);

   function read_status (component : t_component) return t_aircraft_status is
   begin
      pragma Assert (read_access_status (component));
      return COMIF_aircraft_status;
   end read_status;

   function read_control (component : t_component) return t_aircraft_control is
   begin
      pragma Assert (read_access_control (component));
      return COMIF_aircraft_control;
   end read_control;

   procedure write_status (component : t_component; status : t_aircraft_status) is
   begin
      pragma Assert (write_access_status (component));
      COMIF_aircraft_status := status;
   end write_status;

   procedure write_control (component : t_component; control : t_aircraft_control) is
   begin
      pragma Assert (write_access_control (component));
      COMIF_aircraft_control := control;
   end write_control;

   procedure reset is
   begin
      COMIF_aircraft_status  := (0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
      COMIF_aircraft_control := (0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
   end reset;

end COMIF.aircraft;

