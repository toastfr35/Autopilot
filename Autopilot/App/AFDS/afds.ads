-------------------------------------------------------
-- Package AFDS (Automatic Fligth Director System)
--
-- Read data on relevant interfaces
-- Run the AFDS.* sub-tasks
-- Commit data on relevant interfaces
-------------------------------------------------------

package AFDS is

   procedure step
      with Export => True, Convention => C, External_Name => "AFDS_step";
   -- Step for the autopilot function

   procedure reset
      with Export => True, Convention => C, External_Name => "AFDS_reset";
   -- Reset internal states

end AFDS;
