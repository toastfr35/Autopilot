#include "nav_interface.h"

t_aircraft_status * aircraft_interface_data_ptr = (t_aircraft_status *) 0x800000;


extern t_nav_target nav_interface_data;

t_nav_target * nav_interface_data_ptr = &nav_interface_data;
