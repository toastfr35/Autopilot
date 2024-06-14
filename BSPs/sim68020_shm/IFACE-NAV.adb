package body IFACE.NAV is

   heading  : t_heading  := 0.0;
   altitude : t_altitude := 3000.0;
   velocity : t_velocity := 300.0;
   enabled  : Boolean    := True;

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
      heading := v;
   end set_heading;

   procedure set_altitude (v : t_altitude) is
   begin
      altitude := v;
   end set_altitude;

   procedure set_velocity (v : t_velocity) is
   begin
      velocity := v;
   end set_velocity;

   function get_heading return t_heading is
   begin
      return heading;
   end get_heading;

   function get_altitude return t_altitude is
   begin
      return altitude;
   end get_altitude;

   function get_velocity return t_velocity is
   begin
      return velocity;
   end get_velocity;

end IFACE.NAV;
