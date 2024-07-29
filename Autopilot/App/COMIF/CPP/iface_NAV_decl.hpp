#ifndef __IFACE_NAV_DECL_HPP__
#define __IFACE_NAV_DECL_HPP__

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
  float heading;
  float altitude;
  float hspeed;
} t_nav_target;

typedef struct {
  bool enabled;
  t_nav_target nav_target;
  double target_latitude;
  double target_longitude;
  uint32_t current_waypoint_index;
  t_waypoints waypoints;
} t_NAV_status;

class t_iface_NAV : interface {
	public :
		void read();
		void write();
		void reset();
		t_NAV_status status;
};

#ifdef __cplusplus
}
#endif
#endif
