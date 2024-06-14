#include "NAV_impl.h"
#include "calc_distance.h"
#include "calc_heading.h"
#include "NAV_iface_NAV.h"
#include "NAV_iface_aircraft.h"
#include "waypoints.h"
#include "math.h"

#include "stdio.h"

static float distance_threshold = 100.0;


//-----------------------------------
// Reset internal state
//-----------------------------------
void NAV_impl_reset() {
  clear_waypoints();
}


//-----------------------------------
// Get the current aircraft position as a waypoint
//-----------------------------------
t_waypoint get_current_position(void) {
  t_waypoint R;
  R.latitude  = NAV_iface_aircraft_get_latitude();
  R.longitude = NAV_iface_aircraft_get_longitude();
  R.altitude  = NAV_iface_aircraft_get_altitude();
  return R;
}


//-----------------------------------
// Update desired heading to next waypoint
//-----------------------------------
void NAV_impl_step() {
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
    NAV_iface_NAV_set_heading(heading);
    prev_heading = heading;
  }
  NAV_iface_NAV_set_altitude(to.altitude);
  NAV_iface_NAV_set_velocity(300.0);

  // close enough to the next waypoint?
  if (distance < distance_threshold) {
    move_to_next_waypoint(&success);
    if (!success) {
      // no more waypoints
      return;
    }
  }
}
