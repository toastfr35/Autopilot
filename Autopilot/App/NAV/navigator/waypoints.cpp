#include "../interfaces/NAV_iface.hpp"
#include "waypoints.hpp"
#include <stdio.h>

namespace NAV {

//-----------------------------------
// Get the currently active waypoint index
//-----------------------------------
uint32_t get_current_waypoint_index(bool *success)
{
  if (iface.nav.status.current_waypoint_index == (uint32_t)-1) {
    *success = false;
    return -1;
  }
  *success = true;
  return iface.nav.status.current_waypoint_index;
}


//-----------------------------------
// Get the currently active waypoint
//-----------------------------------
t_waypoint get_current_waypoint (bool * success) {
  t_waypoint R = {0, 0.0, 0.0, 0.0, 0.0};

  uint32_t index = get_current_waypoint_index(success);
  if (*success)
  {
    R.ID        = iface.nav.status.waypoints[index].ID;
    R.latitude  = iface.nav.status.waypoints[index].latitude;
    R.longitude = iface.nav.status.waypoints[index].longitude;
    R.altitude  = iface.nav.status.waypoints[index].altitude;
    R.hspeed    = iface.nav.status.waypoints[index].hspeed;
    *success = true;
  }

  return R;
}

void testxxx();

//-----------------------------------
// Make the next waypoint in the list active
// Return 0 if the end of the list was reached
//-----------------------------------
void move_to_next_waypoint(bool *success) {
  if (iface.nav.status.current_waypoint_index != (uint32_t)-1) {
    iface.nav.status.current_waypoint_index++;
    if (iface.nav.status.current_waypoint_index == 64) {
      // end of array reached
      iface.nav.status.current_waypoint_index = -1;
      *success = false;
    } else if (iface.nav.status.waypoints[iface.nav.status.current_waypoint_index].ID == 0) {
      // end marker reached
      iface.nav.status.current_waypoint_index = -1;
      *success = false;
    } else {
      *success = true;
    }
  } else {
    *success = false;
  }
}

float radians (float deg) {return deg * M_PI / 180.0;}

}
