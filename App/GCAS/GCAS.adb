-------------------------------------------------------
-- Package GCAS
--
-- Ground Collision Avoidance System
-- Detect potential collision with the ground and execute
-- emergency avoidance maneuver if required
-------------------------------------------------------

with aircraft;
with auto_roll;
with auto_pitch;
with auto_velocity;
use aircraft;
with log;

package body GCAS is

   GCAS_state : t_GCAS_state := disengaged;
   prev_GCAS_state : t_GCAS_state := disengaged;

   emergency_low_altitude : constant t_altitude := 200.0;

   recovery_low_altitube : constant t_altitude := 1000.0;

   reset_timeout : Natural := 1000;


   -------------------------------
   -- Reset internal state
   -------------------------------
   procedure reset is
   begin
      GCAS_state := disengaged;
      prev_GCAS_state := disengaged;
      reset_timeout := 1000;
   end reset;

   -------------------------------
   -- Get the current state ofthe GCAS
   -------------------------------
   function get_CGAS_state return t_GCAS_state is
   begin
      return GCAS_state;
   end get_CGAS_state;

   -------------------------------
   -- Log the change of state
   -------------------------------
   procedure log_GCAS_state_change is
   begin
      if GCAS_state /= prev_GCAS_state then
         case GCAS_state is
            when emergency  => pragma Debug (log.log (log.GCAS, 1, 0, "GCAS: emergency"));
            when recovery   => pragma Debug (log.log (log.GCAS, 1, 0, "GCAS: recovery"));
            when stabilize   => pragma Debug (log.log (log.GCAS, 1, 0, "GCAS: stabilize"));
            when disengaged => pragma Debug (log.log (log.GCAS, 1, 0, "GCAS: disengaged"));
         end case;
      end if;
   end log_GCAS_state_change;


   -------------------------------
   -- Update the state of the GCAS
   -------------------------------
   procedure update_GCAS_state is
      altitude : constant t_altitude := status.altitude;
      vspeed   : constant t_vertspeed := status.vertspeed;
      predicted_altitude : constant t_altitude := altitude + t_altitude (5.0 * vspeed);
   begin
      if predicted_altitude <= emergency_low_altitude then
         GCAS_state := emergency;
      end if;

      -- stabilize -> disengage IF pitch ~= 0 & high enough
      if GCAS_state = stabilize and then
        altitude > recovery_low_altitube and then
        aircraft.status.pitch in -5.0 .. 5.0
      then
         GCAS_state := disengaged;
      end if;

      -- recovery -> stabilize IF high enough
      if GCAS_state = recovery and then
        altitude > recovery_low_altitube
      then
         GCAS_state := stabilize;
      end if;

      -- emergency -> recovery IF moving up and high enough
      if GCAS_state = emergency and then
        vspeed > 5.0 and then
        altitude > emergency_low_altitude
      then
         GCAS_state := recovery;
      end if;
   end update_GCAS_state;


   -------------------------------
   -- Step for the auto-GCAS function
   -------------------------------
   procedure step is
   begin

      if reset_timeout > 0 then
         reset_timeout := reset_timeout - 1;
         return;
      end if;

      update_GCAS_state;

      log_GCAS_state_change;

      prev_GCAS_state := GCAS_state;

      -- apply GCAS command overrides
      case GCAS_state is

         when emergency =>
            auto_roll.set_emergency_override (True, 0.0);
            auto_pitch.set_emergency_override (True, -80.0);
            auto_velocity.set_emergency_override (True);

         when recovery =>
            auto_roll.set_emergency_override (True, 0.0);
            auto_pitch.set_emergency_override (True, -40.0);
            auto_velocity.set_emergency_override (True);

         when stabilize =>
            auto_roll.set_emergency_override (True, 0.0);
            auto_pitch.set_emergency_override (True, 0.0);
            auto_velocity.set_emergency_override (False);

         when disengaged =>
            auto_roll.set_emergency_override (False, 0.0);
            auto_pitch.set_emergency_override (False, 0.0);
            auto_velocity.set_emergency_override (False);

      end case;

   end step;

end GCAS;

