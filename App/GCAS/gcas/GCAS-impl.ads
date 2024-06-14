-------------------------------------------------------
-- Package GCAS.IMPL
--
-- Ground Collision Avoidance System
-- Detect potential collision with the ground and execute
-- emergency avoidance maneuver if required
-------------------------------------------------------


package GCAS.impl is

   procedure step;
   -- Step for the auto-GCAS function

   procedure reset;
   -- Reset internal state

end GCAS.impl;
