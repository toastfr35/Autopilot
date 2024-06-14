package body IFACE.NAV is

   type t_nav_data is record
      heading : t_heading;
      altitude : t_altitude;
      velocity : t_velocity;
   end record;

   enabled : Boolean := False;

   nav_data : t_nav_data := (0.0, 3000.0, 300.0);
   for nav_data'Address use System'To_Address(16#800000# + 64 + 0);
   pragma Volatile (nav_data);

   ------------------------------
   --
   ------------------------------

   function is_enabled return Boolean is
   begin
      return enabled;
   end is_enabled;

   procedure set_enabled (b : Boolean) is
   begin
      enabled := b;
   end set_enabled;

   procedure set_heading (v : t_heading) is
   begin
      nav_data.heading := v;
   end set_heading;

   procedure set_altitude (v : t_altitude) is
   begin
      nav_data.altitude := v;
   end set_altitude;

   procedure set_velocity (v : t_velocity) is
   begin
      nav_data.velocity := v;
   end set_velocity;

   function get_heading return t_heading is
   begin
      return nav_data.heading;
   end get_heading;

   function get_altitude return t_altitude is
   begin
      return nav_data.altitude;
   end get_altitude;

   function get_velocity return t_velocity is
   begin
      return nav_data.velocity;
   end get_velocity;

end IFACE.NAV;
