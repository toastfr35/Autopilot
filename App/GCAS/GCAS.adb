-------------------------------------------------------
-- Package GCAS
--
-- Ground Collision Avoidance System
-- Detect potential collision with the ground and execute
-- emergency avoidance maneuver if required
-------------------------------------------------------

with GCAS.iface;
with GCAS.impl;

package body GCAS is

   -------------------------------
   -- Step for the autopilot function
   -------------------------------
   procedure step is
   begin
      GCAS.iface.read;
      GCAS.impl.step;
      GCAS.iface.write;
   end step;


   -------------------------------
   -- Reset internal state
   -------------------------------
   procedure reset is
   begin
      GCAS.iface.reset;
      GCAS.impl.reset;
   end reset;

end GCAS;
