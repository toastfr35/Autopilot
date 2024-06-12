with System;

package body aircraft_interface is
       
   -------------------------------
   -- Status of the plane
   -------------------------------
   type t_status is record
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
   for t_status use record
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

   status : t_status;
   for status'Address use System'To_Address(16#800000#);
   pragma Volatile (status);

   procedure read (aileron   : out t_aileron;
                   elevator  : out t_elevator;
                   rudder    : out t_rudder;
                   throttle1 : out t_throttle;
                   throttle2 : out t_throttle;
                   latitude  : out t_latitude;
                   longitude : out t_longitude;
                   altitude  : out t_altitude;     
                   heading   : out t_heading;
                   velocity  : out t_velocity;
                   roll      : out t_roll;
                   pitch     : out t_pitch;
                   vertspeed : out t_vertspeed)
   is
   begin
      aileron   := aircraft_interface.status.aileron;
      elevator  := aircraft_interface.status.elevator;
      rudder    := aircraft_interface.status.rudder;
      throttle1 := aircraft_interface.status.throttle1;
      throttle2 := aircraft_interface.status.throttle2;
      latitude  := aircraft_interface.status.latitude;
      longitude := aircraft_interface.status.longitude;
      altitude  := aircraft_interface.status.altitude;
      heading   := aircraft_interface.status.heading;
      velocity  := aircraft_interface.status.velocity;
      roll      := aircraft_interface.status.roll;
      pitch     := aircraft_interface.status.pitch;
      vertspeed := aircraft_interface.status.vertspeed;
   end read;
   
   
   
   -------------------------------
   -- Control values for the plane
   -------------------------------
   type t_control is record
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
   for t_control use record
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

   control : t_control;
   for control'Address use System'To_Address(16#800000# + 80);
   pragma Volatile (control);    
      
   type t_info is record
      target_roll : t_roll;
      target_pitch : t_pitch;
      target_vertspeed : t_vertspeed;
   end record;
   
   info : t_info;
   for info'Address use System'To_Address(16#800000# + 128);
   pragma Volatile (info);    
   
      
   procedure write (aileron_enabled   : in out Boolean;
                    aileron           : t_aileron;
                    elevator_enabled  : in out Boolean;      
                    elevator          : t_elevator;
                    rudder_enabled    : in out Boolean;      
                    rudder            : t_rudder;
                    throttle1_enabled : in out Boolean;   
                    throttle1         : t_throttle;
                    throttle2_enabled : in out Boolean;   
                    throttle2         : t_throttle;
                    target_roll       : t_roll;
                    target_pitch      : t_pitch;
                    target_vertspeed  : t_vertspeed
                   )
   is
   begin
      if aileron_enabled then
         aileron_enabled := False;
         aircraft_interface.control.aileron_enabled := True;
         aircraft_interface.control.aileron := aileron;

      end if;
      if elevator_enabled then
         elevator_enabled := False;
         aircraft_interface.control.elevator_enabled := True;
         aircraft_interface.control.elevator := elevator;
      end if;
      if rudder_enabled then
         rudder_enabled := False;
         aircraft_interface.control.rudder_enabled := True;
         aircraft_interface.control.rudder := rudder;
      end if;
      if throttle1_enabled then
         throttle1_enabled := False;
         aircraft_interface.control.throttle1_enabled := True;
         aircraft_interface.control.throttle1 := throttle1;
      end if;
      if throttle2_enabled then
         throttle2_enabled := False;
         aircraft_interface.control.throttle2_enabled := True;
         aircraft_interface.control.throttle2 := throttle2;
      end if;
      aircraft_interface.info.target_roll := target_roll;
      aircraft_interface.info.target_pitch := target_pitch;
      aircraft_interface.info.target_vertspeed := target_vertspeed;
   end write;   
   
   
   procedure get_control (aileron   : out t_aileron;
                          elevator  : out t_elevator;                         
                          rudder    : out t_rudder;
                          throttle1 : out t_throttle;
                          throttle2 : out t_throttle)
   is
   begin
      aileron := aircraft_interface.control.aileron;
      elevator := aircraft_interface.control.elevator;
      rudder := aircraft_interface.control.rudder;
      throttle1 := aircraft_interface.control.throttle1;
      throttle2 := aircraft_interface.control.throttle2;
   end get_control;

   
   
   procedure set_aileron   (v : t_aileron) is 
   begin
      aircraft_interface.status.aileron := v;
   end set_aileron;
         
   procedure set_elevator  (v : t_elevator) is      
   begin
      aircraft_interface.status.elevator := v;
   end set_elevator;         
         
   procedure set_rudder    (v : t_rudder) is      
   begin
      aircraft_interface.status.rudder := v;
   end set_rudder;         
   
   procedure set_throttle1 (v : t_throttle) is      
   begin
      aircraft_interface.status.throttle1 := v;
   end set_throttle1;         
   
   procedure set_throttle2 (v : t_throttle) is      
   begin
      aircraft_interface.status.throttle2 := v;
   end set_throttle2;         
   
   procedure set_latitude  (v : t_latitude) is      
   begin
      aircraft_interface.status.latitude := v;
   end set_latitude;         
   
   procedure set_longitude (v : t_longitude) is      
   begin
      aircraft_interface.status.longitude := v;
   end set_longitude;         
   
   procedure set_altitude  (v : t_altitude) is      
   begin
      aircraft_interface.status.altitude := v;
   end set_altitude;         
   
   procedure set_heading   (v : t_heading) is      
   begin
      aircraft_interface.status.heading := v;
   end set_heading;         
   
   procedure set_velocity  (v : t_velocity) is      
   begin
      aircraft_interface.status.velocity := v;
   end set_velocity;         
   
   procedure set_roll      (v : t_roll) is      
   begin
      aircraft_interface.status.roll := v;
   end set_roll;         
   
   procedure set_pitch     (v : t_pitch) is      
   begin
      aircraft_interface.status.pitch := v;
   end set_pitch;         
   
   procedure set_vertspeed (v : t_vertspeed) is      
   begin
      aircraft_interface.status.vertspeed := v;
   end set_vertspeed;            
   
end aircraft_interface;

