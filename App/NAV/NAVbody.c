/*-------------------------------------------------------
-- NAV
--
-- Waypoints navigation
-------------------------------------------------------*/

#include "NAV_iface.h"
#include "NAV_impl.h"


void NAV_step (void) {
  NAV_iface_read();
  NAV_impl_step();
  NAV_iface_write();
}


void NAV_reset (void) {
  NAV_iface_reset();
  NAV_impl_reset();
}
