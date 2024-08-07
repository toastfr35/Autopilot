-------------------------------------------------------
-- Package AFDS.ROLL
--
-- Set the desired aileron control to reach the desired roll
-------------------------------------------------------

with AFDS.iface;
with AFDS.aileron;

with pid;

package body AFDS.roll is

   type t_roll_correction is delta 10.0 ** (-6) range -360.0 .. 360.0;

   subtype t_aileron_limit is Float range -30.0 .. 30.0;
   subtype t_aileron_emergency_limit is Float range -70.0 .. 70.0;

   target_roll_angle : t_roll := 0.0;
   emergency_roll_angle : t_roll := 0.0; -- for GCAS
   emergency_enabled : Boolean := False; -- for GCAS

   package p_pid is new PID (t_roll_correction, t_aileron);
   -- PID function to control aileron

   -------------------------------
   -- Reset internal state
   -------------------------------
   procedure reset is
   begin
      target_roll_angle := 0.0;
      emergency_roll_angle := 0.0;
      emergency_enabled := false;
   end reset;


   -------------------------------
   -- Target roll angle to maintain
   -------------------------------
   procedure set_target (roll_angle : t_roll) is
   begin
      if target_roll_angle /= roll_angle then
         target_roll_angle := roll_angle;
         p_pid.reset;
      end if;
   end set_target;


   -------------------------------
   -- Set the emergency roll angle
   -------------------------------
   procedure set_emergency_override (enabled : Boolean; roll_angle : t_roll) is
   begin
      emergency_enabled := enabled;
      emergency_roll_angle := roll_angle;
   end set_emergency_override;


   -------------------------------
   -- Compute the bank correction to apply
   -------------------------------
   function roll_correction return t_roll_correction is
   begin
      if emergency_enabled then
         AFDS.iface.ACC.data.target_roll := emergency_roll_angle;
         return t_roll_correction (emergency_roll_angle - AFDS.iface.ACS.data.roll);
      else
         AFDS.iface.ACC.data.target_roll := target_roll_angle;
         return t_roll_correction (target_roll_angle - AFDS.iface.ACS.data.roll);
      end if;
   end roll_correction;


   -------------------------------
   -- Step for the auto-bank function
   -------------------------------
   procedure step is
      correction : constant t_roll_correction := roll_correction;
      aileron : Float;
      Kp : constant Float := -3.0;
      Ki : constant Float := 0.0;
      Kd : constant Float := 2.0;
   begin
      -- correction > 0.0 then bank left (aileron negative)
      -- correction < 0.0 then bank right (aileron positive)

      aileron := Float(p_pid.get (Kp, Ki, Kd, correction));

      if emergency_enabled then
         aileron := Float'Max(aileron, t_aileron_emergency_limit'First);
         aileron := Float'Min(aileron, t_aileron_emergency_limit'Last);
      else
         aileron := Float'Max(aileron, t_aileron_limit'First);
         aileron := Float'Min(aileron, t_aileron_limit'Last);
      end if;

      AFDS.aileron.set_target(t_aileron(aileron));
   end step;


end AFDS.roll;
