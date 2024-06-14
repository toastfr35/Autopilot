-------------------------------------------------------
-- Package GCAS
--
-- Ground Collision Avoidance System
-- Detect potential collision with the ground and execute
-- emergency avoidance maneuver if required
-------------------------------------------------------

package GCAS is

   procedure step;
   -- Step for the GCAS function

   procedure reset;
   -- Reset internal state

end GCAS;
