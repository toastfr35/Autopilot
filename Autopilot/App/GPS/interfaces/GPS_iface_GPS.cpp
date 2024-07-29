/*-------------------------------------------------------
-- GPS.IFACE.GPS
--
-- This package provides
-- * read access to the GPS status for GPS
-------------------------------------------------------*/

#include <cstdlib>
#include <string.h>
#include <stdint.h>
#include "GPS_iface_GPS.hpp"
#include "components.h"

namespace GPS {
#define COMPONENT_FROM Comp_GPS
#include "../../COMIF/CPP/iface_GPS_def.hpp"
}
