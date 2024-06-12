-------------------------------------------------------
-- Package AFDS
--
-- Update the aircraft status
-- Run the auto_* tasks
-- Commit the aircraft control commands
-------------------------------------------------------

package AFDS is

   procedure step;
   -- Step for the autopilot function

   procedure reset;
   -- Reset internal state

end AFDS;
