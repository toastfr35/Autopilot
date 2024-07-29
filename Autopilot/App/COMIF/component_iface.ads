-------------------------------------------------------
-- Generic package COMPONENT_IFACE
--
--
-------------------------------------------------------

with components;

generic
   component : components.t_component;
   type t_COMIF_data is private;

   with procedure COMIF_reset;
   with function COMIF_read (component : components.t_component) return t_COMIF_data;
   with procedure COMIF_write (component : components.t_component; status : t_COMIF_data);

package component_iface is

   subtype t_data is t_COMIF_data;

   data : t_data;

   procedure reset;
   procedure read;
   procedure write;

end component_iface;
