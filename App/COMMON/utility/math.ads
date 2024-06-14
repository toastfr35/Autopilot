with Interfaces;

package math is

   errno : Interfaces.Unsigned_32;
   pragma Export(C, errno, "__errno");

   function fabs (x : Float) return Float;

   function fsqrt (x : Float) return Float;
   pragma Import(C, fsqrt, "sqrtf");

   function farccos (r : Float) return Float;
   pragma Import(C, farccos, "acosf");

   function fcos (r : Float) return Float;
   pragma Import(C, fcos, "cosf");

   function fsin (r : Float) return Float;
   pragma Import(C, fsin, "sinf");

   function fatan2 (r, s : Float) return Float;
   pragma Import(C, fatan2, "atan2f");

   Pi : constant Float := 3.14159_26535_89793;

   function deg_to_rad (v : Float) return Float is (v * Pi / 180.0);

   function fcos_deg (d : Float) return Float is (fcos(deg_to_rad(d)));

   function fsin_deg (d : Float) return Float is (fsin(deg_to_rad(d)));

end math;
