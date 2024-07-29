package autopilot is
   procedure init;
   pragma Export(C, init, "autopilot_init");
end autopilot;
