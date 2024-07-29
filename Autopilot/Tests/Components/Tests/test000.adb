with types; use types;
with tests;
with components; use components;
with COMIF.ACS;
with COMIF.GPS;
with COMIF.NAV;

package body test000 is

   function cpp_test000_ACS_aileron return Float; pragma Import (C, cpp_test000_ACS_aileron, "cpp_test000_ACS_aileron");
   function cpp_test000_ACS_elevator return Float; pragma Import (C, cpp_test000_ACS_elevator, "cpp_test000_ACS_elevator");
   function cpp_test000_ACS_rudder return Float; pragma Import (C, cpp_test000_ACS_rudder, "cpp_test000_ACS_rudder");
   function cpp_test000_ACS_throttle1 return Float; pragma Import (C, cpp_test000_ACS_throttle1, "cpp_test000_ACS_throttle1");
   function cpp_test000_ACS_throttle2 return Float; pragma Import (C, cpp_test000_ACS_throttle2, "cpp_test000_ACS_throttle2");
   function cpp_test000_ACS_heading return Float; pragma Import (C, cpp_test000_ACS_heading, "cpp_test000_ACS_heading");
   function cpp_test000_ACS_airspeed return Float; pragma Import (C, cpp_test000_ACS_airspeed, "cpp_test000_ACS_airspeed");
   function cpp_test000_ACS_roll return Float; pragma Import (C, cpp_test000_ACS_roll, "cpp_test000_ACS_roll");
   function cpp_test000_ACS_pitch return Float; pragma Import (C, cpp_test000_ACS_pitch, "cpp_test000_ACS_pitch");

   function cpp_test000_GPS_latitude return Float; pragma Import (C, cpp_test000_GPS_latitude, "cpp_test000_GPS_latitude");
   function cpp_test000_GPS_longitude return Float; pragma Import (C, cpp_test000_GPS_longitude, "cpp_test000_GPS_longitude");
   function cpp_test000_GPS_altitude return Float; pragma Import (C, cpp_test000_GPS_altitude, "cpp_test000_GPS_altitude");
   function cpp_test000_GPS_hspeed return Float; pragma Import (C, cpp_test000_GPS_hspeed, "cpp_test000_GPS_hspeed");
   function cpp_test000_GPS_vspeed return Float; pragma Import (C, cpp_test000_GPS_vspeed, "cpp_test000_GPS_vspeed");
   procedure cpp_test000_GPS_write; pragma Import (C, cpp_test000_GPS_write, "cpp_test000_GPS_write");

   function cpp_test000_NAV_enabled return Float; pragma Import (C, cpp_test000_NAV_enabled, "cpp_test000_NAV_enabled");
   function cpp_test000_NAV_nav_target_heading return Float; pragma Import (C, cpp_test000_NAV_nav_target_heading, "cpp_test000_NAV_nav_target_heading");
   function cpp_test000_NAV_nav_target_altitude return Float; pragma Import (C, cpp_test000_NAV_nav_target_altitude, "cpp_test000_NAV_nav_target_altitude");
   function cpp_test000_NAV_nav_target_hspeed return Float; pragma Import (C, cpp_test000_NAV_nav_target_hspeed, "cpp_test000_NAV_nav_target_hspeed");
   function cpp_test000_NAV_target_latitude return Float; pragma Import (C, cpp_test000_NAV_target_latitude, "cpp_test000_NAV_target_latitude");
   function cpp_test000_NAV_target_longitude return Float; pragma Import (C, cpp_test000_NAV_target_longitude, "cpp_test000_NAV_target_longitude");
   function cpp_test000_NAV_current_waypoint_index return Float; pragma Import (C, cpp_test000_NAV_current_waypoint_index, "cpp_test000_NAV_current_waypoint_index");

   function cpp_test000_NAV_wp_ID        (idx : Natural) return Float; pragma Import (C, cpp_test000_NAV_wp_ID, "cpp_test000_NAV_wp0_ID");
   function cpp_test000_NAV_wp_latitude  (idx : Natural) return Float; pragma Import (C, cpp_test000_NAV_wp_latitude, "cpp_test000_NAV_wp0_latitude");
   function cpp_test000_NAV_wp_longitude (idx : Natural) return Float; pragma Import (C, cpp_test000_NAV_wp_longitude, "cpp_test000_NAV_wp0_longitude");
   function cpp_test000_NAV_wp_altitude  (idx : Natural) return Float; pragma Import (C, cpp_test000_NAV_wp_altitude, "cpp_test000_NAV_wp0_altitude");
   function cpp_test000_NAV_wp_hspeed    (idx : Natural) return Float; pragma Import (C, cpp_test000_NAV_wp_hspeed, "cpp_test000_NAV_wp0_hspeed");

   procedure cpp_test000_NAV_write; pragma Import (C, cpp_test000_NAV_write, "cpp_test000_NAV_write");


   procedure test000 is
      ACS_data : COMIF.ACS.t_ACS_status;
      GPS_data : COMIF.GPS.t_GPS_status;
      NAV_data : COMIF.NAV.t_NAV_status;
   begin
      tests.configure ("ADA_C++ Interface");

      -- ACS
      ACS_data := COMIF.ACS.read (Comp_TEST);
      ACS_data.aileron   := 12.1;
      ACS_data.elevator  := 12.2;
      ACS_data.rudder    := 12.3;
      ACS_data.throttle1 := 12.4;
      ACS_data.throttle2 := 12.5;
      ACS_data.heading   := 12.6;
      ACS_data.airspeed  := 12.7;
      ACS_data.roll      := 12.8;
      ACS_data.pitch     := 12.9;
      COMIF.ACS.write (Comp_TEST, ACS_data);

      tests.check ("Ada->C++ ACS.aileron",   cpp_test000_ACS_aileron,   12.1, 0.01);
      tests.check ("Ada->C++ ACS.elevator",  cpp_test000_ACS_elevator,  12.2, 0.01);
      tests.check ("Ada->C++ ACS.rudder" ,   cpp_test000_ACS_rudder,    12.3, 0.01);
      tests.check ("Ada->C++ ACS.throttle1", cpp_test000_ACS_throttle1, 12.4, 0.01);
      tests.check ("Ada->C++ ACS.throttle2", cpp_test000_ACS_throttle2, 12.5, 0.01);
      tests.check ("Ada->C++ ACS.heading",   cpp_test000_ACS_heading,   12.6, 0.01);
      tests.check ("Ada->C++ ACS.airspeed",  cpp_test000_ACS_airspeed,  12.7, 0.01);
      tests.check ("Ada->C++ ACS.roll",      cpp_test000_ACS_roll,      12.8, 0.01);
      tests.check ("Ada->C++ ACS.pitch",     cpp_test000_ACS_pitch,     12.9, 0.01);

      -- GPS
      GPS_data := COMIF.GPS.read (Comp_TEST);
      GPS_data.latitude  := 12.1;
      GPS_data.longitude := 12.2;
      GPS_data.altitude  := 12.3;
      GPS_data.hspeed    := 12.4;
      GPS_data.vspeed    := 12.5;
      COMIF.GPS.write (Comp_TEST, GPS_data);

      tests.check ("Ada->C++ GPS.latitude",  cpp_test000_GPS_latitude,  12.1, 0.01);
      tests.check ("Ada->C++ GPS.longitude", cpp_test000_GPS_longitude, 12.2, 0.01);
      tests.check ("Ada->C++ GPS.altitude",  cpp_test000_GPS_altitude,  12.3, 0.01);
      tests.check ("Ada->C++ GPS.hspeed",    cpp_test000_GPS_hspeed,    12.4, 0.01);
      tests.check ("Ada->C++ GPS.vspeed",    cpp_test000_GPS_vspeed,    12.5, 0.01);

      cpp_test000_GPS_write;
      GPS_data := COMIF.GPS.read (Comp_TEST);

      tests.check ("C++->Ada GPS.latitude",  Float(GPS_data.latitude),  21.1, 0.01);
      tests.check ("C++->Ada GPS.longitude", Float(GPS_data.longitude), 21.2, 0.01);
      tests.check ("C++->Ada GPS.altitude" , Float(GPS_data.altitude),  21.3, 0.01);
      tests.check ("C++->Ada GPS.hspeed",    Float(GPS_data.hspeed),    21.4, 0.01);
      tests.check ("C++->Ada GPS.vspeed",    Float(GPS_data.vspeed),    21.5, 0.01);

      -- NAV
      NAV_data := COMIF.NAV.read (Comp_TEST);
      NAV_data.enabled                := True;
      NAV_data.nav_target.heading     := 12.2;
      NAV_data.nav_target.altitude    := 12.3;
      NAV_data.nav_target.hspeed      := 12.4;
      NAV_data.target_latitude        := 12.5;
      NAV_data.target_longitude       := 12.6;
      NAV_data.current_waypoint_index := 12;

      for i in 1 .. 64 loop
         NAV_data.waypoints(i).ID        := 22   + i;
         NAV_data.waypoints(i).latitude  := 22.1 + t_latitude(i);
         NAV_data.waypoints(i).longitude := 22.2 + t_longitude(i);
         NAV_data.waypoints(i).altitude  := 22.3 + t_altitude(i);
         NAV_data.waypoints(i).hspeed    := 22.4 + t_hspeed(i);
      end loop;

      COMIF.NAV.write (Comp_TEST, NAV_data);

      tests.check ("Ada->C++ NAV.enabled",                cpp_test000_NAV_enabled,                 1.0, 0.01);
      tests.check ("Ada->C++ NAV.nav_target.heading",     cpp_test000_NAV_nav_target_heading,     12.2, 0.1);
      tests.check ("Ada->C++ NAV.nav_target.altitude",    cpp_test000_NAV_nav_target_altitude,    12.3, 0.1);
      tests.check ("Ada->C++ NAV.nav_target.hspeed",      cpp_test000_NAV_nav_target_hspeed,      12.4, 0.1);
      tests.check ("Ada->C++ NAV.target_latitude",        cpp_test000_NAV_target_latitude,        12.5, 0.1);
      tests.check ("Ada->C++ NAV.target_longitude",       cpp_test000_NAV_target_longitude,       12.6, 0.1);
      tests.check ("Ada->C++ NAV.current_waypoint_index", cpp_test000_NAV_current_waypoint_index, 11.0, 0.1);

      for i in 0 .. 63 loop
         tests.check ("Ada->C++ NAV.waypoints[].ID",        cpp_test000_NAV_wp_ID(i),        Float(i) + 23.0 , 0.1);
         tests.check ("Ada->C++ NAV.waypoints[].latitude",  cpp_test000_NAV_wp_latitude(i),  Float(i) + 23.1, 0.1);
         tests.check ("Ada->C++ NAV.waypoints[].longitude", cpp_test000_NAV_wp_longitude(i), Float(i) + 23.2, 0.1);
         tests.check ("Ada->C++ NAV.waypoints[].altitude",  cpp_test000_NAV_wp_altitude(i),  Float(i) + 23.3, 0.1);
         tests.check ("Ada->C++ NAV.waypoints[].hspeed",    cpp_test000_NAV_wp_hspeed(i),    Float(i) + 23.4, 0.1);
      end loop;

      cpp_test000_NAV_write;
      NAV_data := COMIF.NAV.read (Comp_TEST);

      tests.check ("C++->Ada NAV.enabled",                (if NAV_data.enabled then 1.0 else 0.0),   1.0, 0.01);
      tests.check ("C++->Ada NAV.nav_target.heading",     Float(NAV_data.nav_target.heading),       50.0, 0.01);
      tests.check ("C++->Ada NAV.nav_target.altitude",    Float(NAV_data.nav_target.altitude),      50.1, 0.01);
      tests.check ("C++->Ada NAV.nav_target.hspeed",      Float(NAV_data.nav_target.hspeed),        50.2, 0.01);
      tests.check ("C++->Ada NAV.target_latitude",        Float(NAV_data.target_latitude),          50.3, 0.01);
      tests.check ("C++->Ada NAV.target_longitude",       Float(NAV_data.target_longitude),         50.4, 0.01);
      tests.check ("C++->Ada NAV.current_waypoint_index", Float(NAV_data.current_waypoint_index),   61.0, 0.01);
      tests.check ("C++->Ada NAV.waypoints(13).ID",       Float(NAV_data.waypoints(13).ID),         70.0, 0.01);
      tests.check ("C++->Ada NAV.waypoints(13).latitude", Float(NAV_data.waypoints(13).latitude),   80.1, 0.01);
      tests.check ("C++->Ada NAV.waypoints(13).longitude",Float(NAV_data.waypoints(13).longitude),  80.2, 0.01);
      tests.check ("C++->Ada NAV.waypoints(13).altitude", Float(NAV_data.waypoints(13).altitude),   80.3, 0.01);
      tests.check ("C++->Ada NAV.waypoints(13).hspeed",   Float(NAV_data.waypoints(13).hspeed),     80.4, 0.01);

   end test000;


begin
   tests.register_test (test000'Access);
end test000;
