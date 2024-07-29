-------------------------------------------------------
-- Package HW
--
-------------------------------------------------------

with Interfaces;

package HW is

   AFDS_status : array(1..5) of Interfaces.Unsigned_32;
   pragma Volatile (AFDS_status);

   CDU_status : array(1..17) of Interfaces.Unsigned_32;
   pragma Volatile (CDU_status);

   GCAS_status : array(1..2) of Interfaces.Unsigned_32;
   pragma Volatile (GCAS_status);

   aircraft_status : array(1..9) of Interfaces.Unsigned_32;
   pragma Volatile (aircraft_status);

   aircraft_control : array(1..8) of Interfaces.Unsigned_32;
   pragma Volatile (aircraft_control);

   NAV_status : array(1..522) of Interfaces.Unsigned_32;
   pragma Volatile (NAV_status);

   GPS_status : array(1..8) of Interfaces.Unsigned_32;
   pragma Volatile (GPS_status);

   TMAP_status : array(1..432) of Interfaces.Unsigned_32;
   pragma Volatile (TMAP_status);

end HW;
