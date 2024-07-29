/*-----------------------------------------------------
-- GPS.IMPL
--
-- GPS task
-----------------------------------------------------*/
#ifndef _GPS_IMPL_HPP_
#define _GPS_IMPL_HPP_

#include <stdint.h>

namespace GPS {
    
  class t_impl {
    public :      
      void reset(); // Reset internal state
      void step(); // Update desired heading to next waypoint
    private :
      bool  prev_valid     = false;
      float prev_latitude;
      float prev_longitude;
      float prev_altitude;
      uint64_t prev_time;    
  };  

  extern t_impl impl;
}

#endif

