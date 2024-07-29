#ifndef __IFACE_ACS_DEF_HPP__
#define __IFACE_ACS_DEF_HPP__

#include "types_conversion.hpp"

#ifdef __cplusplus
extern "C" {
  #endif

typedef struct {
  uint32_t aileron;
  uint32_t elevator;
  uint32_t rudder;
  uint32_t throttle1;
  uint32_t throttle2;

  uint32_t heading;
  uint32_t airspeed;

  uint32_t roll;
  uint32_t pitch;
} t_COMIF_ACS_status;

static t_COMIF_ACS_status COMIF_ACS_status;

extern "C" {
extern t_COMIF_ACS_status COMIF_ACS_read (t_component);
extern void COMIF_ACS_reset(void);
}


void t_iface_ACS::read (void)
{
  COMIF_ACS_status = COMIF_ACS_read (COMPONENT_FROM);
  status.aileron   = control_to_float (COMIF_ACS_status.aileron);
  status.elevator  = control_to_float (COMIF_ACS_status.elevator);
  status.rudder    = control_to_float (COMIF_ACS_status.rudder);
  status.throttle1 = control_to_float (COMIF_ACS_status.throttle1);
  status.throttle2 = control_to_float (COMIF_ACS_status.throttle2);
  status.heading   = heading_to_float (COMIF_ACS_status.heading);
  status.airspeed  = hspeed_to_float (COMIF_ACS_status.airspeed);
  status.roll      = roll_to_float (COMIF_ACS_status.roll);
  status.pitch     = pitch_to_float (COMIF_ACS_status.pitch);
}

void t_iface_ACS::reset(void)
{
  COMIF_ACS_reset();
}

void t_iface_ACS::write(void)
{
  abort();
}

#ifdef __cplusplus
}
#endif
#endif
