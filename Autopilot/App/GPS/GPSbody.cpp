/*-------------------------------------------------------
-- NAV
--
-- Waypoints navigation
-------------------------------------------------------*/

#include "interfaces/GPS_iface.hpp"
#include "impl/GPS_impl.hpp"
#include "stdio.h"

extern "C" {
  void GPS_step(void);
  void GPS_reset (void);
}


void GPS_step (void) {
  GPS::iface.read();
  GPS::impl.step();
  GPS::iface.write();
}


void GPS_reset (void) {
  GPS::iface.reset();
  GPS::impl.reset();
}

