/*-------------------------------------------------------
-- TMAP.IFACE.GPS
--
-- This package provides
-- * read access to the GPS status for TMAP
-------------------------------------------------------*/

#include <cstdlib>
#include <string.h>
#include <stdint.h>
#include "TMAP_iface_GPS.hpp"
#include "components.h"

namespace TMAP {
#define COMPONENT_FROM Comp_TMAP
#include "../../COMIF/CPP/iface_GPS_def.hpp"
}
