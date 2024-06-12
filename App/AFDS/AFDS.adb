-------------------------------------------------------
-- Package AFDS
--
-- Update the aircraft status
-- Run the auto_* tasks
-- Commit the aircraft control commands
-------------------------------------------------------

with nav_AFDS;
with auto_heading;
with auto_altitude;
with auto_velocity;
with auto_vspeed;
with auto_roll;
with auto_pitch;
with ctrl_aileron;
with ctrl_elevator;
with ctrl_rudder;
with ctrl_throttle;

package body AFDS is

   -------------------------------
   -- Step for the autopilot function
   -------------------------------
   procedure step is
   begin
      nav_AFDS.step;
      auto_heading.step;
      auto_altitude.step;
      auto_velocity.step;
      auto_vspeed.step;
      auto_roll.step;
      auto_pitch.step;
   end step;


   -------------------------------
   --
   -------------------------------
   procedure reset is
   begin
      auto_heading.reset;
      auto_altitude.reset;
      auto_velocity.reset;
      auto_vspeed.reset;
      auto_roll.reset;
      auto_pitch.reset;
      ctrl_aileron.reset;
      ctrl_elevator.reset;
      ctrl_rudder.reset;
      ctrl_throttle.reset;
   end reset;

end AFDS;
