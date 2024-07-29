-------------------------------------------------------
-- Package AFDS.HSPEED
--
-- Set the desired throttle control to reach the desired horizontal speed
-------------------------------------------------------

with types; use types;

with AFDS.iface;
with AFDS.throttle;

with img;

package body AFDS.hspeed is

   type t_hspeed_correction is delta 10.0 ** (-3) range -10000.0 .. 10000.0;

   current_throttle : Float := 100.0;
   emergency_enabled : Boolean := False; -- is hspeed controlled by GCAS?
   prev_target_hspeed : t_hspeed := 0.0; -- for detecting changes in hspeed


   -------------------------------
   -- Reset internal state
   -------------------------------
   procedure reset is
   begin
      current_throttle := 100.0;
      emergency_enabled := False;
      prev_target_hspeed := 0.0;
   end reset;


   -------------------------------
   -- Set the emergency hspeed (for GCAS)
   -------------------------------
   procedure set_emergency_override (enabled : Boolean) is
   begin
      emergency_enabled := enabled;
   end set_emergency_override;


   -------------------------------
   -- Compute the hspeed correction to apply
   -------------------------------
   function hspeed_correction return t_hspeed_correction is
      v : constant t_hspeed := AFDS.iface.GPS.data.hspeed;
      v_t : constant t_hspeed := AFDS.iface.AFDS.data.nav_target.hspeed;
   begin
      if v_t /=  prev_target_hspeed then
         prev_target_hspeed := v_t;
      end if;
      return t_hspeed_correction (Float(v_t) - Float(v));
   end hspeed_correction;


   -------------------------------
   -- Step for the auto-hspeed function
   -------------------------------
   procedure step is
      correction : constant t_hspeed_correction := hspeed_correction;
      increment : constant Float := Float(correction) / 1000.0;
   begin
      current_throttle := current_throttle + increment;

      if current_throttle < 5.0 then
         current_throttle := 5.0;
      end if;

      if current_throttle > 100.0 then
         current_throttle := 100.0;
      end if;

      if emergency_enabled then
         -- override for GCAS: 100% throttle
         current_throttle := 100.0;
      end if;

      AFDS.throttle.set_target (t_throttle(current_throttle), t_throttle(current_throttle));
   end step;


end AFDS.hspeed;
