package log is

   type t_pkg is (test, main, FDM, AFDS, GCAS, NAV, CDU);

   procedure log (pkg: t_pkg; freq : Natural; shift : Natural; msg : String);

   procedure step;

   procedure msg (msg : String);

end log;
