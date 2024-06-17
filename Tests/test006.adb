with tests;
with components; use components;
with FDM;
with COMIF.CDU;
with COMIF.aircraft;

package body test006 is

   procedure test006 is
      CDU_status : COMIF.CDU.t_CDU_status := COMIF.CDU.read_status (Comp_TEST);
   begin

      tests.configure ("NAV + AFDS", AFDS => True, NAV => True, CDU => True);

      -- set aircraft initial state
      FDM.set (latitude => 0.0,
               longitude => 0.0,
               altitude => 4000.0,
               heading => 56.0,
               velocity => 300.0
              );

      -- enabled AFDS
      CDU_status.action := COMIF.CDU.CDU_act_enable;
      CDU_status.data.component := Comp_AFDS;
      COMIF.CDU.write_status (Comp_Test, CDU_status);

      tests.run_steps (1);

      -- check aircraft state
      declare
         status : constant COMIF.aircraft.t_aircraft_status := COMIF.aircraft.read_status (Comp_TEST);
      begin
         tests.check ("Altitude", Float(status.altitude), 4000.0, 100.0);
         tests.check ("Heading" , Float(status.heading),  56.0,    3.0);
         tests.check ("Velocity", Float(status.velocity), 300.0,  10.0);
      end;

   end test006;


begin
   tests.register_test (test006'Access);
end test006;
