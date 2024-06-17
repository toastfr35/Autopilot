-------------------------------------------------------
-- Package AFDS.iface
--
-- Read/Write the HW interfaces for use by AFDS
-------------------------------------------------------

with components;

private package AFDS.iface is

   current_component : constant components.t_component := components.Comp_AFDS;

   procedure reset;
   -- reset the AFDS views of the HW interfaces

   procedure read;
   -- update the AFDS views of the HW interfaces

   procedure write;
   -- write  back to the HW interfaces

end AFDS.iface;
