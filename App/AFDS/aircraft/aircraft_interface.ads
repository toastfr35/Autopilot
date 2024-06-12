-------------------------------------------------------
-- Package AIRCRAFT_INTERFACE
--
-- This package read and write access to the aircraft HW interface
-------------------------------------------------------

with aircraft; use aircraft;

package aircraft_interface is

   procedure read (aileron   : out t_aileron;
                   elevator  : out t_elevator;
                   rudder    : out t_rudder;
                   throttle1 : out t_throttle;
                   throttle2 : out t_throttle;
                   latitude  : out t_latitude;
                   longitude : out t_longitude;
                   altitude  : out t_altitude;
                   heading   : out t_heading;
                   velocity  : out t_velocity;
                   roll      : out t_roll;
                   pitch     : out t_pitch;
                   vertspeed : out t_vertspeed);

   procedure write (aileron_enabled   : in out Boolean;
                    aileron           : t_aileron;
                    elevator_enabled  : in out Boolean;
                    elevator          : t_elevator;
                    rudder_enabled    : in out Boolean;
                    rudder            : t_rudder;
                    throttle1_enabled : in out Boolean;
                    throttle1         : t_throttle;
                    throttle2_enabled : in out Boolean;
                    throttle2         : t_throttle;
                    target_roll       : t_roll;
                    target_pitch      : t_pitch;
                    target_vertspeed  : t_vertspeed
                   );


   -- For simulation only

   procedure get_control (aileron   : out t_aileron;
                          elevator  : out t_elevator;
                          rudder    : out t_rudder;
                          throttle1 : out t_throttle;
                          throttle2 : out t_throttle
                         );

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
   procedure set_roll      (v : t_roll);
   procedure set_pitch     (v : t_pitch);
   procedure set_vertspeed (v : t_vertspeed);

end aircraft_interface;
