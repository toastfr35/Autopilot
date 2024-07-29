-------------------------------------------------------
-- Generic package PID
--
-------------------------------------------------------

generic
   type t_error is delta <>;
   type t_output is delta <>;

package PID is

   procedure reset;

   function get (Kp, Ki, Kd : Float; error : t_error) return t_output;

end PID;
