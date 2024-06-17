with Ada.Text_IO; use Ada.Text_IO;
with components; use components;
with COMIF.aircraft;
with COMIF.NAV;

package body plot is

   f : Ada.Text_IO.File_Type;

   NAV_distance : Float;
   pragma Import (C, NAV_distance, "NAV_distance");

   procedure open (id : Natural) is
      str : String := id'Img;
   begin
      str(str'First) := '_';
      Ada.Text_IO.Create (f, Ada.Text_IO.Out_File, "test" & str & ".csv");

      Put_Line (f,
                "NAV_heading,Heading,NAV_altitude,Altitude,NAV_velocity,Velocity," &
                "Latitude,Longitude," &
                "Target_vertspeed,Vertspeed,Target_roll,Roll,Tartget_pitch,Pitch," &
                "Aileron,Elevator,Rudder,Throttle1,Throttle2,NAV_distance"
               );
   end open;


   procedure close is
   begin
      Ada.Text_IO.Close (f);
   end close;


   procedure step is
      aircraft_status : constant COMIF.aircraft.t_aircraft_status := COMIF.aircraft.read_status (Comp_TEST);
      aircraft_control : constant COMIF.aircraft.t_aircraft_control := COMIF.aircraft.read_control (Comp_TEST);
      NAV_status : constant COMIF.NAV.t_NAV_status := COMIF.NAV.read_status (Comp_TEST);
   begin

      -- heading
      Put_Line (f,
                Float(NAV_status.nav_target.heading)'Img & ", "
                & Float(aircraft_status.heading)'Img & ", "

                & Float(NAV_status.nav_target.altitude)'Img & ", "
                & Float(aircraft_status.altitude)'Img & ", "

                & Float(NAV_status.nav_target.velocity)'Img & ", "
                & Float(aircraft_status.velocity)'Img & ", "

                & Float(aircraft_status.latitude)'Img & ", "
                & Float(aircraft_status.longitude)'Img & ", "

                & Float(aircraft_control.target_vertspeed)'Img & ", "
                & Float(aircraft_status.vertspeed)'Img & ", "

                & Float(aircraft_control.target_roll)'Img & ", "
                & Float(aircraft_status.roll)'Img & ", "

                & Float(aircraft_control.target_pitch)'Img & ", "
                & Float(aircraft_status.pitch)'Img & ", "

                & Float(aircraft_status.aileron)'Img & ", "
                & Float(aircraft_status.elevator)'Img & ", "
                & Float(aircraft_status.rudder)'Img & ", "
                & Float(aircraft_status.throttle1)'Img & ", "
                & Float(aircraft_status.throttle2)'Img & ", "
                & NAV_distance'Img
               );

   end step;


end plot;
