-------------------------------------------------------
-- Package COMIF.AIRCRAFT
--
-- This package provides R/W access to the aircraft status
-- This package provides R/W access to the aircraft controls
-------------------------------------------------------

with types; use types;
with components; use components;

package COMIF.aircraft is

   -------------------------------
   -- R/W access rights
   -------------------------------
   read_access_status   : constant t_access_rights := (Comp_AFDS => True,  Comp_GCAS => True,  Comp_NAV => True,  Comp_CDU => False, Comp_FDM => True,  Comp_TEST => True);
   write_access_status  : constant t_access_rights := (Comp_AFDS => False, Comp_GCAS => False, Comp_NAV => False, Comp_CDU => False, Comp_FDM => True,  Comp_TEST => True);
   read_access_control  : constant t_access_rights := (Comp_AFDS => True,  Comp_GCAS => False, Comp_NAV => False, Comp_CDU => False, Comp_FDM => True,  Comp_TEST => True);
   write_access_control : constant t_access_rights := (Comp_AFDS => True,  Comp_GCAS => False, Comp_NAV => False, Comp_CDU => False, Comp_FDM => True,  Comp_TEST => True);


   -------------------------------
   -- Data types
   -------------------------------

   type t_aircraft_status is record
      aileron   : t_aileron;
      elevator  : t_elevator;
      rudder    : t_rudder;
      throttle1 : t_throttle;
      throttle2 : t_throttle;

      latitude  : t_latitude;
      longitude : t_longitude;
      altitude  : t_altitude;

      heading   : t_heading;
      velocity  : t_velocity;
      vertspeed : t_vertspeed;

      roll      : t_roll;
      pitch     : t_pitch;
   end record;
   for t_aircraft_status use record
      aileron   at  0 range 0 .. 31;
      elevator  at  4 range 0 .. 31;
      rudder    at  8 range 0 .. 31;
      throttle1 at 12 range 0 .. 31;
      throttle2 at 16 range 0 .. 31;
      latitude  at 20 range 0 .. 31;
      longitude at 24 range 0 .. 31;
      altitude  at 28 range 0 .. 31;
      heading   at 32 range 0 .. 31;
      velocity  at 36 range 0 .. 31;
      vertspeed at 40 range 0 .. 31;
      roll      at 44 range 0 .. 31;
      pitch     at 48 range 0 .. 31;
   end record;

   type t_aircraft_control is record
      command_aileron     : t_aileron;
      command_elevator    : t_elevator;
      command_rudder      : t_rudder;
      command_throttle1   : t_throttle;
      command_throttle2   : t_throttle;
      target_roll         : t_roll;
      target_pitch        : t_pitch;
      target_vertspeed    : t_vertspeed;
   end record;
   for t_aircraft_control use record
      command_aileron    at  0 range 0 .. 31;
      command_elevator   at  4 range 0 .. 31;
      command_rudder     at  8 range 0 .. 31;
      command_throttle1  at 12 range 0 .. 31;
      command_throttle2  at 16 range 0 .. 31;
      target_roll        at 20 range 0 .. 31;
      target_pitch       at 24 range 0 .. 31;
      target_vertspeed   at 28 range 0 .. 31;
   end record;

   -------------------------------
   -- R/W access to data
   -------------------------------

   procedure reset;
   pragma Export (C, reset, "COMIF_aircraft_reset");

   function read_status (component : t_component) return t_aircraft_status;
   pragma Export (C, read_status, "COMIF_aircraft_read_status");

   function read_control (component : t_component) return t_aircraft_control;
   pragma Export (C, read_control, "COMIF_aircraft_read_control");

   procedure write_status (component : t_component; status : t_aircraft_status);
   pragma Export (C, write_status, "COMIF_aircraft_write_status");

   procedure write_control (component : t_component; control : t_aircraft_control);
   pragma Export (C, write_control, "COMIF_aircraft_write_control");

end COMIF.aircraft;
