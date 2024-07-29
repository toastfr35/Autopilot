-------------------------------------------------------
-- Package COMIF.ACS
--
-- This package provides R/W access to the aircraft status
-------------------------------------------------------

with types; use types;
with components; use components;

package COMIF.ACS is

   -------------------------------
   -- Data types
   -------------------------------

   type t_ACS_status is record
      aileron   : t_aileron;
      elevator  : t_elevator;
      rudder    : t_rudder;
      throttle1 : t_throttle;
      throttle2 : t_throttle;

      heading   : t_heading;
      airspeed  : t_hspeed;

      roll      : t_roll;
      pitch     : t_pitch;
   end record;
   for t_ACS_status use record
      aileron   at  0 range 0 .. 31;
      elevator  at  4 range 0 .. 31;
      rudder    at  8 range 0 .. 31;
      throttle1 at 12 range 0 .. 31;
      throttle2 at 16 range 0 .. 31;
      heading   at 20 range 0 .. 31;
      airspeed  at 24 range 0 .. 31;
      roll      at 28 range 0 .. 31;
      pitch     at 32 range 0 .. 31;
   end record;

   -------------------------------
   -- R/W access to data
   -------------------------------

   procedure reset;
   pragma Export (C, reset, "COMIF_ACS_reset");

   function read (component : t_component) return t_ACS_status;
   pragma Export (C, read, "COMIF_ACS_read");

   procedure write (component : t_component; status : t_ACS_status);
   pragma Export (C, write, "COMIF_ACS_write");

end COMIF.ACS;
