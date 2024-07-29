-------------------------------------------------------
-- Package GCAS.IFACE
--
-- Read/Write the HW interfaces for use by GCAS
-------------------------------------------------------

package body GCAS.iface is


   -------------------------------
   -- reset the GCAS views of the HW interfaces
   -------------------------------
   procedure reset is
   begin
      GPS.reset;
      ACS.reset;
      GCAS.reset;
      TMAP.reset;
   end reset;


   -------------------------------
   -- update the GCAS views of the HW interfaces
   -------------------------------
   procedure read is
   begin
      GPS.read;
      ACS.read;
      GCAS.read;
      TMAP.read;
   end read;


   -------------------------------
   -- write back to the HW interfaces
   -------------------------------
   procedure write is
   begin
      GCAS.write;
   end write;


end GCAS.iface;
