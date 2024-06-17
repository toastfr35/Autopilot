/*-------------------------------------------------------
-- NAV.IFACE.NAV
--
-- This package provides
-- * read access to the NAV status for NAV
-- * write access to the NAV controls for NAV
-------------------------------------------------------*/

#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include "NAV_iface_NAV.h"
#include "components.h"

void log_NAV(char *);


//-----------------------------------
// Fixpoint <-> float conversion
//-----------------------------------
static uint32_t float_to_fixpoint_6(float v) {return (uint32_t)(v * 1024.0 * 1024.0);}
static uint32_t float_to_fixpoint_3(float v) { return (uint32_t)(v * 1024.0); }
static float fixpoint_3_to_float(int32_t v) { return ((float)v) / 1024.0; }
static float fixpoint_6_to_float(int32_t v) { return ((float)v) / (1024.0 * 1024.0); }

typedef struct {
  uint32_t heading;
  uint32_t altitude;
  uint32_t velocity;
} t_COMIF_NAV_nav_target;  

typedef struct {
  uint32_t ID;
  uint32_t latitude;
  uint32_t longitude;
  uint32_t altitude;
  uint32_t velocity;
} t_COMIF_NAV_waypoint;  
      
typedef struct {
  uint32_t enabled;
  t_COMIF_NAV_nav_target nav_target;
  uint32_t target_latitude;
  uint32_t target_longitude;
  uint32_t current_waypoint_index;  
  t_COMIF_NAV_waypoint waypoints[128];
} t_COMIF_NAV_status;

static t_COMIF_NAV_status COMIF_NAV_status;
t_NAV_status NAV_NAV_status;

extern t_COMIF_NAV_status COMIF_NAV_read_status (t_component);
extern void COMIF_NAV_write_status (t_component, t_COMIF_NAV_status *);
extern void COMIF_NAV_reset(void);
extern void COMIF_NAV_dump(void);

void NAV_iface_NAV_read(void)
{
  COMIF_NAV_status = COMIF_NAV_read_status(Comp_NAV);
  NAV_NAV_status.enabled  = (bool)COMIF_NAV_status.enabled;
  NAV_NAV_status.nav_target.heading   = fixpoint_6_to_float(COMIF_NAV_status.nav_target.heading);
  NAV_NAV_status.nav_target.altitude  = fixpoint_3_to_float(COMIF_NAV_status.nav_target.altitude);
  NAV_NAV_status.nav_target.velocity  = fixpoint_3_to_float(COMIF_NAV_status.nav_target.velocity);
  NAV_NAV_status.target_latitude  = fixpoint_6_to_float(COMIF_NAV_status.target_latitude);
  NAV_NAV_status.target_longitude = fixpoint_6_to_float(COMIF_NAV_status.target_longitude);
  NAV_NAV_status.current_waypoint_index = COMIF_NAV_status.current_waypoint_index - 1; // C -> C indexing
  
  for (int i = 0; i < 128; i++) {
    NAV_NAV_status.waypoints[i].ID        = COMIF_NAV_status.waypoints[i].ID;
    NAV_NAV_status.waypoints[i].latitude  = fixpoint_6_to_float(COMIF_NAV_status.waypoints[i].latitude);
    NAV_NAV_status.waypoints[i].longitude = fixpoint_6_to_float(COMIF_NAV_status.waypoints[i].longitude);
    NAV_NAV_status.waypoints[i].altitude  =  fixpoint_3_to_float(COMIF_NAV_status.waypoints[i].altitude);
    NAV_NAV_status.waypoints[i].velocity  =  fixpoint_3_to_float(COMIF_NAV_status.waypoints[i].velocity);
    if (NAV_NAV_status.waypoints[i].ID == 0) break;
  }
}

void NAV_iface_NAV_write (void) 
{
  COMIF_NAV_status.enabled  = NAV_NAV_status.enabled;
  COMIF_NAV_status.nav_target.heading   = float_to_fixpoint_6(NAV_NAV_status.nav_target.heading);
  COMIF_NAV_status.nav_target.altitude  = float_to_fixpoint_3(NAV_NAV_status.nav_target.altitude);
  COMIF_NAV_status.nav_target.velocity  = float_to_fixpoint_3(NAV_NAV_status.nav_target.velocity);
  COMIF_NAV_status.target_latitude  = float_to_fixpoint_6 (NAV_NAV_status.target_latitude);
  COMIF_NAV_status.target_longitude = float_to_fixpoint_6 (NAV_NAV_status.target_longitude);
  COMIF_NAV_status.current_waypoint_index  = NAV_NAV_status.current_waypoint_index + 1; // C -> Ada indexing
  for (int i = 0; i < 128; i++) {
    COMIF_NAV_status.waypoints[i].ID        = NAV_NAV_status.waypoints[i].ID;
    COMIF_NAV_status.waypoints[i].latitude  = float_to_fixpoint_6(NAV_NAV_status.waypoints[i].latitude);
    COMIF_NAV_status.waypoints[i].longitude = float_to_fixpoint_6(NAV_NAV_status.waypoints[i].longitude);
    COMIF_NAV_status.waypoints[i].altitude  = float_to_fixpoint_3(NAV_NAV_status.waypoints[i].altitude);
    COMIF_NAV_status.waypoints[i].velocity  = float_to_fixpoint_3(NAV_NAV_status.waypoints[i].velocity);
    if (COMIF_NAV_status.waypoints[i].ID == 0) break;
  }
  COMIF_NAV_write_status(Comp_NAV, &COMIF_NAV_status);
}

void NAV_iface_NAV_reset(void)
{
  COMIF_NAV_reset();
  NAV_iface_NAV_read();
}
