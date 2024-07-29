/*-----------------------------------------------------
-- NAV.IFACE
--
-- Read/Write the HW interfaces for use by NAV
-----------------------------------------------------*/
#ifndef _NAV_IFACE_HPP_
#define _NAV_IFACE_HPP_

#include "interfaces.hpp"
#include "NAV_iface_ACS.hpp"
#include "NAV_iface_GPS.hpp"
#include "NAV_iface_NAV.hpp"

//#ifdef __cplusplus
//extern "C" {
//#endif

namespace NAV {

class t_iface : interfaces {
	public :
		void read();
		void write();
		void reset();
		t_iface_ACS acs;
     t_iface_GPS gps;
     t_iface_NAV nav;
};

extern t_iface iface;

}

//#ifdef __cplusplus
//}
//#endif

#endif
