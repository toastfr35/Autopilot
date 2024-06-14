-------------------------------------------------------
-- Package GCAS.iface
--
-- Read/Write the HW interfaces for use by GCAS
-------------------------------------------------------


with GCAS.iface.aircraft;
with GCAS.iface.GCAS;

package body GCAS.iface is


   -------------------------------
   -- reset the GCAS views of the HW interfaces
   -------------------------------
   procedure reset is
   begin
      Standard.GCAS.iface.aircraft.reset;
      Standard.GCAS.iface.GCAS.reset;
   end reset;


   -------------------------------
   -- update the GCAS views of the HW interfaces
   -------------------------------
   procedure read is
   begin
      Standard.GCAS.iface.aircraft.read;
      Standard.GCAS.iface.GCAS.read;
   end read;


   -------------------------------
   -- write back to the HW interfaces
   -------------------------------
   procedure write is
   begin
      Standard.GCAS.iface.GCAS.write;
   end write;


end GCAS.iface;
