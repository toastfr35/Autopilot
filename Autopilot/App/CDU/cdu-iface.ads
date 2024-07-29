-------------------------------------------------------
-- Package CDU.iface
--
-- Read/Write the HW interfaces for use by CDU
-------------------------------------------------------

with COMIF.AFDS;
with COMIF.GCAS;
with COMIF.NAV;
with COMIF.CDU;

with components;
with component_iface;

package CDU.iface is

   current_component : constant components.t_component := components.Comp_CDU;

   procedure reset;
   -- reset the CDU views of the HW interfaces

   procedure read;
   -- update the CDU views of the HW interfaces

   procedure write;
   -- write  back to the HW interfaces

   package AFDS is new component_iface (current_component, COMIF.AFDS.t_AFDS_status, COMIF.AFDS.reset, COMIF.AFDS.read, COMIF.AFDS.write);
   package CDU is new component_iface  (current_component, COMIF.CDU.t_CDU_status,   COMIF.CDU.reset,  COMIF.CDU.read,  COMIF.CDU.write);
   package GCAS is new component_iface (current_component, COMIF.GCAS.t_GCAS_status, COMIF.GCAS.reset, COMIF.GCAS.read, COMIF.GCAS.write);
   package NAV is new component_iface  (current_component, COMIF.NAV.t_NAV_status,   COMIF.NAV.reset,  COMIF.NAV.read,  COMIF.NAV.write);

end CDU.iface;
