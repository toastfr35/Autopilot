#include <stdint.h>

typedef struct {
  uint32_t heading;
  uint32_t altitude;
  uint32_t velocity;
} t_nav_target;

extern t_nav_target * nav_interface_data_ptr;

typedef struct {
  uint32_t aileron;
  uint32_t elevator;
  uint32_t rudder;
  uint32_t throttle1;
  uint32_t throttle2;
  uint32_t latitude;
  uint32_t longitude;
  uint32_t altitude;
  uint32_t heading;
  uint32_t velocity;
  uint32_t roll;
  uint32_t pitch;
  uint32_t vertspeed;
} t_aircraft_status;

extern t_aircraft_status * aircraft_interface_data_ptr;

