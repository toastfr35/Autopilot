/*-------------------------------------------------------
-- NAV.IFACE.aircraft
--
-- This package provides
-- * read access to the aircraft status for NAV
-------------------------------------------------------*/

float NAV_iface_aircraft_get_aileron   (void);
float NAV_iface_aircraft_get_elevator  (void);
float NAV_iface_aircraft_get_rudder    (void);
float NAV_iface_aircraft_get_throttle1 (void);
float NAV_iface_aircraft_get_throttle2 (void);
float NAV_iface_aircraft_get_latitude  (void);
float NAV_iface_aircraft_get_longitude (void);
float NAV_iface_aircraft_get_altitude  (void);
float NAV_iface_aircraft_get_heading   (void);
float NAV_iface_aircraft_get_velocity  (void);
float NAV_iface_aircraft_get_roll      (void);
float NAV_iface_aircraft_get_pitch     (void);
float NAV_iface_aircraft_get_vertspeed (void);

void NAV_iface_aircraft_read (void);

void NAV_iface_aircraft_reset (void);

