-------------------------------------------
-- A very simplistic Flight Dynamic Model
-- For simulation/testing only
-------------------------------------------

with aircraft;

package FDM is

   procedure set (latitude  : aircraft.t_latitude;
                  longitude : aircraft.t_longitude;
                  altitude  : aircraft.t_altitude;
                  heading   : aircraft.t_heading;
                  velocity  : aircraft.t_velocity);

   procedure init;

   procedure update(hz : Natural);

end FDM;
