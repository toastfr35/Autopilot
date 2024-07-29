-------------------------------------------------------
-- Package GCAS
--
-- Ground Collision Avoidance System
-- Detect potential collision with the ground and execute
-- emergency avoidance maneuver if required
-------------------------------------------------------

with GCAS.iface;
with GCAS.impl;
with types;

package body GCAS is

   -------------------------------
   -- Step for the GCAS function
   -------------------------------
   procedure step is
   begin
      GCAS.iface.read;
      if GCAS.iface.GCAS.data.enabled then
         GCAS.impl.step;
      else
         GCAS.iface.GCAS.data.GCAS_state := types.GCAS_state_disengaged;
      end if;
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
