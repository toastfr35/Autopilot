#include "NAV_impl.h"
#include "calc_distance.h"
#include "calc_heading.h"
#include "NAV_iface_NAV.h"
#include "NAV_iface_aircraft.h"
#include "waypoints.h"
#include "math.h"

#include "stdio.h"

void log_NAV(char *);

static float distance_threshold = 100.0;

float NAV_heading;
float NAV_distance;

//-----------------------------------
// Reset internal state
//-----------------------------------
void NAV_impl_reset()
{
}


//-----------------------------------
// Get the current aircraft position as a waypoint
//-----------------------------------
static t_waypoint get_current_position(void)
{
  t_waypoint R;
  R.latitude  = NAV_aircraft_status.latitude;
  R.longitude = NAV_aircraft_status.longitude;
  R.altitude  = NAV_aircraft_status.altitude;
  return R;
}


//-----------------------------------
// Disable NAV
//-----------------------------------
static void disable_NAV(void)
{
  log_NAV("NAV: Disable NAV");
  NAV_NAV_status.enabled = 0;

  // keep the current heading, velocity and altitude
  NAV_NAV_status.nav_target.heading  = NAV_aircraft_status.heading;
  NAV_NAV_status.nav_target.velocity = NAV_aircraft_status.velocity;
  NAV_NAV_status.nav_target.altitude = NAV_aircraft_status.altitude;
  NAV_NAV_status.target_latitude = 0.0;
  NAV_NAV_status.target_longitude = 0.0;
}


//-----------------------------------
// Update desired heading to next waypoint
//-----------------------------------
void NAV_impl_step()
{
  // static uint32_t count = 0;
  // count++;

  static float prev_heading = 0.0;
  bool success;
  t_waypoint from = get_current_position();
  t_waypoint to = get_current_waypoint(&success);

  // only perform the step if NAV is enabled
  if (! NAV_NAV_status.enabled)
    return;

  if (!success) {
    // no more waypoints
    log_NAV ("NAV: No more waypoints");
    disable_NAV();
    return;
  }

  // calculate the distance and heading to the next waypoint
  NAV_distance = calculate_distance(from, to);
  NAV_heading = calculate_heading(from, to);

  /*
  if (0 == (count % 1000)) {
    printf("NAV : (%d, %f, %f) -> (%d, %f, %f) : %d %.1f\n",
           (int)from.altitude, from.latitude, from.longitude, (int)to.altitude,
           to.latitude, to.longitude, (int)NAV_distance, NAV_heading);
  }
  */

  // update the NAV interface
  if (fabs(NAV_heading-prev_heading) >= 0.5) {
    NAV_NAV_status.nav_target.heading = NAV_heading;
    prev_heading = NAV_heading;
  }
  NAV_NAV_status.target_latitude = to.latitude;
  NAV_NAV_status.target_longitude = to.longitude;
  NAV_NAV_status.nav_target.altitude = to.altitude;
  NAV_NAV_status.nav_target.velocity = to.velocity;

  // close enough to the next waypoint?
  if (NAV_distance < distance_threshold) {
    log_NAV("NAV: Close enough");
    move_to_next_waypoint(&success);
    if (!success) {
      // no more waypoints
      log_NAV("NAV: No more waypoints");
      disable_NAV();
      return;
    }
  }
}
