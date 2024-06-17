/*-------------------------------------------------------
-- NAV.IFACE.aircraft
--
-- This package provides
-- * read access to the aircraft status for NAV
-------------------------------------------------------*/

typedef struct {
  float aileron;
  float elevator;
  float rudder;
  float throttle1;
  float throttle2;
  float latitude;
  float longitude;
  float altitude;
  float heading;
  float velocity;
  float vertspeed;
  float roll;
  float pitch;
} t_aircraft_status;

extern t_aircraft_status NAV_aircraft_status;


void NAV_iface_aircraft_read (void);

void NAV_iface_aircraft_reset (void);

