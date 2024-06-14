/*-------------------------------------------------------
-- NAV.IFACE.NAV
--
-- This package provides
-- * read access to the NAV status for NAV
-- * write access to the NAV controls for NAV
-------------------------------------------------------*/

#include <stdbool.h>

bool  NAV_iface_NAV_get_enabled  (void);
float NAV_iface_NAV_get_heading  (void);
float NAV_iface_NAV_get_altitude (void);
float NAV_iface_NAV_get_velocity (void);

void NAV_iface_NAV_set_enabled  (bool);
void NAV_iface_NAV_set_heading  (float);
void NAV_iface_NAV_set_altitude (float);
void NAV_iface_NAV_set_velocity (float);

void NAV_iface_NAV_read(void);

void NAV_iface_NAV_write(void);

void NAV_iface_NAV_reset (void);


