with System;
with Interfaces;
with COMIF.aircraft;
with COMIF.NAV;
with img;


package body plot is

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
                "Aileron,Elevator,Rudder,Throttle1,Throttle2"
               );
   end open;


   procedure close is
   begin
      CloseFile;
   end close;


   procedure step is
   begin

      WriteFile (
                img.Image(Float(COMIF.NAV.get_heading)) & ", "
                & img.Image(Float(COMIF.aircraft.status.heading)) & ", "

                & img.Image(Float(COMIF.NAV.get_altitude)) & ", "
                & img.Image(Float(COMIF.aircraft.status.altitude)) & ", "

                & img.Image(Float(COMIF.NAV.get_velocity)) & ", "
                & img.Image(Float(COMIF.aircraft.status.velocity)) & ", "

                & img.Image(Float(COMIF.aircraft.status.latitude)) & ", "
                & img.Image(Float(COMIF.aircraft.status.longitude)) & ", "

                & img.Image(Float(COMIF.aircraft.info.get_target_vertspeed)) & ", "
                & img.Image(Float(COMIF.aircraft.status.vertspeed)) & ", "

                & img.Image(Float(COMIF.aircraft.info.get_target_roll)) & ", "
                & img.Image(Float(COMIF.aircraft.status.roll)) & ", "

                & img.Image(Float(COMIF.aircraft.info.get_target_pitch)) & ", "
                & img.Image(Float(COMIF.aircraft.status.pitch)) & ", "

                & img.Image(Float(COMIF.aircraft.status.aileron)) & ", "
                & img.Image(Float(COMIF.aircraft.status.elevator)) & ", "
                & img.Image(Float(COMIF.aircraft.status.rudder)) & ", "
                & img.Image(Float(COMIF.aircraft.status.throttle1)) & ", "
                & img.Image(Float(COMIF.aircraft.status.throttle2))
               );

   end step;


end plot;
