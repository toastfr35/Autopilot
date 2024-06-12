-------------------------------------------
-- An null FDM (does not do anything)
-------------------------------------------

pragma Warnings (off);

package body FDM is

   procedure set (latitude  : aircraft.t_latitude;
                  longitude : aircraft.t_longitude;
                  altitude  : aircraft.t_altitude;
                  heading   : aircraft.t_heading;
                  velocity  : aircraft.t_velocity) is
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
