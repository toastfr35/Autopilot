/*-------------------------------------------------------
-- NAV.IFACE.aircraft
--
-- This package provides
-- * read access to the aircraft status for NAV
-------------------------------------------------------*/

#include <string.h>
#include <stdint.h>

//-----------------------------------
// Fixpoint <-> float conversion
//-----------------------------------
static float fixpoint_3_to_float(int32_t v) { return ((float)v) / 1024.0; }
static float fixpoint_6_to_float(int32_t v) { return ((float)v) / (1024.0 * 1024.0); }

typedef struct {
  uint32_t aileron;
  uint32_t elevator;
  uint32_t rudder;
  uint32_t throttle1;
  uint32_t throttle2;

  uint32_t latitude;
  uint32_t longitude;
  uint32_t altitude;

  uint32_t heading;
  uint32_t velocity;
  uint32_t vertspeed;

  uint32_t roll;
  uint32_t pitch;
} t_aircraft_data;

static t_aircraft_data aircraft_data;

float NAV_iface_aircraft_get_aileron   (void) {return fixpoint_3_to_float (aircraft_data.aileron);}
float NAV_iface_aircraft_get_elevator  (void) {return fixpoint_3_to_float (aircraft_data.elevator);}
float NAV_iface_aircraft_get_rudder    (void) {return fixpoint_3_to_float (aircraft_data.rudder);}
float NAV_iface_aircraft_get_throttle1 (void) {return fixpoint_3_to_float (aircraft_data.throttle1);}
float NAV_iface_aircraft_get_throttle2 (void) {return fixpoint_3_to_float (aircraft_data.throttle2);}
float NAV_iface_aircraft_get_latitude  (void) {return fixpoint_6_to_float (aircraft_data.latitude);}
float NAV_iface_aircraft_get_longitude (void) {return fixpoint_6_to_float (aircraft_data.longitude);}
float NAV_iface_aircraft_get_altitude  (void) {return fixpoint_3_to_float (aircraft_data.altitude);}
float NAV_iface_aircraft_get_heading   (void) {return fixpoint_6_to_float (aircraft_data.heading);}
float NAV_iface_aircraft_get_velocity  (void) {return fixpoint_3_to_float (aircraft_data.velocity);}
float NAV_iface_aircraft_get_roll      (void) {return fixpoint_6_to_float (aircraft_data.roll);}
float NAV_iface_aircraft_get_pitch     (void) {return fixpoint_6_to_float (aircraft_data.pitch);}
float NAV_iface_aircraft_get_vertspeed (void) {return fixpoint_3_to_float (aircraft_data.vertspeed);}


extern t_aircraft_data IFACE_aircraft_status (void);
void NAV_iface_aircraft_read (void)
{
  aircraft_data = IFACE_aircraft_status();
}


void NAV_iface_aircraft_reset (void)
{
  memset (&aircraft_data, 0, sizeof(t_aircraft_data));
}

