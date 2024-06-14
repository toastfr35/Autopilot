-------------------------------------------------------
-- Package AFDS.IFACE.AIRCRAFT
--
-- This package provides
-- * read access to the aircraft status for AFDS
-- * write access to the aircraft controls for AFDS
-------------------------------------------------------

with IFACE.aircraft;

package body AFDS.iface.aircraft is

   -------------------------------
   -- AFDS aircraft status
   -------------------------------
   aircraft_status : t_aircraft_status;
   
   function status return t_aircraft_status is
   begin
      return aircraft_status;
   end status;
   
   
   -------------------------------
   -- AFDS aircraft controls
   -------------------------------
   aircraft_control : t_aircraft_control;
   
   
   -------------------------------
   --
   -------------------------------   
   procedure reset is   
   begin
      null;
   end reset;

   
   -------------------------------
   --
   -------------------------------   
   procedure read is
   begin
      aircraft_status := standard.IFACE.aircraft.status;
   end read;
   
   
   -------------------------------
   --
   -------------------------------   
   procedure write is
   begin
      standard.IFACE.aircraft.control.command_aileron (aircraft_control.command_aileron);
      standard.IFACE.aircraft.control.command_elevator (aircraft_control.command_elevator);
      standard.IFACE.aircraft.control.command_rudder (aircraft_control.command_rudder);
      standard.IFACE.aircraft.control.command_throttle1 (aircraft_control.command_throttle1);
      standard.IFACE.aircraft.control.command_throttle2 (aircraft_control.command_throttle2);
      standard.IFACE.aircraft.control.target_roll (aircraft_control.target_roll);
      standard.IFACE.aircraft.control.target_pitch (aircraft_control.target_pitch);
      standard.IFACE.aircraft.control.target_vertspeed (aircraft_control.target_vertspeed);
   end write;
   
    
   -------------------------------
   --
   -------------------------------   
   package body control is

      procedure set_aileron (v : t_aileron) is      
      begin
         aircraft_control.command_aileron := v;
      end set_aileron;
         
      procedure set_elevator (v : t_elevator) is
      begin
         aircraft_control.command_elevator := v;
      end set_elevator;   
   
      procedure set_rudder (v : t_rudder) is 
      begin
         aircraft_control.command_rudder := v;
      end set_rudder;
   
      procedure set_throttles (v1, v2 : t_throttle) is
      begin
         aircraft_control.command_throttle1 := v1;
         aircraft_control.command_throttle2 := v2;
      end set_throttles; 
     
      procedure set_target_roll (v : t_roll) is
      begin
         aircraft_control.target_roll := v;
      end set_target_roll;   
     
      procedure set_target_pitch (v : t_pitch) is
      begin
         aircraft_control.target_pitch := v;
      end set_target_pitch;   
     
      procedure set_target_vertspeed (v : t_vertspeed) is      
      begin
         aircraft_control.target_vertspeed := v;
      end set_target_vertspeed;   

   end control;         
      
end AFDS.iface.aircraft;
