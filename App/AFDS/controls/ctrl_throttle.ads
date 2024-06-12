-------------------------------------------------------
-- Package CTRL_THROTTLE
--
-- Apply throttles control
-------------------------------------------------------

with aircraft;

package ctrl_throttle is

   procedure set_target(v1, v2 : aircraft.t_throttle);

   procedure reset;
   -- Reset internal state

end ctrl_throttle;
