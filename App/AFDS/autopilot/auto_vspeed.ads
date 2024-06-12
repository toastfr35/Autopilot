-------------------------------------------------------
-- Package AUTO_VSPEED
--
-- Set the desired pitch to reach the desired vertical speed
-------------------------------------------------------

with aircraft;

package auto_vspeed is

   procedure set_target (vspeed : aircraft.t_vertspeed);
   -- Set the desired vertical speed

   procedure step;
   -- Step for the auto-vspeed function

   procedure reset;
   -- Reset internal state

end auto_vspeed;
