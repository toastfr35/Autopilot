-------------------------------------------------------
-- Package GCAS.IFACE.GCAS
--
-------------------------------------------------------

package body GCAS.iface.GCAS is

   procedure reset is
   begin
      COMIF.GCAS.reset;
      read;
   end reset;

   procedure read is
   begin
      status := COMIF.GCAS.read_status (current_component);
   end read;

   procedure write is
   begin
      COMIF.GCAS.write_status (current_component, status);
   end write;

end GCAS.iface.GCAS;
