with Ada.Text_IO;
with testlist;
with tests;

procedure main is
begin

   if tests.get_nb_tests = 0 then
      Ada.Text_IO.Put_Line ("No test to run");
   else
      tests.run_tests;
   end if;

end main;
