-------------------------------------------------------
-- Package AFDS.iface
--
-- Read/Write the HW interfaces for use by AFDS
-------------------------------------------------------

with AFDS.iface;

package body AFDS.iface is

   -------------------------------
   -- reset the AFDS views of the HW interfaces
   -------------------------------
   procedure reset is
   begin
      AFDS.reset;
      ACS.reset;
      ACC.reset;
      GPS.reset;
      GCAS.reset;
      NAV.reset;
   end reset;


   -------------------------------
   -- update the AFDS views of the HW interfaces
   -------------------------------
   procedure read is
   begin
      AFDS.read;
      ACS.read;
      ACC.read;
      GPS.read;
      GCAS.read;
      NAV.read;
   end read;


   -------------------------------
   -- write  back to the HW interfaces
   -------------------------------
   procedure write is
   begin
      AFDS.write;
      ACC.write;
   end write;

end AFDS.iface;
