with components; use components;
with types;
with tests;
with FDM;
with COMIF.NAV;
with COMIF.AFDS;
with psp;

package body notest is


   -- Run GCAS, NAV and AFDS until the target altitude is 6000

   procedure notest is
      use type types.t_altitude;
   begin

      tests.configure ("Run", AFDS => True, GCAS => True, NAV => False);

      FDM.set (latitude => 0.0,
               longitude => 0.0,
               altitude => 4000.0,
               heading => 0.0,
               velocity => 300.0
              );

      declare
         AFDS_status : COMIF.AFDS.t_AFDS_status := COMIF.AFDS.read_status (Comp_TEST);
      begin
         AFDS_status.enabled := True;
         --COMIF.AFDS.set_enabled_by_mode (True);
         --COMIF.NAV.set_heading (0.0);
         --COMIF.NAV.set_altitude (4000.0);
         --COMIF.NAV.set_velocity (300.0);
         --COMIF.AFDS.write_status (Comp_TEST, AFDS_status);
      end;

      loop

         tests.run_steps (1);

         psp.sleep(hz => 50);

         --exit when COMIF.NAV.get_altitude = 6000.0;

      end loop;

   end notest;

begin
   tests.register_test (notest'Access);
end notest;
