-------------------------------------------------------
-- Package CTRL_ELEVATOR
--
-- Apply elevator control
-------------------------------------------------------

with aircraft;

package ctrl_elevator is

   procedure set_target(v : aircraft.t_elevator);

   procedure reset;
   -- Reset internal state

end ctrl_elevator;
