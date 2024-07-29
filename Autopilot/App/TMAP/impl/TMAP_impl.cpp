/*-----------------------------------------------------
  -- TMAP.IMPL
  --
  -- TMAP task
  -----------------------------------------------------*/

#include "TMAP_impl.hpp"
#include "../interfaces/TMAP_iface.hpp"
#include <stdint.h>
#include <stdio.h>

extern "C" {
extern double cos (double);
extern double sin (double);
}
#define M_PI 3.14159265358979323846
#define abs(x) ((x<0)?-x:x)


namespace TMAP {

  t_impl impl;
    
  static double d2r(double d) {return (d / 180.0) * ((double) M_PI);}
  
  //-----------------------------------
  // convert from integer lat/lon to map index
  //----------------------------------- 
  static uint32_t latlon_to_index(int32_t v)
  {
    if (v >=0 ) {
      return  (v + MID) % MAP_SIZE;
    } else {
      uint32_t r = ((MAP_SIZE + MID) - (abs(v) % MAP_SIZE)) % MAP_SIZE;
      return r;
    }
  }    
  
  
  //-----------------------------------
  // fill the list of elevations on the immediate 5 seconds flight path
  //-----------------------------------
  void t_impl::update_elevation_ahead(void)
  {
    double lat = iface.gps.status.latitude;
    double lon = iface.gps.status.longitude;    
    double heading = iface.acs.status.heading;
    float hspeed_knots = iface.gps.status.hspeed; 
    float hspeed_mps = hspeed_knots * 0.514444;
    float dist_m_5s = hspeed_mps * 5.0;
    uint32_t N = (dist_m_5s / 100) + 2; // 100m ~ 0.001deg = one map cell
        
//    uint32_t ilat = iface.gps.status.latitude * 1000.0;
//    uint32_t ilon = iface.gps.status.longitude * 1000.0;    
//    static uint32_t p_ilat = -1;
//    static uint32_t p_ilon = -1;    
//    if ((p_ilat == ilat) && (p_ilon==ilon)) {        
//      iface.tmap.status.valid = 0;      
//      return;      
//    }    
//    p_ilat = ilat;
//    p_ilon = ilon;                        
//    printf ("TMAP: (%d,%d) HS=%0.2f m/s  dist5=%0.2fm  N=%d\n", ilat, ilon, hspeed_mps, dist_m_5s, N);
            
    double f_lat = cos(d2r(heading));
    double f_lon = sin(d2r(heading));
    
    for (uint32_t i=0; i<N; i++) {
      double degdist = 0.001 * i;
      uint32_t ilat = (lat + f_lat * degdist) * 1000.0;
      uint32_t ilon = (lon + f_lon * degdist) * 1000.0;
      uint32_t elevation = get_elevation (ilat, ilon);      
      iface.tmap.status.elevation_profile[i] = elevation;      
//      uint32_t x = latlon_to_index(ilat);
//      uint32_t y = latlon_to_index(ilon);
//      printf ("(%d,%d) [%d,%d] = %d\n", ilat,ilon, x, y, elevation);      
    }
    iface.tmap.status.elevation_profile[N] = 0xFFFF;
        
  }  
  
  
  //-----------------------------------
  // Reset internal state
  //-----------------------------------
  void t_impl::reset()
  {
    impl.prev_ilat = 0x7FFFFFFF;
    impl.prev_ilon = 0x7FFFFFFF;    
  }  
  
  
  //-----------------------------------
  // receive new map data and place it on the map
  //----------------------------------- 
  void t_impl::receive_data(void)
  {
    uint32_t idx = 0;

    if (!iface.tmap.status.response.valid) return;

    if (iface.tmap.status.response.ilat1 == iface.tmap.status.response.ilat2) {
      uint32_t x = latlon_to_index(iface.tmap.status.response.ilat1);
      for(int32_t ilon=iface.tmap.status.response.ilon1; ilon<=iface.tmap.status.response.ilon2; ilon++) {
        uint32_t y = latlon_to_index(ilon);
        map[x][y] = iface.tmap.status.response.data[idx++];
      }
    }
    else if (iface.tmap.status.response.ilon1==iface.tmap.status.response.ilon2) {
      uint32_t y = latlon_to_index(iface.tmap.status.response.ilon1);
      for(int32_t ilat=iface.tmap.status.response.ilat1; ilat<=iface.tmap.status.response.ilat2; ilat++) {
        uint32_t x = latlon_to_index(ilat);
        map[x][y] = iface.tmap.status.response.data[idx++];
      }
    } else {
      printf("ERROR: bad response\n");
    }
    iface.tmap.status.response.valid = 0;
  }
  
  
  //-----------------------------------
  // request new map data
  //-----------------------------------
  void t_impl::request_data(int reqidx, int32_t ilat1, int32_t ilat2, int32_t ilon1, int32_t ilon2)
  {
    if (iface.tmap.status.requests[reqidx].valid) printf ("ERROR: request %d is busy\n", reqidx);
    iface.tmap.status.requests[reqidx].ilat1 = ilat1;
    iface.tmap.status.requests[reqidx].ilat2 = ilat2;    
    iface.tmap.status.requests[reqidx].ilon1 = ilon1;    
    iface.tmap.status.requests[reqidx].ilon2 = ilon2;    
    iface.tmap.status.requests[reqidx].valid = 1;
  }
    

  //-----------------------------------
  // request a new map row
  //-----------------------------------
  void t_impl::reload_lat(int32_t ilat)
  {
    request_data(0, ilat, ilat, ilon_low, ilon_high);
  }

  
  //-----------------------------------
  // request a new map column
  //-----------------------------------
  void t_impl::reload_lon(int32_t ilon)
  {
    request_data(1, ilat_low, ilat_high, ilon, ilon);
  }
  
  
  //-----------------------------------
  // move lat/lon by one unit
  //-----------------------------------
  void t_impl::move(int32_t d_ilat, int32_t d_ilon)
  {
    ilat_low  += d_ilat;    
    ilat_high += d_ilat;    
    ilon_low  += d_ilon;    
    ilon_high += d_ilon;    
    if (d_ilat == 1)  reload_lat(ilat_high);    
    if (d_ilat == -1) reload_lat(ilat_low);    
    if (d_ilon == 1)  reload_lon(ilon_high);    
    if (d_ilon == -1) reload_lon(ilon_low);       
  }
  
  
  //-----------------------------------
  // jump to a new location, reload the entire map
  //-----------------------------------
  void t_impl::jump()
  {
    ilat_low  = pos_ilat-MID;
    ilon_low  = pos_ilon-MID;
    ilat_high = pos_ilat + MID;
    ilon_high = pos_ilon + MID;
    request_data(0, ilat_low, ilat_high, ilon_low,ilon_high);    
  }
  
   
  //-----------------------------------
  // get the elevation at a given lat/lon on the map
  //-----------------------------------
  uint32_t t_impl::get_elevation(int32_t ilat, int32_t ilon)
  {   
    uint32_t x = latlon_to_index(ilat);    
    uint32_t y = latlon_to_index(ilon);
    return ((uint32_t)(map[x][y])) * 10;
  }
  
  
  //-----------------------------------
  // 
  //-----------------------------------
  void t_impl::step()
  {
    // Convert to integer latitude,longitude (1/1000 of degrees ~ 100m)
    pos_ilat = (int32_t)(iface.gps.status.latitude * 1000.0);
    pos_ilon = (int32_t)(iface.gps.status.longitude * 1000.0);
    
    int32_t delta_ilat = (int32_t)(pos_ilat - prev_ilat);
    int32_t delta_ilon = (int32_t)(pos_ilon - prev_ilon);
       
    // Check for incoming data
    if (iface.tmap.status.response.valid) {
      receive_data();
    } else {
      // no incoming data, previous jump is done
      iface.tmap.status.valid = 1;
    }
            
    // Update current position from GPS
    iface.tmap.status.latitude = iface.gps.status.latitude;    
    iface.tmap.status.longitude = iface.gps.status.longitude;    
        
    if ( (delta_ilat == 0) && (delta_ilon == 0) ) {
      // No change of position on the map
    }  
    else if ( (abs(delta_ilat) > 1) || (abs(delta_ilon) > 1) ) {
      // Large change of position on the map
      jump ();      
      iface.tmap.status.valid = 0;
    }
    else {
      // Small change of position          
      move (delta_ilat, delta_ilon);
    }
        
    if (iface.tmap.status.valid) { 
      iface.tmap.status.elevation = get_elevation(pos_ilat, pos_ilon);
      update_elevation_ahead();
    } else {
      iface.tmap.status.elevation = 0.0;
    }

    // remember previous position
    prev_ilat = pos_ilat;
    prev_ilon = pos_ilon;
    
  }

}
