#ifndef __IFACE_GPS_DEF_HPP__
#define __IFACE_GPS_DEF_HPP__

#include "types_conversion.hpp"

#ifdef __cplusplus
extern "C" {
#endif

#pragma pack(push, 4)
typedef struct {
  uint64_t latitude;
  uint64_t longitude;
  uint32_t altitude;
  uint32_t hspeed;
  uint32_t vspeed;
} t_COMIF_GPS_status;

static t_COMIF_GPS_status COMIF_GPS_status;
#pragma pack(pop)

extern "C" {
extern t_COMIF_GPS_status COMIF_GPS_read (t_component);
extern void COMIF_GPS_write (t_component, t_COMIF_GPS_status *);
extern void COMIF_GPS_reset(void);
}


void t_iface_GPS::read (void)
{
  COMIF_GPS_status = COMIF_GPS_read(COMPONENT_FROM);
  status.latitude  = latitude_to_double (COMIF_GPS_status.latitude);
  status.longitude = longitude_to_double (COMIF_GPS_status.longitude);
  status.altitude  = altitude_to_float (COMIF_GPS_status.altitude);
  status.hspeed    = hspeed_to_float (COMIF_GPS_status.hspeed);
  status.vspeed    = vspeed_to_float (COMIF_GPS_status.vspeed);
}

void t_iface_GPS::reset(void)
{
  COMIF_GPS_reset();
}

void t_iface_GPS::write(void)
{
  COMIF_GPS_status.latitude  = double_to_latitude(status.latitude);
  COMIF_GPS_status.longitude = double_to_longitude(status.longitude);
  COMIF_GPS_status.altitude  = float_to_altitude(status.altitude);
  COMIF_GPS_status.hspeed    = float_to_hspeed(status.hspeed);
  COMIF_GPS_status.vspeed    = float_to_vspeed(status.vspeed);
  COMIF_GPS_write(COMPONENT_FROM, &COMIF_GPS_status);
}

#ifdef __cplusplus
}
#endif
#endif
