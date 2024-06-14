with Ada.Text_IO; use Ada.Text_IO;
with Interfaces; use Interfaces;

package body log is

   count : array (t_pkg) of Unsigned_32 := (others => 0);

   buffer : String (1..4096);
   buffer_last : Natural := 0;

   procedure log (pkg: t_pkg; freq : Natural; shift : Natural; msg : String) is
      l : constant Natural := msg'Length;
      show : Boolean;
   begin
      count(pkg) := count(pkg) + 1;
      show := (count(pkg) + Unsigned_32(shift)) mod Unsigned_32(freq) = 0;

      if show and buffer_last > 0 then
         buffer_last := buffer_last + 1;
         buffer(buffer_last) := Character'Val(10);
      end if;

      buffer(buffer_last+1..buffer_last+l) := msg;
      if show then
         buffer_last := buffer_last + l;
      end if;
   end log;

   procedure step is
   begin
      if buffer_last > 0 then
         Put_Line (buffer(1..buffer_last));
         buffer_last := 0;
      end if;
   end step;


end log;
