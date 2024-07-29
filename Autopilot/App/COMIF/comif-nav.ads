-------------------------------------------------------
-- Package COMIF.NAV
--
-------------------------------------------------------

with components; use components;
with types;

package COMIF.NAV is

   -------------------------------
   -- Data types
   -------------------------------

   type t_NAV_status is record
      enabled : types.t_Bool32;
      nav_target : types.t_nav_target;
      target_latitude : types.t_latitude;
      target_longitude : types.t_longitude;
      current_waypoint_index : Natural;
      waypoints : types.t_waypoints;
   end record;

   for t_NAV_status use record
      enabled                at  0 range 0 .. 31;
      nav_target             at  4 range 0 .. 95;
      target_latitude        at 16 range 0 .. 63;
      target_longitude       at 24 range 0 .. 63;
      current_waypoint_index at 32 range 0 .. 31;
      waypoints              at 36 range 0 .. 16383;
   end record;

   -------------------------------
   -- R/W access to data
   -------------------------------

   procedure reset;
   pragma Export (C, reset, "COMIF_NAV_reset");

   function read (component : t_component) return t_NAV_status;
   pragma Export (C, read, "COMIF_NAV_read");

   procedure write (component : t_component; status : t_NAV_status);
   pragma Export (C, write, "COMIF_NAV_write");

end COMIF.NAV;
