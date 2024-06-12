with tests;
with FDM;
with nav_interface;
with aircraft;

package body test001 is


   -- Climb from 2000 to 4000 feet
   -- No change of heading or velocity

   procedure test001 is
   begin

      tests.configure ("Climb", AFDS => True, GCAS => True, NAV => False);

      -- set aircraft initial state
      FDM.set (latitude => 0.0,
               longitude => 0.0,
               altitude => 2000.0,
               heading => 0.0,
               velocity => 300.0
              );

      -- set AFDS configuration
      nav_interface.set_heading (0.0);
      nav_interface.set_altitude (4000.0);
      nav_interface.set_velocity (300.0);

      -- run for 120 seconds
      tests.run_seconds (120);

      -- check aircraft state
      tests.check ("Altitude", Float(aircraft.status.altitude), 4000.0, 100.0);
      tests.check ("Velocity", Float(aircraft.status.velocity), 300.0,  10.0);
      tests.check ("Heading" , Float(aircraft.status.heading),  0.0,    3.0);

   end test001;


begin
   tests.register_test (test001'Access);
end test001;
