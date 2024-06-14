with Ada.Text_IO; use Ada.Text_IO;
with IFACE.aircraft;
with IFACE.NAV;

package body plot is

   f : Ada.Text_IO.File_Type;

   procedure open (id : Natural) is
      str : String := id'Img;
   begin
      str(str'First) := '_';
      Ada.Text_IO.Create (f, Ada.Text_IO.Out_File, "test" & str & ".csv");

      Put_Line (f,
                "NAV_heading,Heading,NAV_altitude,Altitude,NAV_velocity,Velocity," &
                "Latitude,Longitude," &
                "Target_vertspeed,Vertspeed,Target_roll,Roll,Tartget_pitch,Pitch," &
                "Aileron,Elevator,Rudder,Throttle1,Throttle2"
               );
   end open;


   procedure close is
   begin
      Ada.Text_IO.Close (f);
   end close;


   procedure step is
   begin

      -- heading
      Put_Line (f,
                Float(IFACE.NAV.get_heading)'Img & ", "
                & Float(IFACE.aircraft.status.heading)'Img & ", "

                & Float(IFACE.NAV.get_altitude)'Img & ", "
                & Float(IFACE.aircraft.status.altitude)'Img & ", "

                & Float(IFACE.NAV.get_velocity)'Img & ", "
                & Float(IFACE.aircraft.status.velocity)'Img & ", "

                & Float(IFACE.aircraft.status.latitude)'Img & ", "
                & Float(IFACE.aircraft.status.longitude)'Img & ", "

                & Float(IFACE.aircraft.info.get_target_vertspeed)'Img & ", "
                & Float(IFACE.aircraft.status.vertspeed)'Img & ", "

                & Float(IFACE.aircraft.info.get_target_roll)'Img & ", "
                & Float(IFACE.aircraft.status.roll)'Img & ", "

                & Float(IFACE.aircraft.info.get_target_pitch)'Img & ", "
                & Float(IFACE.aircraft.status.pitch)'Img & ", "

                & Float(IFACE.aircraft.status.aileron)'Img & ", "
                & Float(IFACE.aircraft.status.elevator)'Img & ", "
                & Float(IFACE.aircraft.status.rudder)'Img & ", "
                & Float(IFACE.aircraft.status.throttle1)'Img & ", "
                & Float(IFACE.aircraft.status.throttle2)'Img
               );

   end step;


end plot;
