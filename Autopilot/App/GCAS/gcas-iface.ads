-------------------------------------------------------
-- Package GCAS.IFACE
--
-- Read/Write the HW interfaces for use by GCAS
-------------------------------------------------------

with COMIF.ACS;
with COMIF.GCAS;
with COMIF.GPS;
with COMIF.TMAP;

with component_iface;
with components;

package GCAS.iface is

   current_component : constant components.t_component := components.Comp_GCAS;

   procedure reset;
   -- reset the GCAS views of the HW interfaces

   procedure read;
   -- update the GCAS views of the HW interfaces

   procedure write;
   -- write  back to the HW interfaces

   package ACS is new component_iface  (current_component, COMIF.ACS.t_ACS_status,   COMIF.ACS.reset,  COMIF.ACS.read,  COMIF.ACS.write);
   package GCAS is new component_iface (current_component, COMIF.GCAS.t_GCAS_status, COMIF.GCAS.reset, COMIF.GCAS.read, COMIF.GCAS.write);
   package GPS is new component_iface  (current_component, COMIF.GPS.t_GPS_status,   COMIF.GPS.reset,  COMIF.GPS.read,  COMIF.GPS.write);
   package TMAP is new component_iface (current_component, COMIF.TMAP.t_TMAP_status, COMIF.TMAP.reset, COMIF.TMAP.read, COMIF.TMAP.write);

end GCAS.iface;
