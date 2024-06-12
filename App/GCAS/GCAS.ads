-------------------------------------------------------
-- Package GCAS
--
-- Ground Collision Avoidance System
-- Detect potential collision with the ground and execute
-- emergency avoidance maneuver if required
-------------------------------------------------------

package GCAS is

   procedure step;
   -- Step for the auto-GCAS function

   procedure reset;
   -- Reset internal state

   type t_GCAS_state is (disengaged, emergency, recovery, stabilize);

   function get_CGAS_state return t_GCAS_state;
   -- Get the current state ofthe GCAS


end GCAS;
