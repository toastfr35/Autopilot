-------------------------------------------------------
-- Package AFDS (Automatic Fligth Director System)
--
-- Read data on relevant interfaces
-- Run the AFDS.* sub-tasks
-- Commit data on relevant interfaces
-------------------------------------------------------

with types; use types;

with AFDS.iface;
with AFDS.heading;
with AFDS.altitude;
with AFDS.hspeed;
with AFDS.vspeed;
with AFDS.roll;
with AFDS.pitch;
with AFDS.aileron;
with AFDS.elevator;
with AFDS.rudder;
with AFDS.throttle;
with AFDS.GCAS;


package body AFDS is

   -- For detecting changes enabled/disabled
   prev_enabled : Boolean := False;


   -------------------------------
   -- Reset internal states
   -------------------------------
   procedure reset is
   begin
      AFDS.iface.reset;
      AFDS.heading.reset;
      AFDS.altitude.reset;
      AFDS.hspeed.reset;
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


   -------------------------------
   -- Enable the AFDS
   -- If NAV is not enabled, keep the current heading, speed, altitude
   ----------- --------------------
   procedure enable_AFDS is
   begin
      AFDS.iface.AFDS.data.enabled := True;
      if not AFDS.iface.NAV.data.enabled then
         -- NAV is not enabled: set default navigation parameters
         AFDS.iface.AFDS.data.nav_target.heading := AFDS.iface.ACS.data.heading;
         AFDS.iface.AFDS.data.nav_target.altitude := AFDS.iface.GPS.data.altitude;
         AFDS.iface.AFDS.data.nav_target.hspeed := AFDS.iface.GPS.data.hspeed;
      end if;
   end enable_AFDS;


   -------------------------------
   -- Disable the AFDS
   -------------------------------
   procedure disable_AFDS is
   begin
      AFDS.iface.AFDS.data.enabled := False;
   end disable_AFDS;


   -------------------------------
   -- Get nav target from NAV if it is enabled
   -------------------------------
   procedure update_nav_target is
   begin
      if AFDS.iface.AFDS.data.enabled then
         if AFDS.iface.NAV.data.enabled then
            AFDS.iface.AFDS.data.nav_target := AFDS.iface.NAV.data.nav_target;
         end if;
      end if;
   end update_nav_target;


   -------------------------------
   -- Step for the autopilot function
   -------------------------------
   procedure step is
   begin
      AFDS.iface.read;

      -- Detect change AFDS enabled/disabled
      if AFDS.iface.AFDS.data.enabled /= prev_enabled then
         prev_enabled := AFDS.iface.AFDS.data.enabled;
         if AFDS.iface.AFDS.data.enabled then
            -- Enable AFDS
            enable_AFDS;
         else
            -- Disable AFDS
            disable_AFDS;
         end if;
      end if;

      -- Is AFDS enabled because of GCAS?
      AFDS.iface.AFDS.data.enabled_by_GCAS := (AFDS.iface.GCAS.data.GCAS_state /= GCAS_state_disengaged);

      -- Perform AFDS function if enabled
      if AFDS.iface.AFDS.data.enabled or else
        AFDS.iface.AFDS.data.enabled_by_GCAS
      then
         update_nav_target;
         AFDS.GCAS.step;
         AFDS.heading.step;
         AFDS.altitude.step;
         AFDS.hspeed.step;
         AFDS.vspeed.step;
         AFDS.roll.step;
         AFDS.pitch.step;
      end if;

      AFDS.iface.write;
   end step;


end AFDS;
