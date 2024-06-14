-------------------------------------------
-- An null FDM (does not do anything)
-- This is to be used when MSFS is used as FDM
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
