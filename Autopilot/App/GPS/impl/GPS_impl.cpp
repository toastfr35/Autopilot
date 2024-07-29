/*-----------------------------------------------------
-- GPS.IMPL
--
-- GPS task
  -----------------------------------------------------*/

#include "GPS_impl.hpp"
#include "../interfaces/GPS_iface.hpp"
#include <stdint.h>
#include <stdio.h>

extern "C" {
extern double cos (double);
extern double sin (double);
extern double acos (double);
}
#define M_PI 3.14159265358979323846


namespace GPS {

  extern "C" {
    uint64_t get_time_ms(void);
  }

  t_impl impl;


  //-----------------------------------
  //
  //-----------------------------------
  double distance_on_geoid(double lat1, double lon1, double lat2, double lon2) {
    // Convert degrees to radians
    lat1 = lat1 * M_PI / 180.0;
    lon1 = lon1 * M_PI / 180.0;
    lat2 = lat2 * M_PI / 180.0;
    lon2 = lon2 * M_PI / 180.0;
    // radius of earth in metres
    double r = 6378137;
    // P
    double rho1 = r * cos(lat1);
    double z1 = r * sin(lat1);
    double x1 = rho1 * cos(lon1);
    double y1 = rho1 * sin(lon1);
    // Q
    double rho2 = r * cos(lat2);
    double z2 = r * sin(lat2);
    double x2 = rho2 * cos(lon2);
    double y2 = rho2 * sin(lon2);
    // Dot product
    double dot = (x1 * x2 + y1 * y2 + z1 * z2);
    double cos_theta = dot / (r * r);
    double theta = acos(cos_theta);
    // Distance in Metres
    return r * theta;
  }

  //-----------------------------------
  //
  //-----------------------------------
  float calc_hspeed (float lat1, float long1, float lat2, float long2, uint32_t dt)
  {
    double dist_m = distance_on_geoid (lat1, long1, lat2, long2);
    double time_s = dt / 1000.0;
    double hspeed_m_per_s = dist_m / time_s;
    float hspeed_knots = hspeed_m_per_s / 0.514444;
    return hspeed_knots;
  }

  //-----------------------------------
  // Calculate the vertical speed based on change in altitude
  //-----------------------------------
  float calc_vspeed (float dalt, uint32_t dt)
  {
    float vspeed = (1000.0 / dt) * dalt;
    return vspeed;
  }

  //-----------------------------------
  // Reset internal state
  //-----------------------------------
  void t_impl::reset()
  {
    prev_valid = false;
  }


  //-----------------------------------
  // Compute hspeed and vspeed based of GPS coordinates changes
  //-----------------------------------
  void t_impl::step()
  {
    uint64_t time = get_time_ms();

    if (!prev_valid) {
      iface.gps.status.hspeed = 0.0;
      iface.gps.status.vspeed = 0.0;
    } else {
      uint32_t delta_time  = time - prev_time;
      iface.gps.status.hspeed = calc_hspeed (prev_latitude, prev_longitude, iface.gps.status.latitude, iface.gps.status.longitude, delta_time);
      iface.gps.status.vspeed = calc_vspeed (iface.gps.status.altitude - prev_altitude, delta_time);

      //char tmp[128];
      //sprintf(tmp, "lat = %f", (float)iface.gps.status.latitude);
      //BSP_LCD_ClearStringLine(0);
      //BSP_LCD_DisplayStringAtLine(0, (uint8_t *)tmp);
      //sprintf(tmp, "lon = %f", (float)iface.gps.status.longitude);
      //BSP_LCD_ClearStringLine(1);
      //BSP_LCD_DisplayStringAtLine(1, (uint8_t *)tmp);
      //sprintf(tmp, "alt = %f", (float)iface.gps.status.altitude);
      //BSP_LCD_ClearStringLine(2);
      //BSP_LCD_DisplayStringAtLine(2, (uint8_t *)tmp);
      //sprintf(tmp, "hspeed = %f", (float)iface.gps.status.hspeed);
      //BSP_LCD_ClearStringLine(3);
      //BSP_LCD_DisplayStringAtLine(3, (uint8_t *)tmp);
      //sprintf(tmp, "vspeed = %f", (float)iface.gps.status.vspeed);
      //BSP_LCD_ClearStringLine(4);
      //BSP_LCD_DisplayStringAtLine(4, (uint8_t *)tmp);

    }

    // remember previous values
    prev_latitude  = iface.gps.status.latitude;
    prev_longitude = iface.gps.status.longitude;
    prev_altitude  = iface.gps.status.altitude;
    prev_time      = time;
    prev_valid     = true;
  }

}
