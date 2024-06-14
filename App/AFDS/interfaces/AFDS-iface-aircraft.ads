-------------------------------------------------------
-- Package AFDS.IFACE.AIRCRAFT
--
-- This package provides
-- * read access to the aircraft status for AFDS
-- * write access to the aircraft controls for AFDS
-------------------------------------------------------

with types; use types;

package AFDS.iface.aircraft is

   function status return t_aircraft_status;
   -- the aircraft status for AFDS

   package control is
      -- aircraft controls
      procedure set_aileron (v : t_aileron);
      procedure set_elevator (v : t_elevator);
      procedure set_rudder (v : t_rudder);
      procedure set_throttles (v1, v2 : t_throttle);

      -- aircraft control information (output infos)
      procedure set_target_roll (v : t_roll);
      procedure set_target_pitch (v : t_pitch);
      procedure set_target_vertspeed (v : t_vertspeed);
   end control;

   procedure read;
   -- update input

   procedure write;
   -- update output

   procedure reset;
   -- reset internal state

end AFDS.iface.aircraft;
