-------------------------------------------------------
-- Package GCAS.IFACE.AIRCRAFT
--
-- This package provides
-- * read access to the aircraft status for GCAS
-------------------------------------------------------

with IFACE.aircraft;

package body GCAS.iface.aircraft is

   -- GCAS view of aircraft status
   aircraft_status : t_aircraft_status;
       
   
   function status return t_aircraft_status is
   begin
      return aircraft_status;
   end status;

   
   procedure read is
   begin
      aircraft_status := Standard.IFACE.aircraft.status;   
   end read;
      
   
   procedure reset is
      init_value : t_aircraft_status;
      pragma Warnings (off, init_value);
   begin
      aircraft_status := init_value;
   end reset;
   
end GCAS.iface.aircraft;
