-------------------------------------------
-- A very simplistic Flight Dynamic Model
-- For simulation/testing only
-------------------------------------------

with types; use types;

package FDM is

   procedure set (latitude  : t_latitude;
                  longitude : t_longitude;
                  altitude  : t_altitude;
                  heading   : t_heading;
                  velocity  : t_velocity);

   procedure init;

   procedure update(hz : Natural);

end FDM;
