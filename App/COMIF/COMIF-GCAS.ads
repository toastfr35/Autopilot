-------------------------------------------------------
-- Package COMIF.GCAS
--
-------------------------------------------------------

with components; use components;
with types;

package COMIF.GCAS is

   -------------------------------
   -- R/W access rights
   -------------------------------
   read_access_status   : constant t_access_rights := (Comp_AFDS => True,  Comp_GCAS => True,  Comp_NAV => False, Comp_CDU => True,  Comp_FDM => False,  Comp_TEST => True);
   write_access_status  : constant t_access_rights := (Comp_AFDS => False, Comp_GCAS => True,  Comp_NAV => False, Comp_CDU => True,  Comp_FDM => False, Comp_TEST => True);


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

   function read_status (component : t_component) return t_GCAS_status;
   pragma Export (C, read_status, "COMIF_GCAS_read_status");

   procedure write_status (component : t_component; status : t_GCAS_status);
   pragma Export (C, write_status, "COMIF_GCAS_write_status");

end COMIF.GCAS;
