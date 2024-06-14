-------------------------------------------------------
-- Package IFACE.AIRCRAFT
--
-- This package read and write access to the aircraft HW interface
-------------------------------------------------------

package body IFACE.aircraft is
       
   -------------------------------
   -- Status of the plane
   -------------------------------
   aircraft_status : t_aircraft_status;
   pragma Export (C, aircraft_status, "aircraft_status");
      
   function status return t_aircraft_status is
   begin
      return aircraft_status;
   end status;   

   
   -------------------------------
   -- Control of the plane
   -------------------------------         

   aircraft_control : t_aircraft_control;      
   pragma Export (C, aircraft_control, "aircraft_control");      
   
   package body control is
            
      procedure command_aileron (v : t_aileron) is
      begin
         aircraft_control.command_aileron := v;
      end command_aileron;
               
      procedure command_elevator (v : t_elevator) is
      begin
         aircraft_control.command_elevator := v;
      end command_elevator;
      
      procedure command_rudder (v : t_rudder) is
      begin
         aircraft_control.command_rudder := v;
      end command_rudder;
      
      procedure command_throttle1 (v : t_throttle) is
      begin
         aircraft_control.command_throttle1 := v;
      end command_throttle1;
      
      procedure command_throttle2 (v : t_throttle) is
      begin
         aircraft_control.command_throttle2 := v;
      end command_throttle2;
   
      procedure target_roll (v : t_roll)  is
      begin
         aircraft_control.target_roll := v;
      end target_roll;
      
      procedure target_pitch (v : t_pitch)  is
      begin
         aircraft_control.target_pitch := v;
      end target_pitch;
      
      procedure target_vertspeed (v : t_vertspeed)  is
      begin
         aircraft_control.target_vertspeed := v;
      end target_vertspeed;
      
   end control;
   
   
   -------------------------------
   -- only for simulation
   -------------------------------   
   package body SIM is

      procedure set_aileron   (v : t_aileron) is 
      begin
         aircraft_status.aileron := v;
      end set_aileron;
         
      procedure set_elevator  (v : t_elevator) is      
      begin
         aircraft_status.elevator := v;
      end set_elevator;         
         
      procedure set_rudder    (v : t_rudder) is      
      begin
         aircraft_status.rudder := v;
      end set_rudder;         
   
      procedure set_throttle1 (v : t_throttle) is      
      begin
         aircraft_status.throttle1 := v;
      end set_throttle1;         
   
      procedure set_throttle2 (v : t_throttle) is      
      begin
         aircraft_status.throttle2 := v;
      end set_throttle2;         
   
      procedure set_latitude  (v : t_latitude) is      
      begin
         aircraft_status.latitude := v;
      end set_latitude;         
   
      procedure set_longitude (v : t_longitude) is      
      begin
         aircraft_status.longitude := v;
      end set_longitude;         
   
      procedure set_altitude  (v : t_altitude) is      
      begin
         aircraft_status.altitude := v;
      end set_altitude;         
   
      procedure set_heading   (v : t_heading) is      
      begin
         aircraft_status.heading := v;
      end set_heading;         
   
      procedure set_velocity  (v : t_velocity) is      
      begin
         aircraft_status.velocity := v;
      end set_velocity;         
   
      procedure set_roll      (v : t_roll) is      
      begin
         aircraft_status.roll := v;
      end set_roll;         
   
      procedure set_pitch     (v : t_pitch) is      
      begin
         aircraft_status.pitch := v;
      end set_pitch;         
   
      procedure set_vertspeed (v : t_vertspeed) is      
      begin
         aircraft_status.vertspeed := v;
      end set_vertspeed;          
         
      procedure apply_all_commands is
      begin
         aircraft_status.aileron   := aircraft_control.command_aileron;
         aircraft_status.elevator  := aircraft_control.command_elevator;
         aircraft_status.rudder    := aircraft_control.command_rudder;
         aircraft_status.throttle1 := aircraft_control.command_throttle1;
         aircraft_status.throttle2 := aircraft_control.command_throttle2;            
      end apply_all_commands;         
         
   end SIM;   
              
   
end IFACE.aircraft;

