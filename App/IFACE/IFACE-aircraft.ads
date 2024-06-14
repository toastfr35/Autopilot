-------------------------------------------------------
-- Package IFACE.AIRCRAFT
--
-- This package provides access to the aircraft HW interface
-------------------------------------------------------

with types; use types;

package IFACE.aircraft is

   -- read aircraft status
   function status return t_aircraft_status;
   pragma Export (C, status, "IFACE_aircraft_status");

   -- send a control command
   package control is
      procedure command_aileron   (v : t_aileron);
      procedure command_elevator  (v : t_elevator);
      procedure command_rudder    (v : t_rudder);
      procedure command_throttle1 (v : t_throttle);
      procedure command_throttle2 (v : t_throttle);
      procedure target_roll       (v : t_roll);
      procedure target_pitch      (v : t_pitch);
      procedure target_vertspeed  (v : t_vertspeed);
   end control;

   -- only for simulation
   package SIM is
      procedure set_aileron   (v : t_aileron);
      procedure set_elevator  (v : t_elevator);
      procedure set_rudder    (v : t_rudder);
      procedure set_throttle1 (v : t_throttle);
      procedure set_throttle2 (v : t_throttle);
      procedure set_latitude  (v : t_latitude);
      procedure set_longitude (v : t_longitude);
      procedure set_altitude  (v : t_altitude);
      procedure set_heading   (v : t_heading);
      procedure set_velocity  (v : t_velocity);
      procedure set_vertspeed (v : t_vertspeed);
      procedure set_roll      (v : t_roll);
      procedure set_pitch     (v : t_pitch);
      procedure apply_all_commands;
   end SIM;

end IFACE.aircraft;
