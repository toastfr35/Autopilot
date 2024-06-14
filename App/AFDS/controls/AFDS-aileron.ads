-------------------------------------------------------
-- Package CTRL_AILERON
--
-- Apply aileron control
-------------------------------------------------------

with types; use types;

private package AFDS.aileron is

   procedure set_target(v : t_aileron);
   -- Set the aileron position

   procedure reset;
   -- Reset internal state

end AFDS.aileron;
