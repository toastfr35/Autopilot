#ifndef __IFACE_NAV_DEF_HPP__
#define __IFACE_NAV_DEF_HPP__

#include "types_conversion.hpp"

#ifdef __cplusplus
extern "C" {
#endif

#pragma pack(push, 4)
typedef struct {
  uint32_t heading;
  uint32_t altitude;
  uint32_t hspeed;
} t_COMIF_NAV_nav_target;  

typedef struct {
  uint64_t latitude;
  uint64_t longitude;
  uint32_t altitude;
  uint32_t hspeed;
  uint32_t ID;
  uint32_t padding;
} t_COMIF_NAV_waypoint;


typedef struct {
  uint32_t enabled;
  t_COMIF_NAV_nav_target nav_target;
  uint64_t target_latitude;
  uint64_t target_longitude;
  uint32_t current_waypoint_index;
  t_COMIF_NAV_waypoint waypoints[64];
} t_COMIF_NAV_status;

static t_COMIF_NAV_status COMIF_NAV_status;
#pragma pack(pop)

extern "C" {
extern t_COMIF_NAV_status COMIF_NAV_read (t_component);
extern void COMIF_NAV_write (t_component, t_COMIF_NAV_status *);
extern void COMIF_NAV_reset(void);
extern void COMIF_NAV_dump(void);
}

void t_iface_NAV::read(void)
{
  COMIF_NAV_status = COMIF_NAV_read(COMPONENT_FROM);
  status.enabled  = (bool)COMIF_NAV_status.enabled;
  status.nav_target.heading  = heading_to_float(COMIF_NAV_status.nav_target.heading);
  status.nav_target.altitude = altitude_to_float(COMIF_NAV_status.nav_target.altitude);
  status.nav_target.hspeed   = hspeed_to_float(COMIF_NAV_status.nav_target.hspeed);
  status.target_latitude     = latitude_to_double(COMIF_NAV_status.target_latitude);
  status.target_longitude    = longitude_to_double(COMIF_NAV_status.target_longitude);
  status.current_waypoint_index = COMIF_NAV_status.current_waypoint_index - 1; // C -> C indexing
  
  for (int i = 0; i < 64; i++) {
    status.waypoints[i].ID        = COMIF_NAV_status.waypoints[i].ID;
    status.waypoints[i].latitude  = latitude_to_double(COMIF_NAV_status.waypoints[i].latitude);
    status.waypoints[i].longitude = longitude_to_double(COMIF_NAV_status.waypoints[i].longitude);
    status.waypoints[i].altitude  = altitude_to_float(COMIF_NAV_status.waypoints[i].altitude);
    status.waypoints[i].hspeed    = hspeed_to_float(COMIF_NAV_status.waypoints[i].hspeed);
    if (status.waypoints[i].ID == 0) break;
  }
}

void t_iface_NAV::write (void) 
{
  COMIF_NAV_status.enabled  = status.enabled;
  COMIF_NAV_status.nav_target.heading  = float_to_heading(status.nav_target.heading);
  COMIF_NAV_status.nav_target.altitude = float_to_altitude(status.nav_target.altitude);
  COMIF_NAV_status.nav_target.hspeed   = float_to_hspeed(status.nav_target.hspeed);
  COMIF_NAV_status.target_latitude     = double_to_latitude(status.target_latitude);
  COMIF_NAV_status.target_longitude    = double_to_longitude(status.target_longitude);
  COMIF_NAV_status.current_waypoint_index  = status.current_waypoint_index + 1; // C -> Ada indexing
  for (int i = 0; i < 64; i++) {
    COMIF_NAV_status.waypoints[i].ID        = status.waypoints[i].ID;
    COMIF_NAV_status.waypoints[i].latitude  = double_to_latitude(status.waypoints[i].latitude);
    COMIF_NAV_status.waypoints[i].longitude = double_to_longitude(status.waypoints[i].longitude);
    COMIF_NAV_status.waypoints[i].altitude  = float_to_altitude(status.waypoints[i].altitude);
    COMIF_NAV_status.waypoints[i].hspeed    = float_to_hspeed(status.waypoints[i].hspeed);
    if (COMIF_NAV_status.waypoints[i].ID == 0) break;
  }
  COMIF_NAV_write(COMPONENT_FROM, &COMIF_NAV_status);
}

void t_iface_NAV::reset(void)
{
  COMIF_NAV_reset();
}

#ifdef __cplusplus
}
#endif
#endif
