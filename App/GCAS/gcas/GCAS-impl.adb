-------------------------------------------------------
-- Package GCAS.IMPL
--
-- Ground Collision Avoidance System
-- Detect potential collision with the ground and execute
-- emergency avoidance maneuver if required
-------------------------------------------------------

with types; use types;

with GCAS.iface.aircraft;
with GCAS.iface.GCAS;
with log;

package body GCAS.IMPL is

   prev_GCAS_state : t_GCAS_state := GCAS_state_disengaged;

   emergency_low_altitude : constant t_altitude := 200.0;

   recovery_low_altitube : constant t_altitude := 1000.0;

   init_timeout : Natural := 1000;


   -------------------------------
   -- Reset internal state
   -------------------------------
   procedure reset is
   begin
      prev_GCAS_state := GCAS_state_disengaged;
      init_timeout := 1000;
   end reset;


   -------------------------------
   -- Log the change of state
   -------------------------------
   procedure log_GCAS_state_change is
   begin
      if GCAS.iface.GCAS.get_state /= prev_GCAS_state then
         case GCAS.iface.GCAS.get_state is
            when GCAS_state_emergency  => pragma Debug (log.log (log.GCAS, 1, 0, "GCAS: emergency"));
            when GCAS_state_recovery   => pragma Debug (log.log (log.GCAS, 1, 0, "GCAS: recovery"));
            when GCAS_state_stabilize   => pragma Debug (log.log (log.GCAS, 1, 0, "GCAS: stabilize"));
            when GCAS_state_disengaged => pragma Debug (log.log (log.GCAS, 1, 0, "GCAS: disengaged"));
         end case;
      end if;
   end log_GCAS_state_change;


   -------------------------------
   -- Update the state of the GCAS
   -------------------------------
   procedure update_GCAS_state is
      altitude : constant t_altitude := GCAS.iface.aircraft.status.altitude;
      vspeed   : constant t_vertspeed := GCAS.iface.aircraft.status.vertspeed;
      predicted_altitude : constant t_altitude := altitude + t_altitude (5.0 * vspeed);
   begin
      if predicted_altitude <= emergency_low_altitude then
         GCAS.iface.GCAS.set_state (GCAS_state_emergency);
      end if;

      -- stabilize -> disengaged IF pitch ~= 0 & high enough
      if GCAS.iface.GCAS.get_state = GCAS_state_stabilize and then
        altitude > recovery_low_altitube and then
        GCAS.iface.aircraft.status.pitch in -5.0 .. 5.0
      then
         GCAS.iface.GCAS.set_state (GCAS_state_disengaged);
      end if;

      -- recovery -> stabilize IF high enough
      if GCAS.iface.GCAS.get_state = GCAS_state_recovery and then
        altitude > recovery_low_altitube
      then
         GCAS.iface.GCAS.set_state (GCAS_state_stabilize);
      end if;

      -- emergency -> recovery IF moving up and high enough
      if GCAS.iface.GCAS.get_state = GCAS_state_emergency and then
        vspeed > 5.0 and then
        altitude > emergency_low_altitude
      then
         GCAS.iface.GCAS.set_state (GCAS_state_recovery);
      end if;
   end update_GCAS_state;


   -------------------------------
   -- Step for the auto-GCAS function
   -------------------------------
   procedure step is
   begin
      if init_timeout > 0 then
         init_timeout := init_timeout - 1;
         return;
      end if;
      update_GCAS_state;
      log_GCAS_state_change;
      prev_GCAS_state := GCAS.iface.GCAS.get_state;
   end step;


end GCAS.IMPL;

