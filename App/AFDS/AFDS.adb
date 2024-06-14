-------------------------------------------------------
-- Package AFDS (Automatic Fligth Director System)
--
-- Read data on relevant interfaces
-- Run the AFDS.* sub-tasks
-- Commit data on relevant interfaces
-------------------------------------------------------

with AFDS.iface;
with AFDS.heading;
with AFDS.altitude;
with AFDS.velocity;
with AFDS.vspeed;
with AFDS.roll;
with AFDS.pitch;
with AFDS.aileron;
with AFDS.elevator;
with AFDS.rudder;
with AFDS.throttle;
with AFDS.GCAS;

package body AFDS is


   -------------------------------
   -- Step for the autopilot function
   -------------------------------
   procedure step is
   begin
      AFDS.iface.read;
      AFDS.GCAS.step;
      AFDS.heading.step;
      AFDS.altitude.step;
      AFDS.velocity.step;
      AFDS.vspeed.step;
      AFDS.roll.step;
      AFDS.pitch.step;
      AFDS.iface.write;
   end step;


   -------------------------------
   -- Reset internal states
   -------------------------------
   procedure reset is
   begin
      AFDS.iface.reset;
      AFDS.heading.reset;
      AFDS.altitude.reset;
      AFDS.velocity.reset;
      AFDS.vspeed.reset;
      AFDS.roll.reset;
      AFDS.pitch.reset;
      AFDS.aileron.reset;
      AFDS.elevator.reset;
      AFDS.rudder.reset;
      AFDS.throttle.reset;
      AFDS.GCAS.reset;
   end reset;


end AFDS;
