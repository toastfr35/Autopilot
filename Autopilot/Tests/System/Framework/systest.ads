package systest is

   procedure SysTest_update(hz : Natural);
   pragma Export (C, SysTest_update, "SysTest_update");

end systest;
