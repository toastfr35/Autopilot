-------------------------------------------------------
-- Package COMIF.NAV
--
-------------------------------------------------------

with components; use components;
with types;

package COMIF.NAV is

   -------------------------------
   -- R/W access rights
   -------------------------------
   read_access_status   : constant t_access_rights := (Comp_AFDS => True,  Comp_GCAS => False,  Comp_NAV => True,  Comp_CDU => True, Comp_FDM => False,  Comp_TEST => True);
   write_access_status  : constant t_access_rights := (Comp_AFDS => False, Comp_GCAS => False,  Comp_NAV => True,  Comp_CDU => True, Comp_FDM => False,  Comp_TEST => True);


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
   for t_NAV_status'Size use 20704;

   for t_NAV_status use record
      enabled                at  0 range 0 .. 31;
      nav_target             at  4 range 0 .. 95;
      target_latitude        at 16 range 0 .. 31;
      target_longitude       at 20 range 0 .. 31;
      current_waypoint_index at 24 range 0 .. 31;
      waypoints              at 28 range 0 .. 20479;
   end record;

   -------------------------------
   -- R/W access to data
   -------------------------------

   procedure reset;
   pragma Export (C, reset, "COMIF_NAV_reset");

   function read_status (component : t_component) return t_NAV_status;
   pragma Export (C, read_status, "COMIF_NAV_read_status");

   procedure write_status (component : t_component; status : t_NAV_status);
   pragma Export (C, write_status, "COMIF_NAV_write_status");

   -- DEBUG
   procedure dump_X (name : String; v : t_NAV_status);
   procedure dump;
   pragma Export (C, dump, "COMIF_NAV_dump");

end COMIF.NAV;
