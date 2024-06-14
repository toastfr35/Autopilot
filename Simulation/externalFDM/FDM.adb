-------------------------------------------
-- An null FDM (does not do anything)
-------------------------------------------

pragma Warnings (off);

package body FDM is

   procedure set (latitude  : t_latitude;
                  longitude : t_longitude;
                  altitude  : t_altitude;
                  heading   : t_heading;
                  velocity  : t_velocity) is
   begin
      null;
   end set;

   procedure init is
   begin
      null;
   end init;

   procedure update(hz : Natural) is
   begin
      null;
   end update;

end FDM;
