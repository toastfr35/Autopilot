#include "NAV_iface_NAV.h"
#include "waypoints.h"
#include "stdio.h"

//-----------------------------------
// Get the currently active waypoint index
//-----------------------------------
uint32_t get_current_waypoint_index(bool *success)
{
  if (NAV_NAV_status.current_waypoint_index == -1) {
    *success = false;
    return -1;
  }
  *success = true;
  return NAV_NAV_status.current_waypoint_index;
}


//-----------------------------------
// Get the currently active waypoint
//-----------------------------------
t_waypoint get_current_waypoint (bool * success) {
  t_waypoint R = {0, 0.0, 0.0, 0.0, 0.0};

  uint32_t index = get_current_waypoint_index(success);
  if (! *success) return R;

  R.ID        = NAV_NAV_status.waypoints[index].ID;
  R.latitude  = NAV_NAV_status.waypoints[index].latitude;
  R.longitude = NAV_NAV_status.waypoints[index].longitude;
  R.altitude  = NAV_NAV_status.waypoints[index].altitude;
  R.velocity  = NAV_NAV_status.waypoints[index].velocity;
  *success = true;

  return R;
}


//-----------------------------------
// Make the next waypoint in the list active
// Return 0 if the end of the list was reached
//-----------------------------------
void move_to_next_waypoint(bool *success) {
  if (NAV_NAV_status.current_waypoint_index != -1) {
    NAV_NAV_status.current_waypoint_index++;
    if (NAV_NAV_status.current_waypoint_index == 128) {
      // end of array reached
      NAV_NAV_status.current_waypoint_index = -1;
      *success = false;
    } else if (NAV_NAV_status.waypoints[NAV_NAV_status.current_waypoint_index].ID == 0) {
      // end marker reached
      NAV_NAV_status.current_waypoint_index = -1;
      *success = false;
    } else {
      *success = true;
    }
  } else {
    *success = false;
  }
}

