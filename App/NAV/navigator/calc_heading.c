#include "waypoints.h"
#include "math.h"

static float radians (float deg) {return deg * M_PI / 180.0;}

float calculate_heading(t_waypoint from, t_waypoint to)
{
  float Lat1 = radians(from.latitude);
  float Lon1 = radians(from.longitude);
  float Lat2 = radians(to.latitude);
  float Lon2 = radians(to.longitude);
  float D_Lon = Lon2 - Lon1;
  float X, Y, bearing;

  X = cosf(Lat2) * sinf(D_Lon);
  Y = cosf(Lat1) * sinf(Lat2) - sinf(Lat1) * cosf(Lat2) * cosf(D_Lon);
  bearing = atan2f(X, Y) * 180.0 / M_PI;

  // Normalize the bearing to 0-360 degrees
  if (bearing < 0.0) {
    bearing = bearing + 360.0;
  }

  return bearing;
}

