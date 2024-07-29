-------------------------------------------------------
-- Package IMG
--
-------------------------------------------------------

with types; use types;

package img is

   function Image (v : Float) return String;
   function Image (v : t_latitude) return String;
   function Image (v : t_longitude) return String;
   function Image (v : t_altitude) return String;
   function Image (v : t_heading) return String;
   function Image (v : t_hspeed) return String;
   function Image (v : t_roll) return String;
   function Image (v : t_pitch) return String;
   function Image (v : t_vspeed) return String;
   function Image (v : t_control) return String;

end img;
