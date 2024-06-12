-------------------------------------------------------
-- Package NAV_AFDS
--
-- Configure the AFDS parameters
-- Read current AFDS configuration
-------------------------------------------------------

with nav_interface;

package body nav_AFDS is

   AFDS : nav_interface.t_AFDS;

   function is_enabled return Boolean is begin
      return AFDS.enabled;
   end is_enabled;

   function get_heading return aircraft.t_heading is
   begin
      return AFDS.heading;
   end get_heading;

   function get_altitude return aircraft.t_altitude is
   begin
      return AFDS.altitude;
   end get_altitude;

   function get_velocity return aircraft.t_velocity is
   begin
      return AFDS.velocity;
   end get_velocity;

   procedure step is
   begin
      nav_interface.update (AFDS);
   end step;

end nav_AFDS;
