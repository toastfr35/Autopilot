-------------------------------------------------------
-- Package AFDS.iface
--
-- Read/Write the HW interfaces for use by AFDS
-------------------------------------------------------

with AFDS.iface.aircraft;
with AFDS.iface.AFDS;
with AFDS.iface.NAV;
with AFDS.iface.GCAS;

package body AFDS.iface is

   -------------------------------
   -- reset the AFDS views of the HW interfaces
   -------------------------------
   procedure reset is
   begin
      AFDS.reset;
      aircraft.reset;
      GCAS.reset;
      NAV.reset;
   end reset;


   -------------------------------
   -- update the AFDS views of the HW interfaces
   -------------------------------
   procedure read is
   begin
      AFDS.read;
      aircraft.read;
      GCAS.read;
      NAV.read;
   end read;


   -------------------------------
   -- write  back to the HW interfaces
   -------------------------------
   procedure write is
   begin
      AFDS.write;
      aircraft.write;
   end write;

end AFDS.iface;
