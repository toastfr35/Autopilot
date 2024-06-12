#include "waypoints.h"


// The list of waypoint
t_waypoint waypoint_list[256];
uint32_t nb_waypoints;
uint32_t current_waypoint = 0;


//-----------------------------------
//
//-----------------------------------
void clear_waypoints(void) {
  nb_waypoints = 0;
}


//-----------------------------------
//
//-----------------------------------
void add_waypoint(float latitude, float longitude, float altitude) {
  waypoint_list[nb_waypoints].latitude = latitude;
  waypoint_list[nb_waypoints].longitude = longitude;
  waypoint_list[nb_waypoints].altitude = altitude;
  nb_waypoints++;
}


//-----------------------------------
// Get the currently active waypoint index
//-----------------------------------
uint32_t get_current_waypoint_index(bool *success) {
  if (current_waypoint >= nb_waypoints) {
    *success = false;
    return -1;
  }
  *success = true;
  return current_waypoint;
}


//-----------------------------------
// Get the currently active waypoint
//-----------------------------------
t_waypoint get_current_waypoint (bool * success) {
  t_waypoint R = {0.0,0.0,0.0};

  if (current_waypoint >= nb_waypoints) {
    *success = false;
    return R;
  }

  R.latitude  = waypoint_list[current_waypoint].latitude;
  R.longitude = waypoint_list[current_waypoint].longitude;
  R.altitude  = waypoint_list[current_waypoint].altitude;
  *success = true;

  return R;
}


//-----------------------------------
// Make the next waypoint in the list active
// Return 0 if the end of the list was reached
//-----------------------------------
void move_to_next_waypoint(bool *success) {
  if (current_waypoint < nb_waypoints) {
    current_waypoint++;
    *success = true;
  } else {
    *success = false;
  }
}

