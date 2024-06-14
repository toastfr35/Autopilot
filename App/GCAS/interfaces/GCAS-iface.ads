-------------------------------------------------------
-- Package GCAS.iface
--
-- Read/Write the HW interfaces for use by GCAS
-------------------------------------------------------

package GCAS.iface is

   procedure reset;
   -- reset the GCAS views of the HW interfaces

   procedure read;
   -- update the GCAS views of the HW interfaces

   procedure write;
   -- write  back to the HW interfaces

end GCAS.iface;
