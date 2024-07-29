#ifndef __WAYPOINTS_HPP__
#define __WAYPOINTS_HPP__

#include <stdint.h>
#include <stdbool.h>
#include <math.h>

#ifdef __cplusplus
extern "C" {
#endif
namespace NAV {

// A waypoint
typedef struct {
  uint32_t ID;
  double latitude;
  double longitude;
  float altitude;
  float hspeed;
} t_waypoint;

typedef t_waypoint t_waypoints[128];

// Get the currently active waypoint index

uint32_t get_current_waypoint_index (bool * success);


// Get the currently active waypoint
t_waypoint get_current_waypoint (bool * success);


// Make the next waypoint in the list active
// Return 0 if the end of the list was reached
void move_to_next_waypoint (bool * success);

float radians (float deg);


}

#ifdef __cplusplus
}
#endif
#endif
