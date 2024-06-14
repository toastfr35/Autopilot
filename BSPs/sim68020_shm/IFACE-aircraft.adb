-------------------------------------------------------
-- Package IFACE.AIRCRAFT
--
-- This package read and write access to the aircraft HW interface
-------------------------------------------------------

with System;

package body IFACE.aircraft is
       
   -------------------------------
   -- Status of the plane
   -------------------------------
   type t_status_shm is record
      aileron : t_aileron;
      elevator : t_elevator;
      rudder : t_rudder;
      throttle1 : t_throttle;
      throttle2 : t_throttle;
      latitude : t_latitude;
      longitude : t_longitude;
      altitude : t_altitude;     
      heading : t_heading;
      velocity : t_velocity;
      roll : t_roll;
      pitch : t_pitch;
      vertspeed : t_vertspeed;
   end record;
   for t_status_shm use record
      aileron   at  0 range 0 .. 31;
      elevator  at  4 range 0 .. 31; 
      rudder    at  8 range 0 .. 31; 
      throttle1 at 12 range 0 .. 31; 
      throttle2 at 16 range 0 .. 31; 
      latitude  at 20 range 0 .. 31; 
      longitude at 24 range 0 .. 31; 
      altitude  at 28 range 0 .. 31; 
      heading   at 32 range 0 .. 31;
      velocity  at 36 range 0 .. 31;
      roll      at 40 range 0 .. 31;
      pitch     at 44 range 0 .. 31;
      vertspeed at 48 range 0 .. 31;
   end record;
   status_shm : t_status_shm;
   for status_shm'Address use System'To_Address(16#800000#);
   pragma Volatile (status_shm);   
   
   
   function status return t_aircraft_status is
      R : t_aircraft_status;
   begin
      R.aileron   := status_shm.aileron;
      R.elevator  := status_shm.elevator;
      R.rudder    := status_shm.rudder;
      R.throttle1 := status_shm.throttle1;
      R.throttle2 := status_shm.throttle2;
      R.latitude  := status_shm.latitude;
      R.longitude := status_shm.longitude;
      R.altitude  := status_shm.altitude;
      R.heading   := status_shm.heading;
      R.velocity  := status_shm.velocity;
      R.roll      := status_shm.roll;
      R.pitch     := status_shm.pitch;
      R.vertspeed := status_shm.vertspeed;
      return R;
   end status;   

   
   -------------------------------
   -- Control of the plane
   -------------------------------         

   -------------------------------
   -- Control values for the plane
   -------------------------------
   type t_control_shm is record
      aileron_enabled : Boolean;
      aileron : t_aileron;
      elevator_enabled : Boolean;      
      elevator : t_elevator;
      rudder_enabled : Boolean;      
      rudder : t_rudder;
      throttle1_enabled : Boolean;   
      throttle1 : t_throttle;
      throttle2_enabled : Boolean;   
      throttle2 : t_throttle;
   end record;
   for t_control_shm use record
      aileron_enabled   at  0 range 0 .. 31;      
      aileron           at  4 range 0 .. 31;
      elevator_enabled  at  8 range 0 .. 31; 
      elevator          at 12 range 0 .. 31; 
      rudder_enabled    at 16 range 0 .. 31; 
      rudder            at 20 range 0 .. 31; 
      throttle1_enabled at 24 range 0 .. 31; 
      throttle1         at 28 range 0 .. 31; 
      throttle2_enabled at 32 range 0 .. 31; 
      throttle2         at 36 range 0 .. 31; 
   end record;

   control_shm : t_control_shm;
   for control_shm'Address use System'To_Address(16#800000# + 80);
   pragma Volatile (control_shm);    
      
   type t_info_shm is record
      target_roll : t_roll;
      target_pitch : t_pitch;
      target_vertspeed : t_vertspeed;
   end record;
   
   info_shm : t_info_shm;
   for info_shm'Address use System'To_Address(16#800000# + 128);
   pragma Volatile (info_shm);   
   
   
   package body control is
            
      procedure command_aileron (v : t_aileron) is
      begin
         control_shm.aileron := v;
         control_shm.aileron_enabled := True;
      end command_aileron;
               
      procedure command_elevator (v : t_elevator) is
      begin
         control_shm.elevator := v;
         control_shm.elevator_enabled := True;
      end command_elevator;
      
      procedure command_rudder (v : t_rudder) is
      begin
         control_shm.rudder := v;
         control_shm.rudder_enabled := True;
      end command_rudder;
      
      procedure command_throttle1 (v : t_throttle) is
      begin
         control_shm.throttle1 := v;
         control_shm.throttle1_enabled := True;
      end command_throttle1;
      
      procedure command_throttle2 (v : t_throttle) is
      begin
         control_shm.throttle2 := v;
         control_shm.throttle2_enabled := True;
      end command_throttle2;
   
      procedure target_roll (v : t_roll)  is
      begin
         info_shm.target_roll := v;
      end target_roll;
      
      procedure target_pitch (v : t_pitch)  is
      begin
         info_shm.target_pitch := v;
      end target_pitch;
      
      procedure target_vertspeed (v : t_vertspeed)  is
      begin
         info_shm.target_vertspeed := v;
      end target_vertspeed;
      
   end control;
   
   
   -------------------------------
   -- only for simulation
   -------------------------------   
   package body SIM is

      procedure set_aileron   (v : t_aileron) is 
      begin
         status_shm.aileron := v;
      end set_aileron;
         
      procedure set_elevator  (v : t_elevator) is      
      begin
         status_shm.elevator := v;
      end set_elevator;         
         
      procedure set_rudder    (v : t_rudder) is      
      begin
         status_shm.rudder := v;
      end set_rudder;         
   
      procedure set_throttle1 (v : t_throttle) is      
      begin
         status_shm.throttle1 := v;
      end set_throttle1;         
   
      procedure set_throttle2 (v : t_throttle) is      
      begin
         status_shm.throttle2 := v;
      end set_throttle2;         
   
      procedure set_latitude  (v : t_latitude) is      
      begin
         status_shm.latitude := v;
      end set_latitude;         
   
      procedure set_longitude (v : t_longitude) is      
      begin
         status_shm.longitude := v;
      end set_longitude;         
   
      procedure set_altitude  (v : t_altitude) is      
      begin
         status_shm.altitude := v;
      end set_altitude;         
   
      procedure set_heading   (v : t_heading) is      
      begin
         status_shm.heading := v;
      end set_heading;         
   
      procedure set_velocity  (v : t_velocity) is      
      begin
         status_shm.velocity := v;
      end set_velocity;         
   
      procedure set_roll      (v : t_roll) is      
      begin
         status_shm.roll := v;
      end set_roll;         
   
      procedure set_pitch     (v : t_pitch) is      
      begin
         status_shm.pitch := v;
      end set_pitch;         
   
      procedure set_vertspeed (v : t_vertspeed) is      
      begin
         status_shm.vertspeed := v;
      end set_vertspeed;          
         
      procedure apply_all_commands is
      begin
         status_shm.aileron   := control_shm.aileron;
         status_shm.elevator  := control_shm.elevator;
         status_shm.rudder    := control_shm.rudder;
         status_shm.throttle1 := control_shm.throttle1;
         status_shm.throttle2 := control_shm.throttle2;            
      end apply_all_commands;         
         
   end SIM;   
             
   package body info is

      function get_target_roll return t_roll is
      begin
         return info_shm.target_roll;
      end get_target_roll;
      
      function get_target_pitch return t_pitch is
      begin
         return info_shm.target_pitch;
      end get_target_pitch;
      
      function get_target_vertspeed return t_vertspeed is
      begin
         return info_shm.target_vertspeed;
      end get_target_vertspeed;
      
   end info;      
   
   
end IFACE.aircraft;

