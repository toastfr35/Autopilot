-------------------------------------------------------
-- Package AVERAGE
--
-- Generic package to compute rolling average of
-- floating point values
-------------------------------------------------------

package body average is

   T : array (1 .. length) of Float := (others => 0.0);
   oldest : Natural := 1;
   total : Float := 0.0;
   count : Natural := 0;

   -- add a new value
   procedure add (v : Float) is
   begin
      total := total + v;
      if count < length then
         -- add one more element
         count := count + 1;
         T(count) := v;
      else
         -- replace the oldest element
         total := total - T(oldest);
         T(oldest) := v;
         oldest := oldest + 1;
         if oldest > T'Last then
            oldest := T'First;
         end if;
      end if;
   end add;

   -- get the average
   function get return Float is
   begin
      return total / Float(count);
   end get;

   --
   procedure reset is
   begin
      T := (others => 0.0);
      oldest := 1;
      total := 0.0;
      count := 0;
   end reset;

end average;
