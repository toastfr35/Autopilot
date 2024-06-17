with tests;
with components; use components;
with FDM;
with COMIF.AFDS;
with COMIF.aircraft;

package body test004 is

   -- Change heading from 0 to 130
   -- Change velocity from 300 to 450
   -- Climb from 2000 to 4000 feet

   procedure test004 is
   begin

      tests.configure ("Climb, turn and accelerate", AFDS => True, GCAS => True);

      -- set aircraft initial state
      FDM.set (latitude => 0.0,
               longitude => 0.0,
               altitude => 2000.0,
               heading => 100.0,
               velocity => 300.0
              );

      -- set AFDS configuration
      declare
         AFDS_status : COMIF.AFDS.t_AFDS_status := COMIF.AFDS.read_status (Comp_TEST);
      begin
         AFDS_status.enabled := True;
         COMIF.AFDS.write_status (Comp_TEST, AFDS_status);
         tests.run_steps(1);

         -- AFDS enabled
         AFDS_status := COMIF.AFDS.read_status (Comp_TEST);
         tests.check ("Altitude", Float(AFDS_status.nav_target.altitude), 2000.0, 1.0);
         tests.check ("Velocity", Float(AFDS_status.nav_target.velocity), 300.0,  1.0);
         tests.check ("Heading" , Float(AFDS_status.nav_target.heading),  100.0,    1.0);

         AFDS_status.nav_target.heading  := 200.0;
         AFDS_status.nav_target.altitude := 4000.0;
         AFDS_status.nav_target.velocity := 400.0;
         COMIF.AFDS.write_status (Comp_TEST, AFDS_status);
      end;

      -- run for 120 seconds
      tests.run_seconds (120);

      -- check aircraft state
      declare
         status : constant COMIF.aircraft.t_aircraft_status := COMIF.aircraft.read_status (Comp_TEST);
      begin
         tests.check ("Altitude", Float(status.altitude), 4000.0, 100.0);
         tests.check ("Velocity", Float(status.velocity), 400.0,  10.0);
         tests.check ("Heading" , Float(status.heading),  200.0,   3.0);
      end;

   end test004;


begin
   tests.register_test (test004'Access);
end test004;
