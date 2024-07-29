#include "NAV_impl.hpp"
#include "calc_distance.hpp"
#include "calc_heading.hpp"
#include "../interfaces/NAV_iface.hpp"
#include "waypoints.hpp"
#include <stdio.h>

extern "C" {
extern double fabs (double);
}
#define M_PI 3.14159265358979323846

float NAV_heading;
float NAV_distance;

namespace NAV {

static float distance_threshold = 200.0;

//-----------------------------------
// Reset internal state
//-----------------------------------
void impl_reset()
{
}


//-----------------------------------
// Get the current aircraft position as a waypoint
//-----------------------------------
t_waypoint get_current_position(void)
{
  t_waypoint R;
  R.latitude  = iface.gps.status.latitude;
  R.longitude = iface.gps.status.longitude;
  R.altitude  = iface.gps.status.altitude;
  return R;
}


//-----------------------------------
// Disable NAV
//-----------------------------------
void disable_NAV(void)
{
  iface.nav.status.enabled = 0;

  // keep the current heading, hspeed and altitude
  iface.nav.status.nav_target.heading  = iface.acs.status.heading;
  iface.nav.status.nav_target.hspeed   = iface.gps.status.hspeed;
  iface.nav.status.nav_target.altitude = iface.gps.status.altitude;
  iface.nav.status.target_latitude = 0.0;
  iface.nav.status.target_longitude = 0.0;
}


//-----------------------------------
// Update desired heading to next waypoint
//-----------------------------------
void impl_step()
{
  // static uint32_t count = 0;
  // count++;

  static float prev_heading = 0.0;
  bool success;
  t_waypoint from = get_current_position();
  t_waypoint to = get_current_waypoint(&success);

  // only perform the step if NAV is enabled
  if (! iface.nav.status.enabled) {
    return;
  }

  if (!success) {
    // no more waypoints
    disable_NAV();
    return;
  }

  // calculate the distance and heading to the next waypoint

  NAV_distance = calculate_distance(&from, &to);
  NAV_heading = calculate_heading(&from, &to);

  
  //if (0 == (count % 1000)) 
  //{
  //  printf("NAV : (%d, %f, %f) -> (%d, %f, %f) : %d %.1f\n",
  //         (int)from.altitude, from.latitude, from.longitude, (int)to.altitude,
  //         to.latitude, to.longitude, (int)NAV_distance, NAV_heading);
  //}
  

  // update the NAV interface
  if (fabs(NAV_heading-prev_heading) >= 0.5) {
    iface.nav.status.nav_target.heading = NAV_heading;
    prev_heading = NAV_heading;
  }
  iface.nav.status.target_latitude     = to.latitude;
  iface.nav.status.target_longitude    = to.longitude;
  iface.nav.status.nav_target.altitude = to.altitude;
  iface.nav.status.nav_target.hspeed   = to.hspeed;

  // close enough to the next waypoint?
  if (NAV_distance < distance_threshold) {
    move_to_next_waypoint(&success);
    if (!success) {
      // no more waypoints
      disable_NAV();
      return;
    }
  }
}

}
