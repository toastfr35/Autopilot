-------------------------------------------
-- A very simplistic Flight Dynamic Model
-- For simulation/testing only
-------------------------------------------

with types; use types;
with Interfaces.C; use Interfaces.C;

package FDM is

   procedure set (latitude  : t_latitude;
                  longitude : t_longitude;
                  altitude  : t_altitude;
                  heading   : t_heading;
                  speed     : t_hspeed)
      with Export => True, Convention => C, External_Name => "FDM_set";

   procedure init
      with Export => True, Convention => C, External_Name => "FDM_init";

   procedure update(hz : Natural)
      with Export => True, Convention => C, External_Name => "FDM_update";

end FDM;
