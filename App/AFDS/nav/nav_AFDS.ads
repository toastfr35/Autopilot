-------------------------------------------------------
-- Package NAV_AFDS
--
-- Configure the AFDS parameters
-- Read current AFDS configuration
-------------------------------------------------------

with aircraft;

package nav_AFDS is

   procedure step;

   -------------------------------
   -- getting current AFDS configuration
   -------------------------------

   function is_enabled return Boolean;
   -- is the AFDS enabled?

   function get_heading return aircraft.t_heading;
   -- the desired heading to maintain

   function get_altitude return aircraft.t_altitude;
   -- the desired altitude to maintain

   function get_velocity return aircraft.t_velocity;
   -- the desired velocity to maintain

end nav_AFDS;
