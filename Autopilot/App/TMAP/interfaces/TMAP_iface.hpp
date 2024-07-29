/*-----------------------------------------------------
-- GPS.IFACE
--
-- Read/Write the HW interfaces for use by GPS
-----------------------------------------------------*/
#ifndef _TMAP_IFACE_HPP_
#define _TMAP_IFACE_HPP_

#include "interfaces.hpp"
#include "TMAP_iface_TMAP.hpp"
#include "TMAP_iface_ACS.hpp"
#include "TMAP_iface_GPS.hpp"

namespace TMAP {

class t_iface : interfaces {
	public :
		void read();
		void write();
		void reset();
		t_iface_ACS acs;
		t_iface_GPS gps;
		t_iface_TMAP tmap;
};

extern t_iface iface;

}

#endif
