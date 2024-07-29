#include "waypoints.hpp"

extern "C" {
extern double fabs (double);
}
#define M_PI 3.14159265358979323846

#ifdef __cplusplus
extern "C" {
#endif

namespace NAV {

const float Earth_Radius = 6371000.0;

float calculate_distance(t_waypoint *from, t_waypoint *to) {
  float Lat1 = radians(from->latitude);
  float Lon1 = radians(from->longitude);
  float Lat2 = radians(to->latitude);
  float Lon2 = radians(to->longitude);

  // Manhattan distance formula
  float dist_rad = fabs(Lat2-Lat1) + fabs(Lon2-Lon1);
  float dist_meter = dist_rad * Earth_Radius;

  return dist_meter;
}

#ifdef __cplusplus
}
#endif

}
