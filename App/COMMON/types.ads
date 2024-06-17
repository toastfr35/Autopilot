-------------------------------------------------------
-- Package TYPES
--
-- This package provides type definition used across all modules
-------------------------------------------------------

package types is

   -- Base types

   subtype t_Bool32 is Boolean;

   -- Aircraft position

   type t_latitude is delta 10.0 ** (-6) range -90.0 .. 90.0;
   for t_latitude'Size use 32;

   type t_longitude is delta 10.0 ** (-6) range -180.0 .. 180.0;
   for t_longitude'Size use 32;

   type t_altitude is delta 10.0 ** (-3) range -1000.0 .. 50000.0;
   for t_altitude'Size use 32;

   -- Aircraft motion

   type t_heading is delta 10.0 ** (-6) range -360.0 .. 720.0;
   for t_heading'Size use 32;

   type t_velocity is delta 10.0 ** (-3) range 0.0 .. 10000.0;
   for t_velocity'Size use 32;

   type t_vertspeed is delta 10.0 ** (-3) range -1000.0 .. 1000.0;
   for t_vertspeed'Size use 32;

   -- Aircraft attitude

   type t_roll is delta 10.0 ** (-6) range -180.0 .. 180.0;
   for t_roll'Size use 32;

   type t_pitch is delta 10.0 ** (-6) range -180.0 .. 180.0;
   for t_pitch'Size use 32;

   -- Aircraft controls
   type t_control is delta 10.0 ** (-3) range -100.0 .. 100.0;
   for t_control'Size use 32;

   type t_aileron is new t_control range -100.0 .. 100.0;
   type t_elevator is new t_control range -100.0 .. 100.0;
   type t_rudder is new t_control range -100.0 .. 100.0;
   type t_throttle is new t_control range 0.0 .. 100.0;

   type t_nav_target is record
      heading : t_heading;
      altitude : t_altitude;
      velocity : t_velocity;
   end record;

   -- GCAS
   type t_GCAS_state is (GCAS_state_disengaged, GCAS_state_emergency, GCAS_state_recovery, GCAS_state_stabilize);
   for t_GCAS_state'Size use 32;

   -- NAV
   type t_waypoint is record
      ID        : Natural;
      latitude  : t_latitude;
      longitude : t_longitude;
      altitude  : t_altitude;
      velocity  : t_velocity;
   end record;
   for t_waypoint use record
      ID        at  0 range 0 .. 31;
      latitude  at  4 range 0 .. 31;
      longitude at  8 range 0 .. 31;
      altitude  at 12 range 0 .. 31;
      velocity  at 16 range 0 .. 31;
   end record;

   type t_waypoints is array (Natural range 1..128) of t_waypoint;


end types;
