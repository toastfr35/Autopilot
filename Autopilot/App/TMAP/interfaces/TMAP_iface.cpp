/*-----------------------------------------------------
  -- TMAP.IFACE
  --
  -- Read/Write the HW interfaces for use by TMAP
  -----------------------------------------------------*/

#include "TMAP_iface.hpp"
#include "TMAP_iface_ACS.hpp"
#include "TMAP_iface_GPS.hpp"
#include "TMAP_iface_TMAP.hpp"

namespace TMAP {

  void t_iface::read(void) {
    acs.read();
    gps.read();
    tmap.read();
  }

  void t_iface::write(void) {
    tmap.write();
  }

  void t_iface::reset(void) {
    acs.reset();
    gps.reset();
    tmap.reset();
  }

  t_iface iface;

}
