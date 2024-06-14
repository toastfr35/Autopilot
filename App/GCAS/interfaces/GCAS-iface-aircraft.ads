-------------------------------------------------------
-- Package GCAS.IFACE.AIRCRAFT
--
-- This package provides
-- * read access to the aircraft status for AFDS
-- * write access to the aircraft controls for AFDS
-------------------------------------------------------

with types; use types;

package GCAS.iface.aircraft is

   function status return t_aircraft_status;

   -- update input
   procedure read;

   -- reset internal state
   procedure reset;

end GCAS.iface.aircraft;
