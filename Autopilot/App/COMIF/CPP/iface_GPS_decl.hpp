#ifndef __IFACE_GPS_DECL_HPP__
#define __IFACE_GPS_DECL_HPP__

#ifdef __cplusplus
extern "C" {
#endif
typedef struct {
  double latitude;
  double longitude;
  float altitude;
  float hspeed;
  float vspeed;
} t_GPS_status;

class t_iface_GPS : interface {
	public :
		void read();
		void write();
		void reset();
		t_GPS_status status;
};

#ifdef __cplusplus
}
#endif

#endif
