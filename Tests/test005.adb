with tests;
with FDM;
with nav_interface;
with aircraft;
with GCAS;

package body test005 is

   -- Test GCAS

   procedure test005 is
      use type GCAS.t_GCAS_state;
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
      nav_interface.set_heading (150.0);
      nav_interface.set_altitude (0.0);
      nav_interface.set_velocity (450.0);

      --Trigger the GCAS
      -- run for 10000 steps
      for i in 1 .. 10000 loop
         tests.run_steps (1);
         exit when GCAS.get_CGAS_state /= GCAS.disengaged;
      end loop;

      -- check aircraft GCAS state & altitude
      tests.check ("GCAS emergency", GCAS.get_CGAS_state = GCAS.emergency);
      tests.check ("Altitude", Float(aircraft.status.altitude), 400.0, 50.0);


      -- GCAS: emergency -> recovery
      -- run for another 1000 steps
      for i in 1 .. 1000 loop
         tests.run_steps (1);
         exit when GCAS.get_CGAS_state /= GCAS.emergency;
      end loop;

      -- check aircraft GCAS state & altitude
      tests.check ("GCAS recovery", GCAS.get_CGAS_state = GCAS.recovery);
      tests.check ("Vertical Speed", Float(aircraft.status.vertspeed), 5.0, 1.0);


      -- GCAS: recovery -> stabilize
      -- run for another 1000 steps
      for i in 1 .. 1000 loop
         tests.run_steps (1);
         exit when GCAS.get_CGAS_state /= GCAS.recovery;
      end loop;

      -- check aircraft GCAS state & altitude
      tests.check ("GCAS stabilize", GCAS.get_CGAS_state = GCAS.stabilize);
      tests.check ("Altitude", Float(aircraft.status.altitude), 1000.0, 50.0);


      -- GCAS: stabilize -> disengaged
      -- run for another 1000 steps
      for i in 1 .. 1000 loop
         tests.run_steps (1);
         exit when GCAS.get_CGAS_state /= GCAS.stabilize;
      end loop;

      -- check aircraft GCAS state & altitude
      tests.check ("GCAS disengaged", GCAS.get_CGAS_state = GCAS.disengaged);


   end test005;


begin
   tests.register_test (test005'Access);
end test005;
