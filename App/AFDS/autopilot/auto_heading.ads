-------------------------------------------------------
-- Package AUTO_HEADING
--
-- Set the roll, rudder and elevator controls to reach the desired heading
-------------------------------------------------------

package auto_heading is

   procedure step;
   -- Step for the auto-heading function

   procedure reset;
   -- Reset internal state

end auto_heading;
