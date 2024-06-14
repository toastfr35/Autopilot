
package body lookuptable is

   function LUT_get (LUT : t_LUT; index : t_index) return t_value is
      index1, index2 : t_index;
      value1, value2 : t_value;
      d_i_12, d_i : Float;
      d_v_12 : Float;
   begin
      for i in LUT'First .. LUT'Last-1 loop
         index1 := LUT(i).index;
         index2 := LUT(i+1).index;
         d_i_12 := Float(index2) - Float(index1);
         d_i := Float(index) - Float(index1);
         if index in index1 .. index2 then
            value1 := LUT(i).value;
            value2 := LUT(i+1).value;
            d_v_12 := Float(value2) - Float(value1);
            return value1 + t_value (d_v_12 * (d_i / d_i_12));
         end if;
      end loop;
      return t_value (0.0);
   end LUT_get;

end lookuptable;
