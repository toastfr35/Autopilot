-------------------------------------------------------
-- Generic package COMPONENT_IFACE
--
--
-------------------------------------------------------

package body component_iface is

   procedure reset is
   begin
      COMIF_reset;
      read;
   end reset;

   procedure read is
   begin
      data := COMIF_read (component);
   end read;

   procedure write is
   begin
      COMIF_write (component, data);
   end write;

end component_iface;
