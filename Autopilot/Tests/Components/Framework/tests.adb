with Interfaces;
with FDM;
with AFDS;
with GCAS;
with NAV;
with GPS;
with CDU;
with TMAP;
with COMIF;

with log;
with img;
with plot;
with CPP; -- C++

package body tests is

   test_list : array(1..4096) of t_test;
   current_test : Natural;
   nb_tests : Natural := 0;
   freq_hz : constant Natural := 50;
   cycles : Interfaces.Unsigned_64 := 0;

   AFDS_enabled : Boolean := False;
   GCAS_enabled : Boolean := False;
   NAV_enabled : Boolean := False;
   CDU_enabled : Boolean := False;


   -------------------------------
   --
   -------------------------------
   function get_time_ms return Interfaces.Unsigned_64;
   pragma Export (C, get_time_ms, "get_time_ms");

   function get_time_ms return Interfaces.Unsigned_64 is
      use type Interfaces.Unsigned_64;
   begin
      return cycles * Interfaces.Unsigned_64(1000 / freq_hz);
   end get_time_ms;

   -------------------------------
   --
   -------------------------------
   function get_nb_tests return Natural is (nb_tests);


   -------------------------------
   --
   -------------------------------
   procedure register_test (test : t_proc) is
   begin
      nb_tests := nb_tests + 1;
      test_list(nb_tests).proc := test;
      test_list(nb_tests).completed := False;
      test_list(nb_tests).success := True;
   end register_test;


   -------------------------------
   --
   -------------------------------
   procedure run_tests is
   begin
      for i in 1 .. nb_tests loop
         cycles := 0;
         current_test := i;
         log.log ("-----------------------");
         log.log ("Starting test" & i'Img);
         plot.open(i);

         AFDS_enabled := False;
         NAV_enabled  := False;

         FDM.init;
         COMIF.reset;
         AFDS.reset;
         GCAS.reset;
         NAV.reset;
         GPS.reset;
         CDU.reset;
         TMAP.reset;

         begin
            test_list(i).proc.all;
            test_list(i).completed := True;
         --exception
         --   when others =>
         --      null;
         end;

         if not test_list(i).completed then
            log.log ("Test" & i'Img & ": not complete" );
         elsif not test_list(i).success then
            log.log ("Test" & i'Img & ": FAILED" );
         else
            log.log ("Test" & i'Img & ": OK" );
         end if;

         plot.close;
      end loop;

      log.log ("-----------------------");
      log.log ("--    TEST SUMMARY   --");
      log.log ("-----------------------");
      for i in 1 .. nb_tests loop
         if not test_list(i).completed then
            log.log ("Test" & i'Img & ": not complete" );
         elsif not test_list(i).success then
            log.log ("Test" & i'Img & ": FAILED" );
         else
            log.log ("Test" & i'Img & ": OK" );
         end if;
      end loop;

   end run_tests;


   -------------------------------
   --
   -------------------------------
   procedure configure (testname : String; AFDS, GCAS, NAV, CDU: Boolean := False) is
   begin
      log.log ("TEST '" & testname & "'");
      AFDS_enabled := AFDS;
      GCAS_enabled := GCAS;
      NAV_enabled := NAV;
      CDU_enabled := CDU;
   end configure;


   -------------------------------
   --
   -------------------------------
   procedure run_steps (n : Natural) is
      use type Interfaces.Unsigned_64;
   begin
      for i in 1 .. n loop
         cycles := cycles + 1;

         if CDU_enabled then
            CDU.step;
         end if;

         if GCAS_enabled then
            GCAS.step;
         end if;

         if NAV_enabled then
            NAV.step;
         end if;

         if AFDS_enabled then
            AFDS.step;
         end if;

         GPS.step;

         TMAP.step;

         FDM.update(freq_hz);

         plot.step;

      end loop;
   end run_steps;


   -------------------------------
   --
   -------------------------------
   procedure run_seconds (n : Natural) is
   begin
      for i in 1 .. n loop
         run_steps (freq_hz);
      end loop;
   end run_seconds;


   -------------------------------
   --
   -------------------------------
   procedure check (msg : String; value, expected, margin : Float) is
   begin
      if not (value in (expected-margin) .. (expected+margin)) then
         log.log ("TEST: Failed " & msg & ": " & img.Image(value) & " " & img.Image(expected) & "  +- " & img.Image(margin) );
         test_list(current_test).success := False;
      else
         log.log ("TEST: Checked " & msg & ": OK");
      end if;
   end check;


   -------------------------------
   --
   -------------------------------
   procedure check (msg : String; assert : Boolean) is
   begin
      if not assert then
         log.log ("TEST: Failed " & msg);
         test_list(current_test).success := False;
      else
         log.log ("TEST: Checked " & msg & ": OK");
      end if;
   end check;

end tests;
