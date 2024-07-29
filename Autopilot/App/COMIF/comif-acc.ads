-------------------------------------------------------
-- Package COMIF.ACC
--
-- This package provides R/W access to the aircraft controls
-------------------------------------------------------

with types; use types;
with components; use components;

package COMIF.ACC is

   -------------------------------
   -- Data types
   -------------------------------

   type t_ACC_control is record
      command_aileron     : t_aileron;
      command_elevator    : t_elevator;
      command_rudder      : t_rudder;
      command_throttle1   : t_throttle;
      command_throttle2   : t_throttle;
      target_roll         : t_roll;
      target_pitch        : t_pitch;
      target_vertspeed    : t_vspeed;
   end record;
   for t_ACC_control use record
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
   pragma Export (C, reset, "COMIF_ACC_reset");

   function read (component : t_component) return t_ACC_control;
   pragma Export (C, read, "COMIF_ACC_read");

   procedure write (component : t_component; control : t_ACC_control);
   pragma Export (C, write, "COMIF_ACC_write");

end COMIF.ACC;
