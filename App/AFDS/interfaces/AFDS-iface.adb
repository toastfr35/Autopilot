-------------------------------------------------------
-- Package AFDS.iface
--
-- Read/Write the HW interfaces for use by AFDS
-------------------------------------------------------

with AFDS.iface.aircraft;
with AFDS.iface.NAV;
with AFDS.iface.GCAS;

package body AFDS.iface is

   -------------------------------
   -- reset the AFDS views of the HW interfaces
   -------------------------------
   procedure reset is
   begin
      AFDS.iface.aircraft.reset;
      AFDS.iface.GCAS.reset;
      AFDS.iface.NAV.reset;
   end reset;


   -------------------------------
   -- update the AFDS views of the HW interfaces
   -------------------------------
   procedure read is
   begin
      AFDS.iface.aircraft.read;
      AFDS.iface.GCAS.read;
      AFDS.iface.NAV.read;
   end read;


   -------------------------------
   -- write  back to the HW interfaces
   -------------------------------
   procedure write is
   begin
      AFDS.iface.aircraft.write;
   end write;

end AFDS.iface;
