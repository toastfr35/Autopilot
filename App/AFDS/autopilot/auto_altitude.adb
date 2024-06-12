-------------------------------------------------------
-- Package AUTO_ALTITUDE
--
-- Set the desired vertical speed to reach the desired altitude
-------------------------------------------------------

with auto_vspeed;
with aircraft; use aircraft;
with nav_AFDS;
with lookuptable;

with log;
with img;

package body auto_altitude is

   type t_altitude_correction is delta 10.0 ** (-3) range -51000.0 .. 51000.0;

   -------------------------------
   -- Range of allowed vertical speed to request
   -------------------------------
   subtype t_vspeed_limit is t_vertspeed range -150.0 ..150.0;


   -------------------------------
   -- Lookup Table for altitude correction -> vertical speed
   -------------------------------
   package p_LUT is new lookuptable (t_altitude_correction, t_vertspeed);
   LUT : constant p_LUT.t_LUT := ((0.0,    0.0),
                         (15.0,   2.0),
                         (25.0,   3.0),
                         (50.0,   5.0),
                         (75.0,   7.0),
                         (100.0,  15.0),
                         (200.0,  30.0),
                         (500.0,  60.0),
                         (1000.0, 120.0),
                         (t_altitude_correction'Last, 150.0)
                        );

   prev_target_altitude : t_altitude := 0.0;


   -------------------------------
   -- Reset internal state
   -------------------------------
   procedure reset is
   begin
      prev_target_altitude := 0.0;
   end reset;


   -------------------------------
   -- Compute the altitude correction to apply
   -------------------------------
   function altitude_correction return t_altitude_correction is
      a : constant t_altitude := status.altitude;
      a_t : constant t_altitude := nav_AFDS.get_altitude;
   begin
      if a_t /= prev_target_altitude then
         pragma Debug (log.log (log.altitude, 1, 0, "Target altitude:" & img.Image(a_t)));
         prev_target_altitude := a_t;
      end if;
      return t_altitude_correction (Float(a_t) - Float(a));
   end altitude_correction;


   -------------------------------
   -- Step function for the auto-altitude function
   -------------------------------
   procedure step is
      correction : constant t_altitude_correction := altitude_correction;
      abs_correction : t_altitude_correction;
      sign : t_altitude_correction;
      target_vspeed : t_vertspeed;
   begin

      if correction < 0.0 then
         abs_correction := - correction;
         sign := -1.0;
      else
         abs_correction := correction;
         sign := 1.0;
      end if;

      -- compute desired vertical speed to apply altitude correction
      -- correction > 0 : need to go up => vspeed positive
      -- correction < 0 : need to go down => vspeed negative
      target_vspeed := p_LUT.LUT_get (LUT, abs_correction);
      --log.log (log.altitude, 50, 0, ">>" & Image(abs_correction) & " =>" & Image(target_vspeed));
      target_vspeed := target_vspeed * sign;

      -- limit vertical speed
      target_vspeed := t_vertspeed'Max (target_vspeed, t_vspeed_limit'First);
      target_vspeed := t_vertspeed'Min (target_vspeed, t_vspeed_limit'Last);

      --log.log (log.altitude, 200, 0, "VSPEED:" & Image(correction) & " -> " & Image(target_vspeed));

      -- set the desired vertical speed to apply the altitude correction
      auto_vspeed.set_target (target_vspeed);
   end step;

end auto_altitude;
