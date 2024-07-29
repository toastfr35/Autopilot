-------------------------------------------------------
-- Package AFDS.RUDDER
--
-- Apply rudder control
-------------------------------------------------------

with types; use types;

private package AFDS.rudder is

   procedure set_target(v : t_rudder);
   -- Set the rudder position

   procedure reset;
   -- Reset internal state

end AFDS.rudder;
