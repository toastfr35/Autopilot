with tests;
with components; use components;
with types; use types;
with FDM;
with COMIF.AFDS;
with GCAS.iface.GCAS;
with COMIF.aircraft;

package body test005 is

   -- Test GCAS

   procedure test005 is
   begin

      tests.configure ("GCAS", AFDS => True, GCAS => True, NAV => False, CDU => False);

      -- set aircraft initial state
      FDM.set (latitude => 0.0,
               longitude => 0.0,
               altitude => 4000.0,
               heading => 0.0,
               velocity => 0.0
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
         AFDS_status.nav_target.heading  := 0.0;
         AFDS_status.nav_target.altitude := 0.0;
         AFDS_status.nav_target.velocity := 0.0;
         COMIF.AFDS.write_status (Comp_TEST, AFDS_status);
      end;

      --Trigger the GCAS
      -- run for 10000 steps
      for i in 1 .. 100000 loop
         tests.run_steps (1);
         exit when GCAS.iface.GCAS.status.GCAS_state /= GCAS_state_disengaged;
      end loop;

      -- check aircraft GCAS state & altitude
      declare
         status : constant COMIF.aircraft.t_aircraft_status := COMIF.aircraft.read_status (Comp_TEST);
      begin
         tests.check ("GCAS emergency", GCAS.iface.GCAS.status.GCAS_state = GCAS_state_emergency);
         tests.check ("Altitude", Float(status.altitude), 300.0, 100.0);
      end;

      -- GCAS: emergency -> recovery
      -- run for another 1000 steps
      for i in 1 .. 1000 loop
         tests.run_steps (1);
         exit when GCAS.iface.GCAS.status.GCAS_state /= GCAS_state_emergency;
      end loop;

      -- check aircraft GCAS state & altitude
      declare
         status : constant COMIF.aircraft.t_aircraft_status := COMIF.aircraft.read_status (Comp_TEST);
      begin
         tests.check ("GCAS recovery", GCAS.iface.GCAS.status.GCAS_state = GCAS_state_recovery);
         tests.check ("Altitude", Float(status.altitude), 600.0, 100.0);
      end;

      -- GCAS: recovery -> stabilize
      -- run for another 1000 steps
      for i in 1 .. 1000 loop
         tests.run_steps (1);
         exit when GCAS.iface.GCAS.status.GCAS_state /= GCAS_state_recovery;
      end loop;

      -- check aircraft GCAS state & altitude
      declare
         status : constant COMIF.aircraft.t_aircraft_status := COMIF.aircraft.read_status (Comp_TEST);
      begin
         tests.check ("GCAS stabilize", GCAS.iface.GCAS.status.GCAS_state = GCAS_state_stabilize);
         tests.check ("Altitude", Float(status.altitude), 1500.0, 100.0);
      end;

      -- GCAS: stabilize -> disengaged
      -- run for another 1000 steps
      for i in 1 .. 10000 loop
         tests.run_steps (1);
         exit when GCAS.iface.GCAS.status.GCAS_state /= GCAS_state_stabilize;
      end loop;

      -- check aircraft GCAS state & altitude
      tests.check ("GCAS disengaged", GCAS.iface.GCAS.status.GCAS_state = GCAS_state_disengaged);

   end test005;


begin
   tests.register_test (test005'Access);
end test005;
