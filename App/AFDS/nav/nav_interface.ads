-------------------------------------------------------
-- Package NAV_INTERFACE
--
-- Read current AFDS configuration
-------------------------------------------------------

with aircraft;

package nav_interface is

   type t_AFDS is record
      enabled : Boolean := False;
      heading : aircraft.t_heading := 0.0;
      altitude : aircraft.t_altitude := 0.0;
      velocity : aircraft.t_velocity := 0.0;
   end record;

   procedure update (nav : in out t_AFDS);

   -------------------------------
   -- for simulation/testing
   -------------------------------

   procedure enable;
   -- turn AFDS on

   procedure disable;
   -- turn AFDS off

   procedure set_heading (v : aircraft.t_heading);
   -- Set the desired heading

   procedure set_altitude (v : aircraft.t_altitude);
   -- Set the desired altitude

   procedure set_velocity (v : aircraft.t_velocity);
   -- Set the desired velocity

end nav_interface;
