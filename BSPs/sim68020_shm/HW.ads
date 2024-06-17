with Interfaces;
with System;

package HW is

   AFDS_status : array(1..256) of Interfaces.Unsigned_8;
   for AFDS_status'Address use System'To_Address(16#800000# + (256 * 0));
   pragma Volatile (AFDS_status);

   CDU_status : array(1..256) of Interfaces.Unsigned_8;
   for CDU_status'Address use System'To_Address(16#800000# + (256 * 1));
   pragma Volatile (CDU_status);

   GCAS_status : array(1..256) of Interfaces.Unsigned_8;
   for GCAS_status'Address use System'To_Address(16#800000# + (256 * 2));
   pragma Volatile (GCAS_status);

   aircraft_status : array(1..256) of Interfaces.Unsigned_8;
   for aircraft_status'Address use System'To_Address(16#800000# + (256 * 3));
   pragma Volatile (aircraft_status);

   aircraft_control : array(1..256) of Interfaces.Unsigned_8;
   for aircraft_control'Address use System'To_Address(16#800000# + (256 * 4));
   pragma Volatile (aircraft_control);

   NAV_status : array(1..2076) of Interfaces.Unsigned_8;
   for NAV_status'Address use System'To_Address(16#800000# + (256 * 5));
   pragma Volatile (NAV_status);

end HW;
