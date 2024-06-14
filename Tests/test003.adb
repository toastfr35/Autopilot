with tests;
with FDM;
with IFACE.NAV;
with IFACE.aircraft;

package body test003 is


   -- Change velocity from 300 to 500
   -- No change of heading or altitude

   procedure test003 is
   begin

      tests.configure ("Accelerate", AFDS => True, GCAS => True, NAV => False);

      -- set aircraft initial state
      FDM.set (latitude => 0.0,
               longitude => 0.0,
               altitude => 2000.0,
               heading => 0.0,
               velocity => 300.0
              );

      -- set AFDS configuration
      IFACE.NAV.set_heading (0.0);
      IFACE.NAV.set_altitude (2000.0);
      IFACE.NAV.set_velocity (400.0);

      -- run for 120 seconds
      tests.run_seconds (240);

      -- check aircraft state
      tests.check ("Altitude", Float(IFACE.aircraft.status.altitude), 2000.0, 100.0);
      tests.check ("Velocity", Float(IFACE.aircraft.status.velocity), 400.0,  10.0);
      tests.check ("Heading" , Float(IFACE.aircraft.status.heading),  0.0,    3.0);

   end test003;


begin
   tests.register_test (test003'Access);
end test003;
