/*-------------------------------------------------------
-- TMAP.IFACE.TMAP
--
-- This package provides
-- * read access to the TMAP status for TMAP
-- * write access to the TMAP status for TMAP
-------------------------------------------------------*/

#include <cstdlib>
#include <string.h>
#include <stdint.h>
#include "TMAP_iface_TMAP.hpp"
#include "components.h"

namespace TMAP {
#define COMPONENT_FROM Comp_TMAP
#include "../../COMIF/CPP/iface_TMAP_def.hpp"
}
