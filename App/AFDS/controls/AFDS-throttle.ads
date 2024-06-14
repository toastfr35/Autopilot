-------------------------------------------------------
-- Package AFDS.THROTTLE
--
-- Apply throttles control
-------------------------------------------------------

with types; use types;

private package AFDS.throttle is

   procedure set_target(v1, v2 : t_throttle);
   -- Set the desired throttle input percentage

   procedure reset;
   -- Reset internal state

end AFDS.throttle;
