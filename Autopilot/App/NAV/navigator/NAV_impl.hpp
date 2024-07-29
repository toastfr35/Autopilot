#ifndef __NAV_IMPL_HPP__
#define __NAV_IMPL_HPP__

#include "waypoints.hpp"

#ifdef __cplusplus
extern "C" {
#endif
namespace NAV {

// Get the current position
t_waypoint get_current_position(void);


// Reset internal state
void impl_reset();

// Update desired heading to next waypoint
void impl_step();

}

#ifdef __cplusplus
}
#endif

#endif