#include "types_conversion.hpp"
#include "stdio.h"

#pragma pack(push, 4)
typedef struct {
  uint64_t latitude;
  uint64_t longitude;
  uint32_t elevation;
  uint32_t valid;  
  t_request  requests[64];
  t_response response;  
  uint16_t elevation_profile[MAP_SIZE/2];
} t_COMIF_TMAP_status;

static t_COMIF_TMAP_status COMIF_TMAP_status;
#pragma pack(pop)

extern "C" {
extern t_COMIF_TMAP_status COMIF_TMAP_read (t_component);
extern void COMIF_TMAP_write (t_component, t_COMIF_TMAP_status *);
extern void COMIF_TMAP_reset(void);
}


void t_iface_TMAP::read (void)
{
  COMIF_TMAP_status = COMIF_TMAP_read(COMPONENT_FROM);
  status.latitude  = latitude_to_double (COMIF_TMAP_status.latitude);
  status.longitude = longitude_to_double (COMIF_TMAP_status.longitude);
  status.elevation = altitude_to_float (COMIF_TMAP_status.elevation);
  status.valid = COMIF_TMAP_status.valid;

  // request
  status.requests[0].valid = COMIF_TMAP_status.requests[63].valid;
  status.requests[1].valid = COMIF_TMAP_status.requests[62].valid;
  
  // response
  status.response.valid = COMIF_TMAP_status.response.valid;
  status.response.ilat1 = COMIF_TMAP_status.response.ilat1;
  status.response.ilat2 = COMIF_TMAP_status.response.ilat2;
  status.response.ilon1 = COMIF_TMAP_status.response.ilon1;
  status.response.ilon2 = COMIF_TMAP_status.response.ilon2;
  memcpy (status.response.data, COMIF_TMAP_status.response.data, MAP_SIZE);  
}

void t_iface_TMAP::reset(void)
{
  COMIF_TMAP_reset();
}

void t_iface_TMAP::write(void)
{
  COMIF_TMAP_status.latitude  = double_to_latitude(status.latitude);
  COMIF_TMAP_status.longitude = double_to_longitude(status.longitude);
  COMIF_TMAP_status.elevation = float_to_altitude(status.elevation);
  COMIF_TMAP_status.valid     = status.valid;
   
  // request
  int reqidx=0;
  for(int i=0; i<64; i++) {
    if (!COMIF_TMAP_status.requests[i].valid) {
      COMIF_TMAP_status.requests[i].ilat1 = status.requests[reqidx].ilat1;
      COMIF_TMAP_status.requests[i].ilat2 = status.requests[reqidx].ilat2;
      COMIF_TMAP_status.requests[i].ilon1 = status.requests[reqidx].ilon1;
      COMIF_TMAP_status.requests[i].ilon2 = status.requests[reqidx].ilon2;
      COMIF_TMAP_status.requests[i].valid = status.requests[reqidx].valid;
      reqidx++;
      if (reqidx==2) break;
    }
  }        

  // response
  COMIF_TMAP_status.response.valid = status.response.valid;
              
  // elevation_profile
  memcpy (COMIF_TMAP_status.elevation_profile, status.elevation_profile, 2*(MAP_SIZE/2));   
  
  COMIF_TMAP_write(COMPONENT_FROM, &COMIF_TMAP_status);    
}
