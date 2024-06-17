-------------------------------------------------------
-- Package AFDS.IFACE.AIRCRAFT
--
-- Read current aircraft status
-- Write to aircraft controls
-------------------------------------------------------

with COMIF.aircraft;

package AFDS.iface.aircraft is

   subtype t_aircraft_status  is COMIF.aircraft.t_aircraft_status;
   subtype t_aircraft_control is COMIF.aircraft.t_aircraft_control;

   status  : t_aircraft_status;
   control : t_aircraft_control;

   procedure reset;
   procedure read;
   procedure write;

end AFDS.iface.aircraft;
