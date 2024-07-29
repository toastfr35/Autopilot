/*-----------------------------------------------------
-- TMAP.IMPL
--
-- TMAP task
-----------------------------------------------------*/
#ifndef _GPS_IMPL_HPP_
#define _GPS_IMPL_HPP_

#include <stdint.h>

#define MAP_SIZE 201
#define MID (MAP_SIZE/2)

namespace TMAP {
    
  class t_impl {
    public :      
      void reset(); // Reset internal state
      void step();  // 
      uint32_t get_elevation(int32_t ilat, int32_t ilon);
  
    private :
      uint8_t map[MAP_SIZE][MAP_SIZE];
      int32_t pos_ilat, pos_ilon;
      int32_t prev_ilat, prev_ilon;
      int32_t ilat_low, ilat_high;
      int32_t ilon_low, ilon_high;
        
      void receive_data(void);    
      void request_data(int reqidx, int32_t ilat1, int32_t ilat2, int32_t ilon1, int32_t ilon2);
      void reload_lat(int32_t ilat);
      void reload_lon(int32_t ilon);
      void move(int32_t d_ilat, int32_t d_ilon);
      void jump(void);   
    
      void update_elevation_ahead(void);
  };  

  extern t_impl impl;
}

#endif

