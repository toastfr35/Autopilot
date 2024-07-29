/*-------------------------------------------------------
-- NAV
--
-- Waypoints navigation
-------------------------------------------------------*/

#include "interfaces/NAV_iface.hpp"
#include "navigator/NAV_impl.hpp"
#include "stdio.h"

#ifdef __cplusplus
extern "C" {
#endif

  void NAV_step(void);
  void NAV_reset (void);

#ifdef __cplusplus
}
#endif



void NAV_step (void) {
  NAV::iface.read();
  NAV::impl_step();
  NAV::iface.write();
}


void NAV_reset (void) {
  NAV::iface.reset();
  NAV::impl_reset();
}
