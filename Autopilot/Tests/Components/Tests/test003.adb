with tests;
with components; use components;
with FDM;
with COMIF.AFDS;
with COMIF.GPS;
with COMIF.ACS;

package body test003 is


   -- Change velocity from 300 to 500
   -- No change of heading or altitude

   procedure test003 is
   begin

      tests.configure ("Accelerate", AFDS => True, GCAS => True, NAV => False, CDU => False);

      -- set aircraft initial state
      FDM.set (latitude => 0.0,
               longitude => 0.0,
               altitude => 2000.0,
               heading => 100.0,
               speed => 300.0
              );

      -- set AFDS configuration
      declare
         AFDS_status : COMIF.AFDS.t_AFDS_status := COMIF.AFDS.read (Comp_TEST);
      begin
         AFDS_status.enabled := True;
         COMIF.AFDS.write (Comp_TEST, AFDS_status);
         tests.run_steps(1);

         -- AFDS enabled
         AFDS_status := COMIF.AFDS.read (Comp_TEST);
         tests.check ("Altitude", Float(AFDS_status.nav_target.altitude), 2000.0, 1.0);
         tests.check ("Velocity", Float(AFDS_status.nav_target.hspeed), 300.0,  1.0);
         tests.check ("Heading" , Float(AFDS_status.nav_target.heading),  100.0,    1.0);

         AFDS_status.nav_target.heading  := 100.0;
         AFDS_status.nav_target.altitude := 2000.0;
         AFDS_status.nav_target.hspeed := 400.0;
         COMIF.AFDS.write (Comp_TEST, AFDS_status);
      end;

      -- run for 120 seconds
      tests.run_seconds (240);

      -- check aircraft state
      declare
         aircraft_status : constant COMIF.ACS.t_ACS_status := COMIF.ACS.read (Comp_TEST);
         GPS_status : constant COMIF.GPS.t_GPS_status := COMIF.GPS.read (Comp_TEST);
      begin
         tests.check ("Altitude", Float(GPS_status.altitude), 2000.0, 100.0);
         tests.check ("Velocity", Float(GPS_status.hspeed), 400.0,  10.0);
         tests.check ("Heading" , Float(aircraft_status.heading),  100.0,    3.0);
      end;

   end test003;


begin
   tests.register_test (test003'Access);
end test003;
