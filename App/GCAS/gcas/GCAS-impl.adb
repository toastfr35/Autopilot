-------------------------------------------------------
-- Package GCAS.IMPL
--
-- Ground Collision Avoidance System
-- Detect potential collision with the ground
-------------------------------------------------------

with types; use types;

with GCAS.iface.aircraft;
with GCAS.iface.GCAS;
with log;

package body GCAS.IMPL is

   collision_altitude : constant t_altitude := 200.0;

   emergency_altitude : constant t_altitude := 600.0;

   recovery_altitude : constant t_altitude := 1500.0;

   stable_altitude : constant t_altitude := 1400.0;

   -------------------------------
   -- Reset internal state
   -------------------------------
   procedure reset is
   begin
      null;
   end reset;


   -------------------------------
   -- Update the state of the GCAS
   -------------------------------
   procedure update_GCAS_state is
      altitude : constant t_altitude := GCAS.iface.aircraft.status.altitude;
      vspeed   : constant t_vertspeed := GCAS.iface.aircraft.status.vertspeed;
      predicted_altitude : constant t_altitude := altitude + t_altitude (5.0 * vspeed);
   begin

      if predicted_altitude <= collision_altitude then

         -- emergency collision avoidance
         if GCAS.iface.GCAS.status.GCAS_state /= GCAS_state_emergency then
            pragma Debug (log.log (log.GCAS, 1, 0, "GCAS: emergency"));
            GCAS.iface.GCAS.status.GCAS_state := GCAS_state_emergency;
         end if;

      else

         case GCAS.iface.GCAS.status.GCAS_state is

         when GCAS_state_emergency =>
            -- emergency -> recovery
            if vspeed > 5.0 and then altitude > emergency_altitude then
               pragma Debug (log.log (log.GCAS, 1, 0, "GCAS: recovery"));
               GCAS.iface.GCAS.status.GCAS_state := GCAS_state_recovery;
            end if;

         when GCAS_state_recovery =>
            -- recovery -> stabilize
            if altitude > recovery_altitude then
               pragma Debug (log.log (log.GCAS, 1, 0, "GCAS: stabilize"));
               GCAS.iface.GCAS.status.GCAS_state := GCAS_state_stabilize;
            end if;

         when GCAS_state_stabilize =>
            -- stabilize -> disengaged
            if altitude > stable_altitude and then GCAS.iface.aircraft.status.pitch in -2.0 .. 2.0  then
               pragma Debug (log.log (log.GCAS, 1, 0, "GCAS: disengaged"));
               GCAS.iface.GCAS.status.GCAS_state := GCAS_state_disengaged;
            end if;

         when GCAS_state_disengaged =>
            null;

         end case;

      end if;


   end update_GCAS_state;


   -------------------------------
   -- Step for the auto-GCAS function
   -------------------------------
   procedure step is
   begin
      update_GCAS_state;
   end step;


end GCAS.IMPL;

