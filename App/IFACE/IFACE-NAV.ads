-------------------------------------------------------
-- Package IFACE.NAV
--
-------------------------------------------------------

with types; use types;

package IFACE.NAV is

   function is_enabled return Boolean;
   pragma Warnings (off, is_enabled);
   -- is the NAV enabled?

   procedure set_enabled (b : Boolean);
   pragma Warnings (off, set_enabled);
   -- enable/disable the NAV

   function get_heading return t_heading;
   -- get the current NAV heading

   procedure set_heading (v : t_heading);
   -- set the desired NAV heading

   function get_altitude return t_altitude;
   -- get the current NAV altitude

   procedure set_altitude (v : t_altitude);
   -- Set the desired NAV altitude

   function get_velocity return t_velocity;
   -- get the current NAV velocity

   procedure set_velocity (v : t_velocity);
   -- Set the desired NAV velocity

   pragma Export (C, is_enabled, "IFACE_NAV_is_enabled");
   pragma Export (C, set_enabled, "IFACE_NAV_set_enabled");

   pragma Export (C, set_heading, "IFACE_NAV_set_heading");
   pragma Export (C, set_altitude, "IFACE_NAV_set_altitude");
   pragma Export (C, set_velocity, "IFACE_NAV_set_velocity");
   pragma Export (C, get_heading, "IFACE_NAV_get_heading");
   pragma Export (C, get_altitude, "IFACE_NAV_get_altitude");
   pragma Export (C, get_velocity, "IFACE_NAV_get_velocity");

end IFACE.NAV;
