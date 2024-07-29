#ifndef __CALC_HEADING_HPP__
#define __CALC_HEADING_HPP__

#include "waypoints.hpp"

#ifdef __cplusplus
extern "C" {
#endif

namespace NAV {
float calculate_heading (t_waypoint *from, t_waypoint *to);
}

#ifdef __cplusplus
}
#endif

#endif