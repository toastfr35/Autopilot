-------------------------------------------------------
-- Package AFDS.ELEVATOR
--
-- Apply elevator control
-------------------------------------------------------

with types; use types;

private package AFDS.elevator is

   procedure set_target(v : t_elevator);
   -- Set the elevator position

   procedure reset;
   -- Reset internal state

end AFDS.elevator;
