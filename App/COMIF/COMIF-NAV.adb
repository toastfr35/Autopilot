with HW;
with log;
with img;

package body COMIF.NAV is

   null_waypoint : constant types.t_waypoint := (0, 0.0, 0.0, 0.0, 0.0);

   COMIF_NAV_status : t_NAV_status := (False, (0.0, 3333.0, 333.0), 0.0, 0.0, 0, (others => null_waypoint));
   for COMIF_NAV_status'Address use HW.NAV_status'Address;
   pragma Volatile (COMIF_NAV_status);

   function read_status (component : t_component) return t_NAV_status is
   begin
      pragma Assert (read_access_status (component));
      return COMIF_NAV_status;
   end read_status;

   procedure write_status (component : t_component; status : t_NAV_status) is
   begin
      pragma Assert (write_access_status (component));
      COMIF_NAV_status := status;
   end write_status;

   procedure reset is
   begin
      COMIF_NAV_status := (False, (0.0, 4444.0, 444.0), 0.0, 0.0, 0, (others => null_waypoint));
   end reset;

   procedure dump_X (name : String; v : t_NAV_status)  is
   begin
      log.log (log.NAV, 1, 0, name & ": enabled " & v.enabled'Image);
      log.log (log.NAV, 1, 0, name & ": target_heading " &   img.Image(v.nav_target.heading));
      log.log (log.NAV, 1, 0, name & ": target_altitude " &  img.Image(v.nav_target.altitude));
      log.log (log.NAV, 1, 0, name & ": target_velocity " &  img.Image(v.nav_target.velocity));
      log.log (log.NAV, 1, 0, name & ": target_latitude " &  img.Image(v.target_latitude));
      log.log (log.NAV, 1, 0, name & ": target_longitude " & img.Image(v.target_longitude));
      log.log (log.NAV, 1, 0, name & ": current_waypoint_index " & v.current_waypoint_index'Img);
      for WP of v.waypoints loop
         exit when WP.ID = 0;
         log.log (log.NAV, 1, 0, name & ": waypoint" & WP.ID'Img & " " & img.Image(WP.latitude) & "," & img.Image(WP.longitude));
      end loop;
   end dump_X;

   pragma Warnings(off);
   procedure dump is
   begin
      dump_X ("COMIF.NAV", COMIF_NAV_status);
   end dump;

end COMIF.NAV;
