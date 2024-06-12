-------------------------------------------------------
-- Package AIRCRAFT
--
-- This package provides
-- * the types for the aircraft flight parameters
-- * read access to the aircraft status
-- * write access to the aircraft controls
-------------------------------------------------------

package aircraft is

   -- POSITION
   type t_latitude is delta 10.0 ** (-6) range -90.0 .. 90.0;
   for t_latitude'Size use 32;

   type t_longitude is delta 10.0 ** (-6) range -180.0 .. 180.0;
   for t_longitude'Size use 32;

   type t_altitude is delta 10.0 ** (-3) range -1000.0 .. 50000.0;
   for t_altitude'Size use 32;

   -- HEADING
   type t_heading is delta 10.0 ** (-6) range -360.0 .. 720.0;
   for t_heading'Size use 32;

   -- VELOCITY
   type t_velocity is delta 10.0 ** (-3) range 0.0 .. 10000.0;
   for t_velocity'Size use 32;

   -- ROLL
   type t_roll is delta 10.0 ** (-6) range -180.0 .. 180.0;
   for t_roll'Size use 32;

   -- PITCH
   type t_pitch is delta 10.0 ** (-6) range -180.0 .. 180.0;
   for t_pitch'Size use 32;

   -- VERTICAL SPEED
   type t_vertspeed is delta 10.0 ** (-3) range -1000.0 .. 1000.0;
   for t_vertspeed'Size use 32;

   type t_control is delta 10.0 ** (-3) range -100.0 .. 100.0;
   for t_control'Size use 32;

   type t_aileron is new t_control range -100.0 .. 100.0;
   type t_elevator is new t_control range -100.0 .. 100.0;
   type t_rudder is new t_control range -100.0 .. 100.0;
   type t_throttle is new t_control range 0.0 .. 100.0;

   -------------------------------
   -- Aircraft status
   -------------------------------
   package status is
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
      roll      : t_roll;
      pitch     : t_pitch;
      vertspeed : t_vertspeed;

      procedure step;
      -- step function for reading status data from the aircraft interface

   end status;


   -------------------------------
   -- Aircraft Controls
   -------------------------------
   package control is

      -- aircraft controls (output commands)
      procedure set_aileron (v : t_aileron);
      procedure set_elevator (v : t_elevator);
      procedure set_rudder (v : t_rudder);
      procedure set_throttles (v1, v2 : t_throttle);

      -- aircraft control information (output infos)
      procedure set_target_roll (v : t_roll);
      procedure set_target_pitch (v : t_pitch);
      procedure set_target_vertspeed (v : t_vertspeed);

      procedure step;
      -- step function for sending control data to the aircraft interface

   end control;



end aircraft;
