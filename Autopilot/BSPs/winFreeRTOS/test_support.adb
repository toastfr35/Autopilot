with Ada.Text_IO;
with GNAT.OS_Lib;

package body test_support is

   procedure test_end is
   begin
      GNAT.OS_Lib.OS_Exit (0);
   end test_end;

   procedure message (msg : String) is
   begin
      Ada.Text_IO.Put_Line (msg);
   end message;

   procedure assert (check : Boolean; msg : String) is
   begin
      if not check then
         Ada.Text_IO.Put_Line ("FAILED: " & msg);
      end if;
   end assert;

end test_support;
