-------------------------------------------------------
-- Package CDU.iface
--
-- Read/Write the HW interfaces for use by CDU
-------------------------------------------------------

with components;

package CDU.iface is

   current_component : constant components.t_component := components.Comp_CDU;

   procedure reset;
   -- reset the CDU views of the HW interfaces

   procedure read;
   -- update the CDU views of the HW interfaces

   procedure write;
   -- write  back to the HW interfaces

end CDU.iface;
