-------------------------------------------------------
-- Package CTRL_RUDDER
--
-- Apply rudder control
-------------------------------------------------------

with aircraft;

package ctrl_rudder is

   procedure set_target(v : aircraft.t_rudder);

   procedure reset;
   -- Reset internal state

end ctrl_rudder;
