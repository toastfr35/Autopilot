-------------------------------------------------------
-- Package AFDS.IFACE.NAV
--
-- Configure the AFDS parameters
-- Read current AFDS configuration
-------------------------------------------------------

with IFACE.NAV;

package body AFDS.iface.NAV is

   -------------------------------
   -- AFDS view of the NAV data
   -------------------------------
   heading : t_heading;
   altitude : t_altitude;
   velocity : t_velocity;


   -------------------------------
   --
   -------------------------------
   function get_heading return t_heading is
   begin
      return heading;
   end get_heading;


   -------------------------------
   --
   -------------------------------
   function get_altitude return t_altitude is
   begin
      return altitude;
   end get_altitude;


   -------------------------------
   --
   -------------------------------
   function get_velocity return t_velocity is
   begin
      return velocity;
   end get_velocity;


   -------------------------------
   --
   -------------------------------
   procedure reset is
   begin
      null; --TODO
   end reset;


   -------------------------------
   --
   -------------------------------
   procedure read is
   begin
      heading := Standard.IFACE.NAV.get_heading;
      altitude := Standard.IFACE.NAV.get_altitude;
      velocity := Standard.IFACE.NAV.get_velocity;
   end read;


end AFDS.iface.NAV;
