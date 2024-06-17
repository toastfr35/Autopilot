-------------------------------------------------------
-- Package GCAS.iface
--
-- Read/Write the HW interfaces for use by GCAS
-------------------------------------------------------

with components;

package GCAS.iface is

   current_component : constant components.t_component := components.Comp_GCAS;

   procedure reset;
   -- reset the GCAS views of the HW interfaces

   procedure read;
   -- update the GCAS views of the HW interfaces

   procedure write;
   -- write  back to the HW interfaces

end GCAS.iface;
