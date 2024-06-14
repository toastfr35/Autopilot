package log is

   type t_pkg is (test, main, FDM, GCAS, altitude, heading, velocity, vspeed, roll, pitch, rudder, aileron, elevator, throttle);

   procedure log (pkg: t_pkg; freq : Natural; shift : Natural; msg : String);

   procedure step;

end log;
