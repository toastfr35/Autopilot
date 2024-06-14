-------------------------------------------------------
-- Package AFDS.iface
--
-- Read/Write the HW interfaces for use by AFDS
-------------------------------------------------------

private package AFDS.iface is

   procedure reset;
   -- reset the AFDS views of the HW interfaces

   procedure read;
   -- update the AFDS views of the HW interfaces

   procedure write;
   -- write  back to the HW interfaces

end AFDS.iface;
