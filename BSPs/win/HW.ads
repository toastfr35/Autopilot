with Interfaces;

package HW is

   AFDS_status : array(1..256) of Interfaces.Unsigned_8;
   pragma Volatile (AFDS_status);

   CDU_status : array(1..256) of Interfaces.Unsigned_8;
   pragma Volatile (CDU_status);

   GCAS_status : array(1..256) of Interfaces.Unsigned_8;
   pragma Volatile (GCAS_status);

   aircraft_status : array(1..256) of Interfaces.Unsigned_8;
   pragma Volatile (aircraft_status);

   aircraft_control : array(1..256) of Interfaces.Unsigned_8;
   pragma Volatile (aircraft_control);

   NAV_status : array(1..2588) of Interfaces.Unsigned_8;
   pragma Volatile (NAV_status);

end HW;
