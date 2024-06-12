with nav_AFDS;
with aircraft;
with Ada.Text_IO; use Ada.Text_IO;

package body plot is

   f_heading : Ada.Text_IO.File_Type;

   procedure open (id : Natural) is
      str : String := id'Img;
   begin
      str(str'First) := '_';
      Ada.Text_IO.Create (f_heading, Ada.Text_IO.Out_File, "plot" & str & "_heading.csv");
   end open;

   procedure close is
   begin
      Ada.Text_IO.Close (f_heading);
   end close;

   procedure step is
   begin
      -- heading
      Put_Line (f_heading, Float(nav_AFDS.get_heading)'Img & ", " & Float(aircraft.status.heading)'Img);
   end step;


end plot;
