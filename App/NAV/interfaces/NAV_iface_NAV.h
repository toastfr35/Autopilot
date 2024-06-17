/*-------------------------------------------------------
-- NAV.IFACE.NAV
--
-- This package provides
-- * read access to the NAV status for NAV
-- * write access to the NAV controls for NAV
-------------------------------------------------------*/

#include "waypoints.h"
#include <stdbool.h>
#include <stdint.h>

typedef struct {
  float heading;
  float altitude;
  float velocity;
} t_nav_target;

typedef struct {
  bool enabled;
  t_nav_target nav_target;
  float target_latitude;
  float target_longitude;
  uint32_t current_waypoint_index;
  t_waypoints waypoints;
} t_NAV_status;

extern t_NAV_status NAV_NAV_status;


void NAV_iface_NAV_read (void);

void NAV_iface_NAV_write (void);

void NAV_iface_NAV_reset (void);
