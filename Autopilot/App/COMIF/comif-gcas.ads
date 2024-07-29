-------------------------------------------------------
-- Package COMIF.GCAS
--
-------------------------------------------------------

with components; use components;
with types;

package COMIF.GCAS is

   -------------------------------
   -- Data types
   -------------------------------

   type t_GCAS_status is record
      enabled : types.t_Bool32;
      GCAS_state : types.t_GCAS_state;
   end record;
   for t_GCAS_status use record
      enabled    at  0 range 0 .. 31;
      GCAS_state at  4 range 0 .. 31;
   end record;

   -------------------------------
   -- R/W access to data
   -------------------------------

   procedure reset;
   pragma Export (C, reset, "COMIF_GCAS_reset");

   function read (component : t_component) return t_GCAS_status;
   pragma Export (C, read, "COMIF_GCAS_read");

   procedure write (component : t_component; status : t_GCAS_status);
   pragma Export (C, write, "COMIF_GCAS_write");

end COMIF.GCAS;
