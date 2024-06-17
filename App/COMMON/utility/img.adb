
package body img is

   function float_to_string (v : Float) return String;

   function Image (v : Float) return String is (float_to_string (v));
   function Image (v : t_latitude) return String is (float_to_string (Float(v)));
   function Image (v : t_longitude) return String is (float_to_string (Float(v)));
   function Image (v : t_heading) return String is (float_to_string (Float(v)));
   function Image (v : t_roll) return String is (float_to_string (Float(v)));
   function Image (v : t_altitude) return String is (float_to_string (Float(v)));
   function Image (v : t_pitch) return String is (float_to_string (Float(v)));
   function Image (v : t_velocity) return String is (float_to_string (Float(v)));
   function Image (v : t_vertspeed) return String is (float_to_string (Float(v)));
   function Image (v : t_control) return String is (float_to_string (Float(v)));




   function float_to_string (v : Float) return String
   is
      F         : Float := v;
      Str       : String(1 .. 64);
      Pos       : Integer := 1;
      Int_Part  : Integer := Integer(Float'Floor(F));
      Frac_Part : Integer;
   begin
      if v < 0.0 then
         F := -v;
         Str(Pos) := '-';
         Pos := Pos + 1;
      end if;

      Int_Part := Integer(Float'Floor(F));
      Frac_Part := Integer ((F - Float(Int_Part)) * 1000.0);

      declare
         S : constant String := Int_Part'Img;
      begin
         for i in S'First+1 .. S'Last loop
            Str(Pos) := S(i);
            Pos := Pos + 1;
         end loop;
      end;

      Str(Pos) := '.';
      Pos := Pos + 1;

      if Frac_Part < 100 then
         Str(Pos) := '0';
         Pos := Pos + 1;
      end if;
      if Frac_Part < 10 then
         Str(Pos) := '0';
         Pos := Pos + 1;
      end if;

      declare
         S : constant String := Frac_Part'Img;
      begin
         for i in S'First+1 .. S'Last loop
            Str(Pos) := S(i);
            Pos := Pos + 1;
         end loop;
      end;

      return Str(1 .. Pos-1);
   end float_to_string;





end img;
