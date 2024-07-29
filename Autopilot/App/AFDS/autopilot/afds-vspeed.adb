-------------------------------------------------------
-- Package AFDS.VSPEED
--
-- Set the desired pitch to reach the desired vertical speed
-------------------------------------------------------

with AFDS.iface;
with AFDS.pitch;


package body AFDS.vspeed is

   type t_vertspeed_correction is delta 10.0 ** (-3) range -2000.0 .. 2000.0;

   subtype t_pitch_limit is Float range -440.0 .. 40.0;

   target_vspeed : t_vspeed := 0.0;


   -------------------------------
   -- Reset internal state
   -------------------------------
   procedure reset is
   begin
      target_vspeed := 0.0;
   end reset;


   -------------------------------
   -- Target vertical speed to maintain
   -------------------------------
   procedure set_target (vspeed : t_vspeed) is
   begin
      if target_vspeed /= vspeed then
         target_vspeed := vspeed;
      end if;
   end set_target;


   -------------------------------
   -- Compute the vertical speed correction to apply
   -------------------------------
   function vspeed_correction return t_vertspeed_correction is
      v : constant t_vspeed := AFDS.iface.GPS.data.vspeed;
      v_t : constant t_vspeed := target_vspeed;
   begin
      AFDS.iface.ACC.data.target_vertspeed := target_vspeed;
      return t_vertspeed_correction (v_t - v);
   end vspeed_correction;


   -------------------------------
   -- Step for the auto-pitch function
   -------------------------------
   procedure step is
      correction : constant Float := Float(vspeed_correction);
      target_pitch : Float := 0.0;
   begin
      -- correction > 0.0 : need to go up => pitch negative
      -- correction < 0.0 : need to go down => pitch positive

      target_pitch := 2.0 - (correction / 5.0);

      -- limit vertical speed
      target_pitch := Float'Max (target_pitch, t_pitch_limit'First);
      target_pitch := Float'Min (target_pitch, t_pitch_limit'Last);

      AFDS.pitch.set_target (t_pitch(target_pitch));
   end step;


end AFDS.vspeed;
