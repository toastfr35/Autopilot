#include "waypoints.h"
#include <math.h>

const float Earth_Radius = 6371000.0;

static float radians (float deg) {return deg * M_PI / 180.0;}



float calculate_distance(t_waypoint from, t_waypoint to) {
  float Lat1 = radians(from.latitude);
  float Lon1 = radians(from.longitude);
  float Lat2 = radians(to.latitude);
  float Lon2 = radians(to.longitude);

  // Manhattan distance formula
  float dist_rad = fabs(Lat2-Lat1) + fabs(Lon2-Lon1);
  float dist_meter = dist_rad * Earth_Radius;

  return dist_meter;
}


