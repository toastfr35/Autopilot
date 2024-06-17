-------------------------------------------------------
-- Package AFDS (Automatic Fligth Director System)
--
-- Read data on relevant interfaces
-- Run the AFDS.* sub-tasks
-- Commit data on relevant interfaces
-------------------------------------------------------

with types; use types;

with AFDS.iface;
with AFDS.iface.AFDS;
with AFDS.iface.GCAS;
with AFDS.iface.NAV;
with AFDS.iface.aircraft;
with AFDS.heading;
with AFDS.altitude;
with AFDS.velocity;
with AFDS.vspeed;
with AFDS.roll;
with AFDS.pitch;
with AFDS.aileron;
with AFDS.elevator;
with AFDS.rudder;
with AFDS.throttle;
with AFDS.GCAS;
with log;

package body AFDS is


   prev_enabled : Boolean := False;

   -------------------------------
   --
   -------------------------------
   procedure enable_AFDS is
   begin
      AFDS.iface.AFDS.status.enabled := True;
      if not AFDS.iface.NAV.status.enabled then
         -- NAV is not enabled: set default navigation parameters
         log.log (log.AFDS, 1, 0, "AFDS: Enable AFDS");
         AFDS.iface.AFDS.status.nav_target.heading := AFDS.iface.aircraft.status.heading;
         AFDS.iface.AFDS.status.nav_target.altitude := AFDS.iface.aircraft.status.altitude;
         AFDS.iface.AFDS.status.nav_target.velocity := AFDS.iface.aircraft.status.velocity;
      end if;
   end enable_AFDS;


   -------------------------------
   --
   -------------------------------
   procedure disable_AFDS is
   begin
      log.log (log.AFDS, 1, 0, "AFDS: Disable AFDS");
      AFDS.iface.AFDS.status.enabled := False;
   end disable_AFDS;


   -------------------------------
   --
   -------------------------------
   procedure update_nav_target is
   begin
      if AFDS.iface.AFDS.status.enabled then
         if AFDS.iface.NAV.status.enabled then
            AFDS.iface.AFDS.status.nav_target := AFDS.iface.NAV.status.nav_target;
         end if;
      end if;
   end update_nav_target;

   -------------------------------
   -- Step for the autopilot function
   -------------------------------
   procedure step is
   begin
      AFDS.iface.read;

      if AFDS.iface.AFDS.status.enabled /= prev_enabled then
         prev_enabled := AFDS.iface.AFDS.status.enabled;
         if AFDS.iface.AFDS.status.enabled then
            -- Enable AFDS
            enable_AFDS;
         else
            -- Disable AFDS
            disable_AFDS;
         end if;
      end if;

      -- GCAS engaged?
      AFDS.iface.AFDS.status.enabled_by_GCAS := (AFDS.iface.GCAS.status.GCAS_state /= GCAS_state_disengaged);

      if AFDS.iface.AFDS.status.enabled or else
        AFDS.iface.AFDS.status.enabled_by_GCAS
      then
         update_nav_target;
         AFDS.GCAS.step;
         AFDS.heading.step;
         AFDS.altitude.step;
         AFDS.velocity.step;
         AFDS.vspeed.step;
         AFDS.roll.step;
         AFDS.pitch.step;
      end if;

      AFDS.iface.write;
   end step;


   -------------------------------
   -- Reset internal states
   -------------------------------
   procedure reset is
   begin
      AFDS.iface.reset;
      AFDS.heading.reset;
      AFDS.altitude.reset;
      AFDS.velocity.reset;
      AFDS.vspeed.reset;
      AFDS.roll.reset;
      AFDS.pitch.reset;
      AFDS.aileron.reset;
      AFDS.elevator.reset;
      AFDS.rudder.reset;
      AFDS.throttle.reset;
      AFDS.GCAS.reset;
      prev_enabled := False;
   end reset;


end AFDS;
