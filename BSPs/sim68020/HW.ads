with Interfaces;

package HW is

   AFDS_status : array(1..64) of Interfaces.Unsigned_32;
   pragma Volatile (AFDS_status);

   CDU_status : array(1..64) of Interfaces.Unsigned_32;
   pragma Volatile (CDU_status);

   GCAS_status : array(1..64) of Interfaces.Unsigned_32;
   pragma Volatile (GCAS_status);

   aircraft_status : array(1..64) of Interfaces.Unsigned_32;
   pragma Volatile (aircraft_status);

   aircraft_control : array(1..64) of Interfaces.Unsigned_32;
   pragma Volatile (aircraft_control);

   NAV_status : array(1..647) of Interfaces.Unsigned_32;
   pragma Volatile (NAV_status);
end HW;
