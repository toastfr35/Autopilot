/*-------------------------------------------------------
-- NAV.IFACE.NAV
--
-- This package provides
-- * read access to the NAV status for NAV
-- * write access to the NAV controls for NAV
-------------------------------------------------------*/

#include <stdint.h>
#include <stdbool.h>
#include <string.h>

//-----------------------------------
// Fixpoint <-> float conversion
//-----------------------------------
static uint32_t float_to_fixpoint_6(float v) {return (uint32_t)(v * 1024.0 * 1024.0);}
static uint32_t float_to_fixpoint_3(float v) { return (uint32_t)(v * 1024.0); }
static float fixpoint_3_to_float(int32_t v) { return ((float)v) / 1024.0; }
static float fixpoint_6_to_float(int32_t v) { return ((float)v) / (1024.0 * 1024.0); }

typedef struct {
  uint32_t enabled;
  uint32_t heading;
  uint32_t altitude;
  uint32_t velocity;
} t_nav_data;

static t_nav_data nav_data;


bool  NAV_iface_NAV_get_enabled  (void) {return (bool)nav_data.enabled;}
float NAV_iface_NAV_get_heading  (void) {return fixpoint_6_to_float(nav_data.heading);}
float NAV_iface_NAV_get_altitude (void) {return fixpoint_3_to_float(nav_data.altitude);}
float NAV_iface_NAV_get_velocity (void) {return fixpoint_3_to_float(nav_data.velocity);}


void NAV_iface_NAV_set_enabled  (bool v)  {nav_data.enabled  = (uint32_t)v;}
void NAV_iface_NAV_set_heading  (float v) {nav_data.heading  = float_to_fixpoint_6(v);}
void NAV_iface_NAV_set_altitude (float v) {nav_data.altitude = float_to_fixpoint_3(v);}
void NAV_iface_NAV_set_velocity (float v) {nav_data.velocity = float_to_fixpoint_3(v);}


extern uint8_t IFACE_NAV_is_enabled(void);
extern uint32_t IFACE_NAV_get_heading(void);
extern uint32_t IFACE_NAV_get_altitude(void);
extern uint32_t IFACE_NAV_get_velocity(void);

void NAV_iface_NAV_read(void) {
  nav_data.enabled = IFACE_NAV_is_enabled();
  nav_data.heading = IFACE_NAV_get_heading();
  nav_data.altitude = IFACE_NAV_get_altitude();
  nav_data.velocity = IFACE_NAV_get_velocity();
}


extern void IFACE_NAV_set_enabled(uint8_t);
extern void IFACE_NAV_set_heading(uint32_t);
extern void IFACE_NAV_set_altitude(uint32_t);
extern void IFACE_NAV_set_velocity(uint32_t);

void NAV_iface_NAV_write(void) {
  IFACE_NAV_set_enabled(nav_data.enabled);
  IFACE_NAV_set_heading(nav_data.heading);
  IFACE_NAV_set_altitude(nav_data.altitude);
  IFACE_NAV_set_velocity(nav_data.enabled);
}


void NAV_iface_NAV_reset(void) {
    memset (&nav_data, 0, sizeof(t_nav_data));
}


