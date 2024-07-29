-------------------------------------------------------
-- Package COMIF.NAV
--
-------------------------------------------------------

with HW;

package body COMIF.NAV is

   null_waypoint : constant types.t_waypoint := ( 0.0, 0.0, 0.0, 0.0, 0, 0);

   COMIF_NAV_status : t_NAV_status := (False, (0.0, 3333.0, 333.0), 0.0, 0.0, 0, (others => null_waypoint));
   for COMIF_NAV_status'Address use HW.NAV_status'Address;
   pragma Volatile (COMIF_NAV_status);

   function read (component : t_component) return t_NAV_status is
   begin
      pragma Assert (read_access (component, Comp_NAV));
      return COMIF_NAV_status;
   end read;

   procedure write (component : t_component; status : t_NAV_status) is
   begin
      pragma Assert (write_access (component, Comp_NAV));
      COMIF_NAV_status := status;
   end write;

   procedure reset is
   begin
      COMIF_NAV_status := (False, (0.0, 4444.0, 444.0), 0.0, 0.0, 0, (others => null_waypoint));
   end reset;

end COMIF.NAV;
