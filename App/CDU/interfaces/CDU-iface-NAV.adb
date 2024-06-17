-------------------------------------------------------
-- Package GCAS.IFACE.GCAS
--
-------------------------------------------------------

--with log;

package body CDU.iface.NAV is

   procedure reset is
   begin
      COMIF.NAV.reset;
      read;
   end reset;

   procedure read is
   begin
      --log.log (log.CDU, 1, 0, "CDU: Read COMIF.NAV -> CDU.NAV");
      status := COMIF.NAV.read_status (current_component);
   end read;

   procedure write is
   begin
      --log.log (log.CDU, 1, 0, "CDU: Write CDU.NAV -> COMIF.NAV");
      COMIF.NAV.write_status (current_component, status);
      --COMIF.NAV.dump;
   end write;

   procedure dump is
   begin
      COMIF.NAV.dump_X ("CDU.NAV", status);
   end dump;

end CDU.iface.NAV;
