-------------------------------------------------------
-- Package COMIF
--
-------------------------------------------------------

with COMIF.ACS;
with COMIF.ACC;
with COMIF.AFDS;
with COMIF.GCAS;
with COMIF.NAV;
with COMIF.CDU;
with COMIF.GPS;
with COMIF.TMAP;

package body COMIF is

   procedure reset is
   begin
      COMIF.ACS.reset;
      COMIF.ACC.reset;
      COMIF.AFDS.reset;
      COMIF.GCAS.reset;
      COMIF.NAV.reset;
      COMIF.CDU.reset;
      COMIF.GPS.reset;
      COMIF.TMAP.reset;
   end reset;

   function read_access (from, to : t_component) return Boolean is
   begin
      return access_rights(from, to) = RW or else
        access_rights(from, to) = RO;
   end read_access;

   function write_access (from, to : t_component) return Boolean is
   begin
      return access_rights(from, to) = RW or else
        access_rights(from, to) = WO;
   end write_access;

end COMIF;
