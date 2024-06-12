with tests;
with FDM;
with nav_AFDS;
with nav_interface;
with aircraft;
with psp;

package body notest is


   -- Run GCAS, NAV and AFDS until the target altitude is 6000

   procedure notest is
      use type aircraft.t_altitude;
   begin

      tests.configure ("Run", AFDS => True, GCAS => True, NAV => False);

      FDM.set (latitude => 0.0,
               longitude => 0.0,
               altitude => 4000.0,
               heading => 0.0,
               velocity => 300.0
              );

      nav_interface.set_heading (0.0);
      nav_interface.set_altitude (4000.0);
      nav_interface.set_velocity (300.0);

      loop

         tests.run_steps (1);

         psp.sleep(hz => 50);

         exit when nav_AFDS.get_altitude = 6000.0;

      end loop;

   end notest;

begin
   tests.register_test (notest'Access);
end notest;
