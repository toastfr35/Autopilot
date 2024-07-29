/*-----------------------------------------------------
-- GPS.IFACE
--
-- Read/Write the HW interfaces for use by GPS
-----------------------------------------------------*/

#include "GPS_iface.hpp"
#include "GPS_iface_GPS.hpp"

namespace GPS {

void t_iface::read(void) {
  gps.read();
}

void t_iface::write(void) {
  gps.write();
}

void t_iface::reset(void) {
  gps.reset();
}

t_iface iface;

}
