/*-----------------------------------------------------
-- NAV.IFACE
--
-- Read/Write the HW interfaces for use by NAV
-----------------------------------------------------*/

#include "NAV_iface.hpp"
#include "NAV_iface_NAV.hpp"
#include "NAV_iface_ACS.hpp"

namespace NAV {

void t_iface::read(void) {
  acs.read();
  gps.read();
  nav.read();
}

void t_iface::write(void) {
  nav.write();
}

void t_iface::reset(void) {
  acs.reset();
  gps.reset();
  nav.reset();
}

t_iface iface;

}
