-------------------------------------------------------
-- Package AFDS.IFACE.GCAS
--
-- Read current GCAS state
-------------------------------------------------------

package body AFDS.iface.GCAS is

   procedure reset is
   begin
      COMIF.GCAS.reset;
      read;
   end reset;

   procedure read is
   begin
      status := COMIF.GCAS.read_status (current_component);
   end read;

end AFDS.iface.GCAS;
