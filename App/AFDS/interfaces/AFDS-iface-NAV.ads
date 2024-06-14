-------------------------------------------------------
-- Package AFDS.IFACE.NAV
--
-- Configure the AFDS parameters
-- Read current AFDS configuration
-------------------------------------------------------

with types; use types;

package AFDS.iface.NAV is

   procedure reset;
   -- reset internal state

   procedure read;

   function get_heading return t_heading;
   -- the desired heading to maintain

   function get_altitude return t_altitude;
   -- the desired altitude to maintain

   function get_velocity return t_velocity;
   -- the desired velocity to maintain

end AFDS.iface.NAV;
