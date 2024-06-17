-------------------------------------------------------
-- Package AFDS.IFACE.NAV
--
-- Read current AFDS configuration
-------------------------------------------------------

package body AFDS.iface.AFDS is

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

end AFDS.iface.AFDS;
