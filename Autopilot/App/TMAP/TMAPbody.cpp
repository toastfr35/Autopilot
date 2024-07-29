/*-------------------------------------------------------
-- TMAP
--
-- Terrain Mapping
-------------------------------------------------------*/

#include "interfaces/TMAP_iface.hpp"
#include "impl/TMAP_impl.hpp"

extern "C" {
  void TMAP_step(void);
  void TMAP_reset (void);
}


void TMAP_step (void) {
  TMAP::iface.read();
  TMAP::impl.step();
  TMAP::iface.write();
}


void TMAP_reset (void) {
  TMAP::iface.reset();
  TMAP::impl.reset();
}

