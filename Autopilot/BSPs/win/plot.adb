with Ada.Text_IO; use Ada.Text_IO;
with components; use components;
with types;
with COMIF.ACS;
with COMIF.ACC;
with COMIF.NAV;
with COMIF.GPS;
with COMIF.TMAP;
with COMIF.GCAS;
with COMIF.AFDS;

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
                "NAV_heading,AFDS_heading,Heading,"
                & "NAV_altitude,Altitude,"
                & "TMAP_elevation,"
                & "NAV_hspeed,Hspeed,Airspeed,"
                & "Latitude,Longitude,"
                & "Target_Vspeed,Vspeed,"
                & "Target_roll,Roll,"
                & "Target_pitch,Pitch,"
                & "Target_aileron,Aileron,"
                & "Target_elevator,Elevator,"
                & "Target_rudder,Rudder,"
                & "Throttle1,Throttle2,"
                & "NAV_distance,"
                & "GCAS,"
               );
   end open;


   procedure close is
   begin
      Ada.Text_IO.Close (f);
   end close;


   procedure step is
      TMAP_status : constant COMIF.TMAP.t_TMAP_status := COMIF.TMAP.read (Comp_TEST);
      GCAS_status : constant COMIF.GCAS.t_GCAS_status := COMIF.GCAS.read (Comp_TEST);
      GPS_status : constant COMIF.GPS.t_GPS_status := COMIF.GPS.read (Comp_TEST);
      aircraft_status : constant COMIF.ACS.t_ACS_status := COMIF.ACS.read (Comp_TEST);
      aircraft_control : constant COMIF.ACC.t_ACC_control := COMIF.ACC.read (Comp_TEST);
      NAV_status : constant COMIF.NAV.t_NAV_status := COMIF.NAV.read (Comp_TEST);
      AFDS_status : constant COMIF.AFDS.t_AFDS_status := COMIF.AFDS.read (Comp_TEST);
   begin

      -- heading
      Put_Line (f,
                Float(NAV_status.nav_target.heading)'Img & ", "
                & Float(AFDS_status.nav_target.heading)'Img & ", "
                & Float(aircraft_status.heading)'Img & ", "

                & Float(NAV_status.nav_target.altitude)'Img & ", "
                & Float(GPS_status.altitude)'Img & ", "

                & Float(TMAP_status.elevation)'Img & ", "

                & Float(NAV_status.nav_target.hspeed)'Img & ", "
                & Float(GPS_status.hspeed)'Img & ", "
                & Float(aircraft_status.airspeed)'Img & ", "

                & Float(GPS_status.latitude)'Img & ", "
                & Float(GPS_status.longitude)'Img & ", "

                & Float(aircraft_control.target_vertspeed)'Img & ", "
                & Float(GPS_status.vspeed)'Img & ", "

                & Float(aircraft_control.target_roll)'Img & ", "
                & Float(aircraft_status.roll)'Img & ", "

                & Float(aircraft_control.target_pitch)'Img & ", "
                & Float(aircraft_status.pitch)'Img & ", "

                & Float(aircraft_control.command_aileron)'Img & ", "
                & Float(aircraft_status.aileron)'Img & ", "

                & Float(aircraft_control.command_elevator)'Img & ", "
                & Float(aircraft_status.elevator)'Img & ", "

                & Float(aircraft_control.command_rudder)'Img & ", "
                & Float(aircraft_status.rudder)'Img & ", "

                & Float(aircraft_status.throttle1)'Img & ", "
                & Float(aircraft_status.throttle2)'Img & ", "
                & NAV_distance'Img & ", "

                & Integer'Image(types.t_GCAS_state'Pos(GCAS_status.GCAS_state))
               );

   end step;


end plot;

