with System;
with components; use components;
with Interfaces;
with COMIF.aircraft;
with COMIF.NAV;
with img;


package body plot is

   NAV_distance : Float;
   pragma Import (C, NAV_distance, "NAV_distance");

   -- FILEOUT plugin interface
   procedure fileio_open (filename : System.Address; len : Interfaces.Unsigned_32);
   procedure fileio_close;
   procedure fileio_write (str : System.Address; len : Interfaces.Unsigned_32);

   pragma Import(C, fileio_open, "fileio_open");
   pragma Import(C, fileio_close, "fileio_close");
   pragma Import(C, fileio_write, "fileio_write");

   procedure OpenFile (filename : String) is
   begin
      fileio_open(filename'Address, filename'Length);
   end OpenFile;

   procedure CloseFile is
   begin
      fileio_close;
   end CloseFile;

   procedure WriteFile (str : String) is
   begin
      fileio_write(str'Address, str'Length);
   end WriteFile;

   procedure open (id : Natural) is
      str : String := id'Img;
   begin
      str(str'First) := '_';
      OpenFile ("test" & str & ".csv");

      WriteFile(
                "NAV_heading,Heading,NAV_altitude,Altitude,NAV_velocity,Velocity," &
                "Latitude,Longitude," &
                "Target_vertspeed,Vertspeed,Target_roll,Roll,Tartget_pitch,Pitch," &
                "Aileron,Elevator,Rudder,Throttle1,Throttle2,NAV_distance"
               );
   end open;


   procedure close is
   begin
      CloseFile;
   end close;


   procedure step is
      aircraft_status : constant COMIF.aircraft.t_aircraft_status := COMIF.aircraft.read_status (Comp_TEST);
      aircraft_control : constant COMIF.aircraft.t_aircraft_control := COMIF.aircraft.read_control (Comp_TEST);
      NAV_status : constant COMIF.NAV.t_NAV_status := COMIF.NAV.read_status (Comp_TEST);
   begin

      -- heading
      WriteFile ( img.Image(Float(NAV_status.nav_target.heading)) & ", "
                & img.Image(Float(aircraft_status.heading)) & ", "

                & img.Image(Float(NAV_status.nav_target.altitude)) & ", "
                & img.Image(Float(aircraft_status.altitude)) & ", "

                & img.Image(Float(NAV_status.nav_target.velocity)) & ", "
                & img.Image(Float(aircraft_status.velocity)) & ", "

                & img.Image(Float(aircraft_status.latitude)) & ", "
                & img.Image(Float(aircraft_status.longitude)) & ", "

                & img.Image(Float(aircraft_control.target_vertspeed)) & ", "
                & img.Image(Float(aircraft_status.vertspeed)) & ", "

                & img.Image(Float(aircraft_control.target_roll)) & ", "
                & img.Image(Float(aircraft_status.roll)) & ", "

                & img.Image(Float(aircraft_control.target_pitch)) & ", "
                & img.Image(Float(aircraft_status.pitch)) & ", "

                & img.Image(Float(aircraft_status.aileron)) & ", "
                & img.Image(Float(aircraft_status.elevator)) & ", "
                & img.Image(Float(aircraft_status.rudder)) & ", "
                & img.Image(Float(aircraft_status.throttle1)) & ", "
                & img.Image(Float(aircraft_status.throttle2)) & ", "
                & img.Image(NAV_distance)
               );
   end step;


end plot;
