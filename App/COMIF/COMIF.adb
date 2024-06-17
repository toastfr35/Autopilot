-------------------------------------------------------
-- Package COMIF
--
-------------------------------------------------------

with COMIF.aircraft;
with COMIF.AFDS;
with COMIF.GCAS;
with COMIF.NAV;
with COMIF.CDU;

package body COMIF is

   procedure reset is
   begin
      COMIF.aircraft.reset;
      COMIF.AFDS.reset;
      COMIF.GCAS.reset;
      COMIF.NAV.reset;
      COMIF.CDU.reset;
   end reset;

end COMIF;
