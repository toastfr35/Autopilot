-------------------------------------------------------
-- Package AFDS.iface
--
-- Read/Write the HW interfaces for use by AFDS
-------------------------------------------------------

with COMIF.ACS;
with COMIF.ACC;
with COMIF.AFDS;
with COMIF.GCAS;
with COMIF.GPS;
with COMIF.NAV;

with component_iface;
with components;

private package AFDS.iface is

   current_component : constant components.t_component := components.Comp_AFDS;

   procedure reset;
   -- reset the AFDS views of the HW interfaces

   procedure read;
   -- update the AFDS views of the HW interfaces

   procedure write;
   -- write  back to the HW interfaces

   package ACS is new component_iface  (current_component, COMIF.ACS.t_ACS_status,   COMIF.ACS.reset,  COMIF.ACS.read,  COMIF.ACS.write);
   package ACC is new component_iface  (current_component, COMIF.ACC.t_ACC_control,  COMIF.ACC.reset,  COMIF.ACC.read,  COMIF.ACC.write);
   package GCAS is new component_iface (current_component, COMIF.GCAS.t_GCAS_status, COMIF.GCAS.reset, COMIF.GCAS.read, COMIF.GCAS.write);
   package GPS is new component_iface  (current_component, COMIF.GPS.t_GPS_status,   COMIF.GPS.reset,  COMIF.GPS.read,  COMIF.GPS.write);
   package NAV is new component_iface  (current_component, COMIF.NAV.t_NAV_status,   COMIF.NAV.reset,  COMIF.NAV.read,  COMIF.NAV.write);
   package AFDS is new component_iface (current_component, COMIF.AFDS.t_AFDS_status, COMIF.AFDS.reset, COMIF.AFDS.read, COMIF.AFDS.write);

end AFDS.iface;
