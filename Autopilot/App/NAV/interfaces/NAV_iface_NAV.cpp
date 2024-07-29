/*-------------------------------------------------------
-- NAV.IFACE.NAV
--
-- This package provides
-- * read access to the NAV status for NAV
-- * write access to the NAV controls for NAV
-------------------------------------------------------*/

#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include "NAV_iface_NAV.hpp"
#include "components.h"

namespace NAV {
#define COMPONENT_FROM Comp_NAV
#include "../../COMIF/CPP/iface_NAV_def.hpp"
}
