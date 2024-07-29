/*-------------------------------------------------------
-- TMAP.IFACE.ACS
--
-- This package provides
-- * read access to the ACS status for TMAP
-------------------------------------------------------*/

#include <cstdlib>
#include <string.h>
#include <stdint.h>
#include "TMAP_iface_ACS.hpp"
#include "components.h"

namespace TMAP {
#define COMPONENT_FROM Comp_TMAP
#include "../../COMIF/CPP/iface_ACS_def.hpp"
}
