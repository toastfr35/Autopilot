-------------------------------------------------------
-- Package AFDS.GCAS
--
-- Apply GCAS maneuver
-------------------------------------------------------

private package AFDS.GCAS is

   procedure step;
   -- Step for the auto-GCAS function

   procedure reset;
   -- Reset internal state

end AFDS.GCAS;
