-------------------------------------------------------
-- Package COMIF.GPS
--
-- This package provides R/W access to the GPS status
-------------------------------------------------------

with types; use types;
with components; use components;

package COMIF.GPS is

   -------------------------------
   -- Data types
   -------------------------------
   type t_GPS_status is record
      latitude  : t_latitude;
      longitude : t_longitude;
      altitude  : t_altitude;
      hspeed    : t_hspeed;
      vspeed    : t_vspeed;
   end record;
   for t_GPS_status'Size use 256;
   for t_GPS_status use record
      latitude  at 0 range 0 .. 63;
      longitude at 8 range 0 .. 63;
      altitude  at 16 range 0 .. 31;
      hspeed    at 20 range 0 .. 31;
      vspeed    at 24 range 0 .. 31;
   end record;

   -------------------------------
   -- R/W access to data
   -------------------------------

   procedure reset;
   pragma Export (C, reset, "COMIF_GPS_reset");

   function read (component : t_component) return t_GPS_status;
   pragma Export (C, read, "COMIF_GPS_read");

   procedure write (component : t_component; status : t_GPS_status);
   pragma Export (C, write, "COMIF_GPS_write");

end COMIF.GPS;
