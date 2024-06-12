package body math is

   pragma Linker_Options("-lm"); -- for access to 'cosf', etc.

   -------------------------------
   --
   -------------------------------
   function fabs (x : Float) return Float is
   begin
      if x >= 0.0 then
         return x;
      else
         return -x;
      end if;
   end fabs;

end math;
