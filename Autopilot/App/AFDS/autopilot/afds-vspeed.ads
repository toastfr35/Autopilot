-------------------------------------------------------
-- Package AFDS.VSPEED
--
-- Set the desired pitch to reach the desired vertical speed
-------------------------------------------------------

with types; use types;

private package AFDS.vspeed is

   procedure set_target (vspeed : t_vspeed);
   -- Set the desired vertical speed

   procedure step;
   -- Step for the auto-vspeed function

   procedure reset;
   -- Reset internal state

end AFDS.vspeed;
