-------------------------------------------
-- Logging or errors
-------------------------------------------

with Ada.Text_IO;

package body errorlog is

   procedure log (msg : String) is
   begin
      Ada.Text_IO.Put ("Error: ");
      Ada.Text_IO.Put_Line (msg);
   end log;

end errorlog;
