-------------------------------------------------------
-- Package COMIF.AFDS
--
-- This package provides R/W access to the AFDS status
-------------------------------------------------------

with components; use components;
with types;

package COMIF.AFDS is

   -------------------------------
   -- Data types
   -------------------------------

   type t_AFDS_status is record
      enabled         : types.t_Bool32;
      enabled_by_GCAS : types.t_Bool32;
      nav_target      : types.t_nav_target;
   end record;
   for t_AFDS_status use record
      enabled         at  0 range 0 .. 31;
      enabled_by_GCAS at  4 range 0 .. 31;
      nav_target      at  8 range 0 .. 95;
   end record;


   -------------------------------
   -- R/W access to data
   -------------------------------

   procedure reset;
   pragma Export (C, reset, "COMIF_AFDS_reset");

   function read (component : t_component) return t_AFDS_status;
   pragma Export (C, read, "COMIF_AFDS_read");

   procedure write (component : t_component; status : t_AFDS_status);
   pragma Export (C, write, "COMIF_AFDS_write");

end COMIF.AFDS;
