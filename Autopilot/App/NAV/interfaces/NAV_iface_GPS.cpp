/*-------------------------------------------------------
-- NAV.IFACE.GPS
--
-- This package provides
-- * read access to the GPS status for NAV
-------------------------------------------------------*/

#include <cstdlib>
#include <string.h>
#include <stdint.h>
#include "NAV_iface_GPS.hpp"
#include "components.h"

namespace NAV {
#define COMPONENT_FROM Comp_NAV
#include "../../COMIF/CPP/iface_GPS_def.hpp"
}
