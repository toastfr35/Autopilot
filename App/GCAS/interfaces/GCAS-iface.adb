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
      aircraft.reset;
      GCAS.reset;
   end reset;


   -------------------------------
   -- update the GCAS views of the HW interfaces
   -------------------------------
   procedure read is
   begin
      aircraft.read;
      GCAS.read;
   end read;


   -------------------------------
   -- write back to the HW interfaces
   -------------------------------
   procedure write is
   begin
      GCAS.write;
   end write;


end GCAS.iface;
