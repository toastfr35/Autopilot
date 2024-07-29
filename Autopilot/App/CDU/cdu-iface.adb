-------------------------------------------------------
-- Package GCAS.iface
--
-- Read/Write the HW interfaces for use by GCAS
-------------------------------------------------------

package body CDU.iface is


   -------------------------------
   -- reset the GCAS views of the HW interfaces
   -------------------------------
   procedure reset is
   begin
      CDU.reset;
      NAV.reset;
      AFDS.reset;
      GCAS.reset;
   end reset;


   -------------------------------
   -- update the GCAS views of the HW interfaces
   -------------------------------
   procedure read is
   begin
      CDU.read;
      NAV.read;
      AFDS.read;
      GCAS.read;
   end read;


   -------------------------------
   -- write back to the HW interfaces
   -------------------------------
   procedure write is
   begin
      CDU.write;
      NAV.write;
      AFDS.write;
      GCAS.write;
   end write;


end CDU.iface;
