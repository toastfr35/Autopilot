/*-------------------------------------------------------
-- NAV.IFACE.aircraft
--
-- This package provides
-- * read access to the aircraft status for NAV
-------------------------------------------------------*/

#include <string.h>
#include <stdint.h>
#include "NAV_iface_aircraft.h"
#include "components.h"

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
} t_COMIF_aircraft_status;

static t_COMIF_aircraft_status COMIF_aircraft_status;
t_aircraft_status NAV_aircraft_status;

extern t_COMIF_aircraft_status COMIF_aircraft_read_status (t_component);
extern void COMIF_aircraft_reset(void);

void NAV_iface_aircraft_read (void)
{
  COMIF_aircraft_status = COMIF_aircraft_read_status(Comp_NAV);
  NAV_aircraft_status.aileron   = fixpoint_3_to_float (COMIF_aircraft_status.aileron);
  NAV_aircraft_status.elevator  = fixpoint_3_to_float (COMIF_aircraft_status.elevator);
  NAV_aircraft_status.rudder    = fixpoint_3_to_float (COMIF_aircraft_status.rudder);
  NAV_aircraft_status.throttle1 = fixpoint_3_to_float (COMIF_aircraft_status.throttle1);
  NAV_aircraft_status.throttle2 = fixpoint_3_to_float (COMIF_aircraft_status.throttle2);
  NAV_aircraft_status.latitude  = fixpoint_6_to_float (COMIF_aircraft_status.latitude);
  NAV_aircraft_status.longitude = fixpoint_6_to_float (COMIF_aircraft_status.longitude);
  NAV_aircraft_status.altitude  = fixpoint_3_to_float (COMIF_aircraft_status.altitude);
  NAV_aircraft_status.heading   = fixpoint_6_to_float (COMIF_aircraft_status.heading);
  NAV_aircraft_status.velocity  = fixpoint_3_to_float (COMIF_aircraft_status.velocity);
  NAV_aircraft_status.roll      = fixpoint_6_to_float (COMIF_aircraft_status.roll);
  NAV_aircraft_status.pitch     = fixpoint_6_to_float (COMIF_aircraft_status.pitch);
  NAV_aircraft_status.vertspeed = fixpoint_3_to_float (COMIF_aircraft_status.vertspeed);
}

void NAV_iface_aircraft_reset(void)
{
  COMIF_aircraft_reset();
  NAV_iface_aircraft_read();
}

