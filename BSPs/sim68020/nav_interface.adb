with System;
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

   nav_external : t_nav_data;
   for nav_external'Address use System'To_Address(16#800000# + 64 + 0);
   pragma Volatile (nav_external);

   prev_nav : t_nav_data := nav_internal;


   generic
      type T is private;
   procedure update_X (e, i, p : in out T);

   procedure update_X (e, i, p : in out T) is
   begin
      if i /= p then
         -- internal change detected
         e := i;
         p := i;
      elsif e /= p then
         -- external change detected
         i := e;
         p := e;
      end if;
   end;

   procedure update_heading is new update_X (t_heading);
   procedure update_altitude is new update_X (t_altitude);
   procedure update_velocity is new update_X (t_velocity);

   procedure update (nav : in out t_AFDS) is
   begin
      update_heading (nav_external.heading, nav_internal.heading, prev_nav.heading);
      nav.heading := nav_internal.heading;

      update_altitude (nav_external.altitude, nav_internal.altitude, prev_nav.altitude);
      nav.altitude := nav_internal.altitude;

      update_velocity (nav_external.velocity, nav_internal.velocity, prev_nav.velocity);
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
