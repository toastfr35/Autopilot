-------------------------------------------------------
-- Package GCAS.IFACE.AIRCRAFT
--
-- This package provides
-- * read access to the aircraft status for GCAS
-------------------------------------------------------

package body GCAS.iface.aircraft is

   procedure reset is
   begin
      COMIF.aircraft.reset;
      read;
   end reset;

   procedure read is
   begin
      status := COMIF.aircraft.read_status (current_component);
   end read;

end GCAS.iface.aircraft;
