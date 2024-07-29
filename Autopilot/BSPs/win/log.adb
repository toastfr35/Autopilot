-------------------------------------------------------
-- Package LOG
--
-------------------------------------------------------

with Ada.Text_IO;

package body log is
   procedure log (msg : String) is
   begin
      Ada.Text_IO.Put_Line(msg);
   end log;
end log;
