with System.Machine_Code; use System.Machine_Code;

package body psp is

   pragma Warnings(off);
   pragma RVS (instrument ("psp.sleep", "FALSE", "NONE"));
   pragma Warnings(on);

   procedure sleep(hz : Natural) is
   begin
     for i in 1 .. (300_000/hz) loop
        Asm ("nop", Volatile => True);
     end loop;
   end sleep;

end psp;
