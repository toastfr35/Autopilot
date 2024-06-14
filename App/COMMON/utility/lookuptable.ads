
generic
   type t_index is delta <>;
   type t_value is delta <>;

package lookuptable is

   type t_LUT_elt is record
      index : t_index;
      value : t_value;
   end record;

   type t_LUT is array (Natural range <>) of t_LUT_elt;

   function LUT_get (LUT : t_LUT; index : t_index) return t_value;

end lookuptable;
