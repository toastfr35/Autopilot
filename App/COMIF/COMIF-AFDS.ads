-------------------------------------------------------
-- Package COMIF.AFDS
--
-- This package provides R/W access to the AFDS status
-------------------------------------------------------

with components; use components;
with types;

package COMIF.AFDS is

   -------------------------------
   -- R/W access rights
   -------------------------------
   read_access_status   : constant t_access_rights := (Comp_AFDS => True,  Comp_GCAS => False, Comp_NAV => False, Comp_CDU => True,  Comp_FDM => False,  Comp_TEST => True);
   write_access_status  : constant t_access_rights := (Comp_AFDS => True,  Comp_GCAS => False, Comp_NAV => False, Comp_CDU => True,  Comp_FDM => False, Comp_TEST => True);


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

   function read_status (component : t_component) return t_AFDS_status;
   pragma Export (C, read_status, "COMIF_AFDS_read_status");

   procedure write_status (component : t_component; status : t_AFDS_status);
   pragma Export (C, write_status, "COMIF_AFDS_write_status");

end COMIF.AFDS;
