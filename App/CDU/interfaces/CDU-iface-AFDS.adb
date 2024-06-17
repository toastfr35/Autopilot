-------------------------------------------------------
-- Package CDU.IFACE.AFDS
--
-------------------------------------------------------

package body CDU.iface.AFDS is

   procedure reset is
   begin
      COMIF.AFDS.reset;
      read;
   end reset;

   procedure read is
   begin
      status := COMIF.AFDS.read_status (current_component);
   end read;

   procedure write is
   begin
      COMIF.AFDS.write_status (current_component, status);
   end write;

end CDU.iface.AFDS;
