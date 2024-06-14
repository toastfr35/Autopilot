-------------------------------------------------------
-- Package AFDS.GCAS
--
-- Apply GCAS maneuver
-------------------------------------------------------

with types; use types;

with AFDS.iface.GCAS;
with AFDS.roll;
with AFDS.pitch;
with AFDS.velocity;

package body AFDS.GCAS is

   -------------------------------
   -- Reset internal state
   -------------------------------
   procedure reset is
   begin
      null;
   end reset;

   -------------------------------
   -- Step function for the auto-GCAS function
   -------------------------------
   procedure step is
   begin
      -- apply GCAS command overrides
      case AFDS.iface.GCAS.get_state is

         when GCAS_state_emergency =>
            AFDS.roll.set_emergency_override (True, 0.0);
            AFDS.pitch.set_emergency_override (True, -80.0);
            AFDS.velocity.set_emergency_override (True);

         when GCAS_state_recovery =>
            AFDS.roll.set_emergency_override (True, 0.0);
            AFDS.pitch.set_emergency_override (True, -40.0);
            AFDS.velocity.set_emergency_override (True);

         when GCAS_state_stabilize =>
            AFDS.roll.set_emergency_override (True, 0.0);
            AFDS.pitch.set_emergency_override (True, 0.0);
            AFDS.velocity.set_emergency_override (False);

         when GCAS_state_disengaged =>
            AFDS.roll.set_emergency_override (False, 0.0);
            AFDS.pitch.set_emergency_override (False, 0.0);
            AFDS.velocity.set_emergency_override (False);

      end case;

   end step;

end AFDS.GCAS;

