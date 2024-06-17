-------------------------------------------------------
-- Package AFDS.IFACE.AIRCRAFT
--
-- Read current aircraft status
-- Write to aircraft controls
-------------------------------------------------------

package body AFDS.iface.aircraft is

   procedure reset is
   begin
      COMIF.aircraft.reset;
      read;
   end reset;

   procedure read is
   begin
      status := COMIF.aircraft.read_status (current_component);
      control := COMIF.aircraft.read_control (current_component);
   end read;

   procedure write is
   begin
      COMIF.aircraft.write_control (current_component, control);
   end write;

end AFDS.iface.aircraft;
