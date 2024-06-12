with tests;
with FDM;
with nav_interface;
with aircraft;

package body test002 is


   -- Change heading from 0 to 180
   -- No change of altitude or velocity

   procedure test002 is
   begin

      tests.configure ("Heading change", AFDS => True, GCAS => True, NAV => False);

      -- set aircraft initial state
      FDM.set (latitude => 0.0,
               longitude => 0.0,
               altitude => 2000.0,
               heading => 0.0,
               velocity => 300.0
              );

      -- set AFDS configuration
      nav_interface.set_heading (180.0);
      nav_interface.set_altitude (2000.0);
      nav_interface.set_velocity (300.0);

      -- run for 120 seconds
      tests.run_seconds (120);

      -- check aircraft state
      tests.check ("Altitude", Float(aircraft.status.altitude), 2000.0, 100.0);
      tests.check ("Velocity", Float(aircraft.status.velocity), 300.0,  10.0);
      tests.check ("Heading" , Float(aircraft.status.heading),  180.0,   3.0);

   end test002;


begin
   tests.register_test (test002'Access);
end test002;
