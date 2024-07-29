-------------------------------------------------------
-- Package GCAS
--
-- Ground Collision Avoidance System
-- Detect potential collision with the ground and execute
-- emergency avoidance maneuver if required
-------------------------------------------------------

package GCAS is

   procedure step
      with Export => True, Convention => C, External_Name => "GCAS_step";
   -- Step for the GCAS function

   procedure reset
      with Export => True, Convention => C, External_Name => "GCAS_reset";
   -- Reset internal state

end GCAS;
