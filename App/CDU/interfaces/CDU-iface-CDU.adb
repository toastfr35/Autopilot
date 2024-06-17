-------------------------------------------------------
-- Package CDU.IFACE.CDU
--
-------------------------------------------------------

package body CDU.iface.CDU is

   procedure reset is
   begin
      COMIF.CDU.reset;
      read;
   end reset;

   procedure read is
   begin
      status := COMIF.CDU.read_status (current_component);
   end read;

   procedure write is
   begin
      COMIF.CDU.write_status (current_component, status);
   end write;

end CDU.iface.CDU;
