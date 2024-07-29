#ifndef __IFACE_ACS_DECL_HPP__
#define __IFACE_ACS_DECL_HPP__

#ifdef __cplusplus
extern "C" {
#endif
typedef struct {
  float aileron;
  float elevator;
  float rudder;
  float throttle1;
  float throttle2;

  float heading;
  float airspeed;

  float roll;
  float pitch;
} t_ACS_status;

class t_iface_ACS : interface {
	public :
		void read();
		void write();
		void reset();
		t_ACS_status status;
};

#ifdef __cplusplus
}
#endif
#endif