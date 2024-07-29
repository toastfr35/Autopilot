with Interfaces; use Interfaces;
with FDM;
with Test;

package body systest is

   cycles : Interfaces.Unsigned_64 := 0;
   time_ms : Interfaces.Unsigned_64 := 0;
   startup : Boolean := True;

   procedure SysTest_update(hz : Natural) is
   begin
      if startup then
         FDM.init;
         Test.init;
      end if;

      Test.Step(hz, cycles, time_ms);

      FDM.update(hz);
      startup := False;
      cycles := cycles + 1;
      time_ms := time_ms + Interfaces.Unsigned_64(1000/hz);
   end SysTest_update;

end systest;
