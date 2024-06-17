-------------------------------------------------------
-- Package AFDS.IFACE.NAV
--
-- Configure the AFDS parameters
-- Read current AFDS configuration
-------------------------------------------------------

package body AFDS.iface.NAV is

   procedure reset is
   begin
      COMIF.NAV.reset;
      read;
   end reset;

   procedure read is
   begin
      status := COMIF.NAV.read_status (current_component);
   end read;

end AFDS.iface.NAV;
