with Ada.Text_IO; use Ada.Text_IO;
with Interfaces; use Interfaces;
with Interfaces.C;

package body log is

   count : array (t_pkg) of Unsigned_32 := (others => 0);

   buffer : String (1..1024*1024);
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

   procedure msg (msg : String) is
   begin
      Put_Line ("MSG: " & msg);
   end msg;


   pragma Warnings (off);
   procedure log_NAV (str : Interfaces.C.char_array);
   pragma Export (C, log_NAV, "log_NAV");
   pragma Warnings (on);

   procedure log_NAV (str : Interfaces.C.char_array) is
      S : String(1..1024);
      last : Natural := 0;
      c : Character;
   begin
      for i in S'Range loop
         c := Character(str(Interfaces.C.size_t(i-1)));
         exit when Character'Pos(c) = 0;
         S(i) := c;
         last := i;
      end loop;
      log (NAV,1,0,S(1..last));
   end log_NAV;


end log;
