#ifndef __WAYPOINTS__
#define __WAYPOINTS__

#include <stdint.h>
#include <stdbool.h>

// A waypoint
typedef struct {
  uint32_t ID;
  float latitude;
  float longitude;
  float altitude;
  float velocity;
} t_waypoint;

typedef t_waypoint t_waypoints[128];


// Get the currently active waypoint index
uint32_t get_current_waypoint_index (bool * success);


// Get the currently active waypoint
t_waypoint get_current_waypoint (bool * success);


// Make the next waypoint in the list active
// Return 0 if the end of the list was reached
void move_to_next_waypoint (bool * success);



#endif
