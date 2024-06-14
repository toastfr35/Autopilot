/*-----------------------------------------------------
-- NAV.IFACE
--
-- Read/Write the HW interfaces for use by NAV
-----------------------------------------------------*/

#include "NAV_iface_NAV.h"
#include "NAV_iface_aircraft.h"

void NAV_iface_read(void) {
  NAV_iface_aircraft_read();
  NAV_iface_NAV_read();
}

void NAV_iface_write(void) {
  NAV_iface_NAV_write();
}

void NAV_iface_reset(void) {
  NAV_iface_aircraft_reset();
  NAV_iface_NAV_reset();
}
