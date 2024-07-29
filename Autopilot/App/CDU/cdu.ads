-------------------------------------------------------
-- Package CDU
--
-- Control Display Unit
-- Enabled/Disable AFDS, NAV, GCAS
-- Edit waypoints
-------------------------------------------------------

package CDU is

   procedure step
      with Export => True, Convention => C, External_Name => "CDU_step";
   -- Step for the CDU function

   procedure reset
      with Export => True, Convention => C, External_Name => "CDU_reset";
   -- Reset internal state

end CDU;
