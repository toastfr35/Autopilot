/*-------------------------------------------------------
-- NAV.IFACE.NAV
--
-- This package provides
-- * read access to the NAV status for NAV
-- * write access to the NAV controls for NAV
-------------------------------------------------------*/
#ifndef _NAV_IFACE_NAV_HPP_
#define _NAV_IFACE_NAV_HPP_

#include "interface.hpp"
#include "../navigator/waypoints.hpp"
#include <stdbool.h>
#include <stdint.h>

namespace NAV {
#include "../../COMIF/CPP/iface_NAV_decl.hpp"
}

#endif
