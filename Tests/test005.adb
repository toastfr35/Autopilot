with tests;
with types; use types;
with FDM;
with IFACE.NAV;
with IFACE.aircraft;
with IFACE.GCAS;

package body test005 is

   -- Test GCAS

   procedure test005 is
   begin

      tests.configure ("GCAS", AFDS => True, GCAS => True, NAV => False);

      -- set aircraft initial state
      FDM.set (latitude => 0.0,
               longitude => 0.0,
               altitude => 4000.0,
               heading => 0.0,
               velocity => 300.0
              );

      -- set AFDS configuration
      IFACE.NAV.set_heading (150.0);
      IFACE.NAV.set_altitude (0.0);
      IFACE.NAV.set_velocity (450.0);

      --Trigger the GCAS
      -- run for 10000 steps
      for i in 1 .. 10000 loop
         tests.run_steps (1);
         exit when IFACE.GCAS.get_state /= GCAS_state_disengaged;
      end loop;

      -- check aircraft GCAS state & altitude
      tests.check ("GCAS emergency", IFACE.GCAS.get_state = GCAS_state_emergency);
      tests.check ("Altitude", Float(IFACE.aircraft.status.altitude), 400.0, 50.0);


      -- GCAS: emergency -> recovery
      -- run for another 1000 steps
      for i in 1 .. 1000 loop
         tests.run_steps (1);
         exit when IFACE.GCAS.get_state /= GCAS_state_emergency;
      end loop;

      -- check aircraft GCAS state & altitude
      tests.check ("GCAS recovery", IFACE.GCAS.get_state = GCAS_state_recovery);
      tests.check ("Vertical Speed", Float(IFACE.aircraft.status.vertspeed), 5.0, 1.0);


      -- GCAS: recovery -> stabilize
      -- run for another 1000 steps
      for i in 1 .. 1000 loop
         tests.run_steps (1);
         exit when IFACE.GCAS.get_state /= GCAS_state_recovery;
      end loop;

      -- check aircraft GCAS state & altitude
      tests.check ("GCAS stabilize", IFACE.GCAS.get_state = GCAS_state_stabilize);
      tests.check ("Altitude", Float(IFACE.aircraft.status.altitude), 1000.0, 50.0);


      -- GCAS: stabilize -> disengaged
      -- run for another 1000 steps
      for i in 1 .. 1000 loop
         tests.run_steps (1);
         exit when IFACE.GCAS.get_state /= GCAS_state_stabilize;
      end loop;

      -- check aircraft GCAS state & altitude
      tests.check ("GCAS disengaged", IFACE.GCAS.get_state = GCAS_state_disengaged);


   end test005;


begin
   tests.register_test (test005'Access);
end test005;
