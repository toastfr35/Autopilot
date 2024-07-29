-------------------------------------------------------
-- Package TYPES
--
-- This package provides type definition used across all modules
-------------------------------------------------------

with Interfaces;

package types is

   -- Base types

   subtype t_Bool32 is Boolean;


   -- Terrain
   type t_elevation is new Interfaces.Unsigned_16;

   -- Aircraft position

   type t_latitude is delta 10.0 ** (-9) range -90.0 .. 90.0;
   for t_latitude'Size use 64;

   type t_longitude is delta 10.0 ** (-9) range -180.0 .. 180.0;
   for t_longitude'Size use 64;

   type t_altitude is delta 10.0 ** (-3) range -1000.0 .. 50000.0;
   for t_altitude'Size use 32;

   -- Aircraft motion

   type t_heading is delta 10.0 ** (-6) range -360.0 .. 720.0;
   for t_heading'Size use 32;

   type t_hspeed is delta 10.0 ** (-3) range 0.0 .. 10000.0;
   for t_hspeed'Size use 32;

   type t_vspeed is delta 10.0 ** (-3) range -1000.0 .. 1000.0;
   for t_vspeed'Size use 32;

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
      heading  : t_heading;
      altitude : t_altitude;
      hspeed   : t_hspeed;
   end record;

   -- GCAS
   type t_GCAS_state is (GCAS_state_disengaged, GCAS_state_stabilize, GCAS_state_recovery, GCAS_state_emergency);
   for t_GCAS_state'Size use 32;

   -- NAV
   type t_waypoint is record
      latitude  : t_latitude;
      longitude : t_longitude;
      altitude  : t_altitude;
      hspeed    : t_hspeed;
      ID        : Natural;
      padding   : Natural;
   end record;
   for t_waypoint'Size use 256;
   for t_waypoint use record
      latitude  at  0 range 0 .. 63;
      longitude at  8 range 0 .. 63;
      altitude  at 16 range 0 .. 31;
      hspeed    at 20 range 0 .. 31;
      ID        at 24 range 0 .. 31;
      padding   at 28 range 0 .. 31;
   end record;

   type t_waypoints is array (Natural range 1..64) of t_waypoint;
   for t_waypoints'Size use (256 * 64);


end types;
