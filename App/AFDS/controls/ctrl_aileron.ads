-------------------------------------------------------
-- Package CTRL_AILERON
--
-- Apply aileron control
-------------------------------------------------------

with aircraft;

package ctrl_aileron is

   procedure set_target(v : aircraft.t_aileron);

   procedure reset;
   -- Reset internal state

end ctrl_aileron;
