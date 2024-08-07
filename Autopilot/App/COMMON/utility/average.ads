-------------------------------------------------------
-- Package AVERAGE
--
-- Generic package to compute rolling average of
-- floating point values
-------------------------------------------------------

generic
   length : Natural;

package average is

   procedure add (v : Float);

   function get return Float;

   procedure reset;

end average;
