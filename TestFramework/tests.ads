package tests is

   function get_nb_tests return Natural;

   type t_proc is access procedure;

   type t_test is record
      proc : t_proc;
      completed : Boolean := False;
      success : Boolean := True;
   end record;

   procedure register_test (test : t_proc);

   procedure run_tests;



   -- Test API

   procedure configure (testname : String; AFDS, GCAS, NAV, CDU: Boolean := False);

   procedure run_steps (n : Natural);

   procedure run_seconds (n : Natural);

   procedure check (msg : String; value, expected, margin : Float);

   procedure check (msg : String; assert : Boolean);


end tests;
