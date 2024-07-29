#include <stdio.h>
#include "../../../App/NAV/interfaces/NAV_iface.hpp"
#include "../../../App/GPS/interfaces/GPS_iface.hpp"

#define TEST_ACS(FIELD) \
extern "C" {float cpp_test000_ACS_##FIELD();} \
float cpp_test000_ACS_##FIELD() {\
  NAV::iface.read();\
  return NAV::iface.acs.status.FIELD;\
}

TEST_ACS(aileron)
TEST_ACS(elevator)
TEST_ACS(rudder)
TEST_ACS(throttle1)
TEST_ACS(throttle2)
TEST_ACS(heading)
TEST_ACS(airspeed)
TEST_ACS(roll)
TEST_ACS(pitch)


#define TEST_GPS(FIELD) \
extern "C" {float cpp_test000_GPS_##FIELD();} \
float cpp_test000_GPS_##FIELD() {\
  GPS::iface.read();\
  return GPS::iface.gps.status.FIELD;\
}

TEST_GPS(latitude)
TEST_GPS(longitude)
TEST_GPS(altitude)
TEST_GPS(hspeed)
TEST_GPS(vspeed)

extern "C" {void cpp_test000_GPS_write();}
void cpp_test000_GPS_write()
{
  GPS::iface.gps.status.latitude   = 21.1;
  GPS::iface.gps.status.longitude  = 21.2;
  GPS::iface.gps.status.altitude    = 21.3;
  GPS::iface.gps.status.hspeed = 21.4;
  GPS::iface.gps.status.vspeed = 21.5;
  GPS::iface.write();
}


#define TEST_NAV(NAME,FIELD) \
extern "C" {float cpp_test000_NAV_##NAME();} \
float cpp_test000_NAV_##NAME() {\
  NAV::iface.read();\
  return NAV::iface.nav.status.FIELD;\
}

#define TEST2_NAV(NAME,FIELD) \
extern "C" {float cpp_test000_NAV_##NAME(int i);} \
float cpp_test000_NAV_##NAME(int i) {\
  NAV::iface.read();\
  return NAV::iface.nav.status.FIELD;\
}


TEST_NAV(enabled,enabled)
TEST_NAV(nav_target_heading, nav_target.heading)
TEST_NAV(nav_target_altitude, nav_target.altitude)
TEST_NAV(nav_target_hspeed, nav_target.hspeed)
TEST_NAV(target_latitude, target_latitude)
TEST_NAV(target_longitude, target_longitude)
TEST_NAV(current_waypoint_index, current_waypoint_index)

TEST2_NAV(wp0_ID, waypoints[i].ID)
TEST2_NAV(wp0_latitude, waypoints[i].latitude)
TEST2_NAV(wp0_longitude, waypoints[i].longitude)
TEST2_NAV(wp0_altitude, waypoints[i].altitude)
TEST2_NAV(wp0_hspeed, waypoints[i].hspeed)

extern "C" {void cpp_test000_NAV_write();}
void cpp_test000_NAV_write()
{
  NAV::iface.nav.status.enabled                 = 1;
  NAV::iface.nav.status.nav_target.heading      = 50.0;
  NAV::iface.nav.status.nav_target.altitude     = 50.1;
  NAV::iface.nav.status.nav_target.hspeed       = 50.2;
  NAV::iface.nav.status.target_latitude         = 50.3;
  NAV::iface.nav.status.target_longitude        = 50.4;
  NAV::iface.nav.status.current_waypoint_index  = 60.0;
  NAV::iface.nav.status.waypoints[12].ID        = 70.0;
  NAV::iface.nav.status.waypoints[12].latitude  = 80.1;
  NAV::iface.nav.status.waypoints[12].longitude = 80.2;
  NAV::iface.nav.status.waypoints[12].altitude  = 80.3;
  NAV::iface.nav.status.waypoints[12].hspeed    = 80.4;
  NAV::iface.write();
}

