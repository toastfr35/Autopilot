-------------------------------------------------------
-- Package GCAS.IFACE.AIRCRAFT
--
-- This package provides
-- * read access to the aircraft status for AFDS
-- * write access to the aircraft controls for AFDS
-------------------------------------------------------

with COMIF.aircraft;

package GCAS.iface.aircraft is

   subtype t_aircraft_status is COMIF.aircraft.t_aircraft_status;

   status  : t_aircraft_status;

   procedure reset;
   procedure read;

end GCAS.iface.aircraft;
