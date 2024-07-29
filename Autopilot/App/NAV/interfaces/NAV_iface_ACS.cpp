/*-------------------------------------------------------
-- NAV.IFACE.ACS
--
-- This package provides
-- * read access to the aircraft status for NAV
-------------------------------------------------------*/

#include <cstdlib>
#include <string.h>
#include <stdint.h>
#include "NAV_iface_ACS.hpp"
#include "components.h"

namespace NAV {
#define COMPONENT_FROM Comp_NAV
#include "../../COMIF/CPP/iface_ACS_def.hpp"
}
