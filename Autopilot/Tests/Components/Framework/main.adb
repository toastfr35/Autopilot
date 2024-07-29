
with testlist;
with tests;

procedure main is
begin

   if tests.get_nb_tests = 0 then
      null;
   else
      tests.run_tests;
   end if;

end main;
