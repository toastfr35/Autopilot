-------------------------------------------------------
-- Package AFDS.HEADING
--
-- Set the roll, rudder and elevator controls to reach the desired heading
-------------------------------------------------------

with types; use types;

with AFDS.iface.aircraft;
with AFDS.iface.NAV;
with AFDS.roll;
with AFDS.pitch;
with AFDS.rudder;

with lookuptable;
with log;
with img;


package body AFDS.heading is

   type t_heading_correction is delta 10.0 ** (-6) range -360.0 .. 720.0;

   subtype t_roll_limit is t_roll range -75.0 .. 75.0;
   subtype t_rudder_limit is t_rudder range -30.0 .. 30.0;

   -------------------------------
   -- Lookup Table for heading correction -> roll angle
   -------------------------------
   package p_LUT_roll is new lookuptable (t_heading_correction, t_roll);
   LUT_roll : constant p_LUT_roll.t_LUT := ((0.0,   0.0),
                                            (5.0,   0.0),
                                            (8.0,   15.0),
                                            (15.0,  20.0),
                                            (20.0,  40.0),
                                            (30.0,  t_roll_limit'Last),
                                            (180.0, t_roll_limit'Last),
                                            (t_heading_correction'Last, t_roll_limit'Last)
                                           );

   -------------------------------
   -- Lookup Table for heading correction -> elevator control
   -------------------------------
   package p_LUT_elevator is new lookuptable (t_heading_correction, t_elevator);
   LUT_elevator : constant p_LUT_elevator.t_LUT := ((0.0,   0.0),
                                                    (10.0,  0.0),
                                                    (15.0,  10.0),
                                                    (30.0,  30.0),
                                                    (180.0, 60.0),
                                                    (t_heading_correction'Last, 50.0)
                                                   );

   -------------------------------
   -- Lookup Table for heading correction -> rudder action
   -------------------------------
   package p_LUT_rudder is new lookuptable (t_heading_correction, t_rudder);
   LUT_rudder : constant p_LUT_rudder.t_LUT := ((0.0,    0.0),
                                                (0.5,    0.0),
                                                (3.0,    30.0),
                                                (15.0,   60.0),
                                                (20.0,   0.0),
                                                (t_heading_correction'Last, 0.0)
                                               );


   prev_target_heading : t_heading := 0.0;


   -------------------------------
   -- Reset internal state
   -------------------------------
   procedure reset is
   begin
      prev_target_heading := 0.0;
   end reset;


   -------------------------------
   -- Compute the heading correction to apply
   -------------------------------
   function heading_correction return t_heading_correction is
      current : constant t_heading := AFDS.iface.aircraft.status.heading;
      target : constant t_heading := AFDS.iface.NAV.get_heading;
      error : t_heading;
      error_is_positive : Boolean;
      correction : t_heading_correction;
   begin

      if target /= prev_target_heading then
         pragma Debug (log.log (log.altitude, 1, 0, "Target heading:" & img.Image(target)));
         prev_target_heading := target;
      end if;


      if current > target then
         error := current - target;
         error_is_positive := True;
         if error > 180.0 then
            error := 360.0 - error;
            error_is_positive := False;
         end if;
      else
         error := target - current;
         error_is_positive := False;
         if error > 180.0 then
            error := 360.0 - error;
            error_is_positive := True;
         end if;
      end if;

      correction := t_heading_correction(-error);
      if not error_is_positive then
         correction := -correction;
      end if;

      return correction;
   end heading_correction;


   -------------------------------
   -- Step for the auto-heading function
   -------------------------------
   procedure step is
      correction : constant t_heading_correction := heading_correction;
      abs_correction : t_heading_correction;
      sign_correction : t_heading_correction;
      target_roll : t_roll;
      target_rudder : t_rudder;
      target_elevator : t_elevator;
   begin
      if correction < 0.0 then
         abs_correction := -correction;
         sign_correction := -1.0;
      else
         abs_correction := correction;
         sign_correction := 1.0;
      end if;

      -- ROLL

      -- compute desired roll angle to apply heading correction
      -- negative correction => positive roll
      -- positive correction => negative roll
      target_roll := p_LUT_roll.LUT_get (LUT_roll, abs_correction) * (-sign_correction);

      -- enfore min/max roll values
      target_roll := t_roll'Max (target_roll, t_roll_limit'First);
      target_roll := t_roll'Min (target_roll, t_roll_limit'Last);

      -- ELEVATOR
      target_elevator := p_LUT_elevator.LUT_get (LUT_elevator, abs_correction);
      AFDS.pitch.set_roll_elevator (target_elevator);

      -- RUDDER
      -- compute desired rudder action to apply heading correction
      -- negative correction => negative rudder
      -- positive correction => positive rudder
      target_rudder := p_LUT_rudder.LUT_get (LUT_rudder, abs_correction) * (sign_correction);

      -- enfore min/max rudder values
      target_rudder := t_rudder'Max (target_rudder, t_rudder_limit'First);
      target_rudder := t_rudder'Min (target_rudder, t_rudder_limit'Last);

      AFDS.rudder.set_target(target_rudder);
      AFDS.roll.set_target (target_roll);
   end step;

end AFDS.heading;
