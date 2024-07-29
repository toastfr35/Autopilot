-------------------------------------------------------
-- Package COMIF
--
-------------------------------------------------------

with components; use components;

package COMIF is

   procedure reset;

   type t_access_right is (N, RO, RW, WO);
   type t_access_rights is array (t_component, t_component) of t_access_right;

   --

   function read_access (from, to : t_component) return Boolean;
   function write_access (from, to : t_component) return Boolean;

   access_rights : t_access_rights :=
     --                Comp_AFDS, Comp_GCAS, Comp_NAV, Comp_CDU, Comp_GPS, Comp_ACS, Comp_ACC, Comp_TMAP, Comp_FDM, Comp_TEST
     ( Comp_AFDS => (      RW,        RO,       RO,       N,        RO,       RO,       RW,        N,         N,        N),
       Comp_GCAS => (      N,         RW,       N,        N,        RO,       RO,       N,         RO,        N,        N),
       Comp_NAV  => (      N,         N,        RW,       N,        RO,       RO,       N,         N,         N,        N),
       Comp_CDU  => (      RW,        RW,       RW,       RW,       N,        N,        N,         N,         N,        N),
       Comp_GPS  => (      N,         N,        N,        N,        RW,       N,        N,         N,         N,        N),
       Comp_ACS  => (      N,         N,        N,        N,        N,        N,        N,         N,         N,        N),
       Comp_ACC  => (      N,         N,        N,        N,        N,        N,        N,         N,         N,        N),
       Comp_TMAP => (      N,         N,        N,        N,        RO,       RO,       N,         RW,        N,        N),
       Comp_FDM  => (      N,         N,        N,        N,        RW,       RW,       RO,        RW,        N,        N),
       Comp_TEST => (      RW,        RW,       RW,       RW,       RW,       RW,       RW,        RW,        RW,       RW)
     )
   ;

end COMIF;
