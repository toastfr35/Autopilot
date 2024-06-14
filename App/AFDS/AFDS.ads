-------------------------------------------------------
-- Package AFDS (Automatic Fligth Director System)
--
-- Read data on relevant interfaces
-- Run the AFDS.* sub-tasks
-- Commit data on relevant interfaces
-------------------------------------------------------

package AFDS is

   procedure step;
   -- Step for the autopilot function

   procedure reset;
   -- Reset internal states

end AFDS;
