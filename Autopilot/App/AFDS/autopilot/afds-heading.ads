-------------------------------------------------------
-- Package AFDS.HEADING
--
-- Set the roll, rudder and elevator controls to reach the desired heading
-------------------------------------------------------

private package AFDS.heading is

   procedure step;
   -- Step for the auto-heading function

   procedure reset;
   -- Reset internal state

end AFDS.heading;
