with aircraft; use aircraft;

package body nav_interface is

   type t_nav_data is record
      heading : t_heading;
      altitude : t_altitude;
      velocity : t_velocity;
   end record;

   enabled : Boolean := False;

   nav_internal : t_nav_data := (0.0, 3000.0, 300.0);
   pragma Export (C, nav_internal, "nav_interface_data");

   procedure update (nav : in out t_AFDS) is
   begin
      nav.heading := nav_internal.heading;
      nav.altitude := nav_internal.altitude;
      nav.velocity := nav_internal.velocity;
      nav.enabled := enabled;
   end update;

   -------------------------------
   -- for simulation/testing
   -------------------------------

   procedure enable is
   begin
      enabled := True;
   end enable;

   procedure disable is
   begin
      enabled := False;
   end disable;

   procedure set_heading (v : aircraft.t_heading) is
   begin
      nav_internal.heading := v;
   end set_heading;

   procedure set_altitude (v : aircraft.t_altitude) is
   begin
      nav_internal.altitude := v;
   end set_altitude;

   procedure set_velocity (v : aircraft.t_velocity) is
   begin
      nav_internal.velocity := v;
   end set_velocity;

end nav_interface;
