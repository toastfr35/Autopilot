package body psp is

   procedure sleep(hz : Natural) is
   begin
      Delay (1.0/hz);
   end sleep;

end psp;
