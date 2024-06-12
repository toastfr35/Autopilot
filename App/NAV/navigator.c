#include "navigator.h"
#include "calc_distance.h"
#include "calc_heading.h"
#include "nav_interface.h"
#include "waypoints.h"
#include "math.h"

#include "stdio.h"

float distance_threshold = 100.0;


//-----------------------------------
// Fixpoint <-> float conversion
//-----------------------------------
uint32_t float_to_fixpoint_6(float v) {
  return (uint32_t)(v * 1024.0 * 1024.0);
}
uint32_t float_to_fixpoint_3(float v) { return (uint32_t)(v * 1024.0); }
float fixpoint_3_to_float(int32_t v) { return ((float)v) / 1024.0; }
float fixpoint_6_to_float(int32_t v) { return ((float)v) / (1024.0 * 1024.0); }


//-----------------------------------
// Get the current aircraft position as a waypoint
//-----------------------------------
t_waypoint get_current_position(void) {
  t_waypoint R;
  R.latitude = fixpoint_6_to_float(aircraft_interface_data_ptr->latitude);
  R.longitude = fixpoint_6_to_float(aircraft_interface_data_ptr->longitude);
  R.altitude = fixpoint_3_to_float(aircraft_interface_data_ptr->altitude);
  return R;
}


//-----------------------------------
// Reset internal state
//-----------------------------------
void NAV_reset() {
  clear_waypoints();
}


//-----------------------------------
// Update desired heading to next waypoint
//-----------------------------------
void NAV_step() {
  // static uint32_t count = 0;
  // count++;
  static float prev_heading = 0.0;
  bool success;
  t_waypoint from = get_current_position();
  t_waypoint to = get_current_waypoint(&success);

  if (!success) {
    // no more waypoints
    return;
  }

  // calculate the distance and heading to the next waypoint
  float distance = calculate_distance(from, to);
  float heading = calculate_heading(from, to);

  /*if (0 == (count % 1000)) {
    printf("NAV %f (%d, %f, %f) -> (%d, %f, %f) : %d %.1f\n",
           fixpoint_6_to_float(aircraft_interface_data.heading),
           (int)from.altitude, from.latitude, from.longitude, (int)to.altitude,
           to.latitude, to.longitude, (int)distance, heading);
  }*/

  // update the NAV interface
  if (fabs(heading-prev_heading) >= 0.5) {
    nav_interface_data_ptr->heading = float_to_fixpoint_6(heading);
    prev_heading = heading;
  }
  nav_interface_data_ptr->altitude = float_to_fixpoint_3(to.altitude);
  nav_interface_data_ptr->velocity = float_to_fixpoint_3(300.0);

  // close enough to the next waypoint?
  if (distance < distance_threshold) {
    move_to_next_waypoint(&success);
    if (!success) {
      // no more waypoints
      return;
    }
  }
}
