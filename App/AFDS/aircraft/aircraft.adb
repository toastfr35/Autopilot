-------------------------------------------------------
-- Package AIRCRAFT
--
-- This package provides
-- * the types for the aircraft flight parameters
-- * read access to the aircraft status
-- * write access to the aircraft controls
-------------------------------------------------------

with aircraft_interface;


package body aircraft is
       
   -------------------------------
   -- Aircraft status information
   -------------------------------  
   package body status is
      
      -------------------------------
      -- Refresh information from HW interface
      -------------------------------
      procedure step is
      begin
         aircraft_interface.read
           (aileron,
            elevator,
            rudder,
            throttle1,
            throttle2,
            latitude,
            longitude,
            altitude,     
            heading,
            velocity,
            roll,
            pitch,
            vertspeed
           );
      end step;   
      
   end status;
   
   
   -------------------------------
   -- Aircraft controls
   -------------------------------  
   package body control is
   
      aileron_enabled   : Boolean;
      aileron           : t_aileron;
      elevator_enabled  : Boolean;      
      elevator          : t_elevator;
      rudder_enabled    : Boolean;      
      rudder            : t_rudder;
      throttle1_enabled : Boolean;   
      throttle1         : t_throttle;
      throttle2_enabled : Boolean;   
      throttle2         : t_throttle;
      target_roll       : t_roll;
      target_pitch      : t_pitch;
      target_vertspeed  : t_vertspeed;     
      
      -------------------------------
      --
      -------------------------------
      procedure set_aileron (v : t_aileron) is      
      begin
         aileron := v;
         aileron_enabled := True;
      end set_aileron;
         
      -------------------------------
      --
      -------------------------------
      procedure set_elevator (v : t_elevator) is
      begin
         control.elevator := v;
         control.elevator_enabled := True;
      end set_elevator;   
   
      -------------------------------
      --
      -------------------------------
      procedure set_rudder (v : t_rudder) is 
      begin
         control.rudder := v;
         control.rudder_enabled := True;      
      end set_rudder;
   
      -------------------------------
      --
      -------------------------------
      procedure set_throttles (v1, v2 : t_throttle) is
      begin
         control.throttle1 := v1;
         control.throttle1_enabled := True;
         control.throttle2 := v2;
         control.throttle2_enabled := True;
      end set_throttles; 
   
      -------------------------------
      --
      -------------------------------   
      procedure set_target_roll (v : t_roll) is
      begin
         target_roll := v;
      end set_target_roll;   
   
      -------------------------------
      --
      -------------------------------   
      procedure set_target_pitch (v : t_pitch) is
      begin
         target_pitch := v;
      end set_target_pitch;   
   
      -------------------------------
      --
      -------------------------------   
      procedure set_target_vertspeed (v : t_vertspeed) is      
      begin
         target_vertspeed := v;
      end set_target_vertspeed;   

      -------------------------------
      -- Commit controls to HW interface
      -------------------------------   
      procedure step is
      begin
         aircraft_interface.write
           (aileron_enabled,
            aileron,           
            elevator_enabled,        
            elevator,          
            rudder_enabled,          
            rudder,            
            throttle1_enabled,    
            throttle1,         
            throttle2_enabled,    
            throttle2,         
            target_roll,       
            target_pitch,      
            target_vertspeed);
      end step;     
      
   end control;         
   
   
end aircraft;
