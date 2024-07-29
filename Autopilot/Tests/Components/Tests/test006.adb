with tests;
with components; use components;
with FDM;
with COMIF.CDU;
with COMIF.GPS;
with COMIF.ACS;

package body test006 is

   procedure test006 is
      CDU_status : COMIF.CDU.t_CDU_status := COMIF.CDU.read (Comp_TEST);
   begin

      tests.configure ("NAV + AFDS", AFDS => True, NAV => True, CDU => True);

      -- set aircraft initial state
      FDM.set (latitude => 0.0,
               longitude => 0.0,
               altitude => 4000.0,
               heading => 56.0,
               speed => 300.0
              );

      -- enabled AFDS
      CDU_status.action := COMIF.CDU.CDU_act_enable;
      CDU_status.action_data.component := Comp_AFDS;
      COMIF.CDU.write (Comp_Test, CDU_status);

      tests.run_steps (2);

      -- check aircraft state
      declare
         aircraft_status : constant COMIF.ACS.t_ACS_status := COMIF.ACS.read (Comp_TEST);
         GPS_status : constant COMIF.GPS.t_GPS_status := COMIF.GPS.read (Comp_TEST);
      begin
         tests.check ("Altitude", Float(GPS_status.altitude), 4000.0, 100.0);
         tests.check ("Velocity", Float(GPS_status.hspeed), 300.0,  20.0);
         tests.check ("Heading" , Float(aircraft_status.heading),  56.0,    3.0);
      end;

   end test006;


begin
   tests.register_test (test006'Access);
end test006;
