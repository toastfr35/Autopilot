/*-----------------------------------------------------
-- GPS.IFACE
--
-- Read/Write the HW interfaces for use by GPS
-----------------------------------------------------*/
#ifndef _GPS_IFACE_HPP_
#define _GPS_IFACE_HPP_

#include "interfaces.hpp"
#include "GPS_iface_GPS.hpp"

namespace GPS {

class t_iface : interfaces {
	public :
		void read();
		void write();
		void reset();
     t_iface_GPS gps;
};

extern t_iface iface;

}

#endif
