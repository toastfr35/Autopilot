with types;
with tests;
with log;
with img;
with components; use components;
with FDM;
with COMIF.CDU;
with COMIF.NAV;
with COMIF.AFDS;
with COMIF.aircraft;
with CDU;

package body test007 is

   -- Test AFDS + NAV

   pragma Warnings(off);
   function get_current_waypoint_index (success : out Boolean) return Natural is
      function C_get_current_waypoint_index (success : out Boolean) return Natural;
      pragma Import (C, C_get_current_waypoint_index, "get_current_waypoint_index");
   begin
      return C_get_current_waypoint_index(success) + 1;
   end get_current_waypoint_index;
   pragma Warnings(on);


   procedure add_waypoint (ID : Natural; lat, lon, alt, vel : Float) is
      CDU_status : COMIF.CDU.t_CDU_status := COMIF.CDU.read_status (Comp_TEST);
      WP : types.t_waypoint;
   begin
      WP.ID := ID;
      WP.latitude := types.t_latitude(lat);
      WP.longitude := types.t_longitude(lon);
      WP.altitude := types.t_altitude(alt);
      WP.velocity := types.t_velocity(vel);

      CDU_status.action := COMIF.CDU.CDU_add_waypoint;
      CDU_status.data.waypoint := WP;
      COMIF.CDU.write_status (Comp_Test, CDU_status);
      CDU.step;
   end add_waypoint;

   procedure enable_NAV is
      CDU_status : COMIF.CDU.t_CDU_status := COMIF.CDU.read_status (Comp_TEST);
   begin
      CDU_status.action := COMIF.CDU.CDU_act_enable;
      CDU_status.data.component := Comp_NAV;
      COMIF.CDU.write_status (Comp_Test, CDU_status);
      CDU.step;
   end enable_NAV;



   procedure test007 is
      success : Boolean;
      waypoint : Natural;
   begin

      tests.configure ("NAV + AFDS (Waypoints)", AFDS => True, GCAS => False, NAV => True, CDU => False);

      -- set aircraft initial state
      FDM.set (latitude => 0.0,
               longitude => 0.0,
               altitude => 4000.0,
               heading => 0.0,
               velocity => 300.0
              );

      -- set AFDS configuration
      declare
         AFDS_status : COMIF.AFDS.t_AFDS_status := COMIF.AFDS.read_status (Comp_TEST);
         NAV_status  : COMIF.NAV.t_NAV_status := COMIF.NAV.read_status (Comp_TEST);
      begin
         AFDS_status.enabled := True;
         NAV_status.enabled := True;
         COMIF.AFDS.write_status (Comp_TEST, AFDS_status);
         COMIF.NAV.write_status (Comp_TEST, NAV_status);
      end;

      -- add a few waypoints
      add_waypoint (13,  0.0, 0.1, 4000.0, 300.0);   -- Waypoint 1
      add_waypoint (29,  0.1, 0.1, 4000.0, 350.0);   -- Waypoint 2
      add_waypoint (42,  0.2, 0.1, 4000.0, 200.0);   -- Waypoint 3
      add_waypoint (124, 0.1, 0.2, 4000.0, 500.0);   -- Waypoint 4
      add_waypoint (205, 0.0, 0.1, 4000.0, 300.0);   -- Waypoint 5

      enable_NAV;

      declare

         function check_waypoint (idx : Natural) return Boolean is
            R : Boolean := True;
         begin

            tests.run_steps (1);

            declare
               aircraft_status : constant COMIF.aircraft.t_aircraft_status := COMIF.aircraft.read_status (Comp_TEST);
               NAV_status : constant COMIF.NAV.t_NAV_status := COMIF.NAV.read_status (Comp_TEST);
            begin
               log.log (log.test, 1, 0, "TEST: (" &
                          img.Image(aircraft_status.latitude) & "," & img.Image(aircraft_status.longitude) & ") -> (" &
                          img.Image(NAV_status.target_latitude) & "," & img.Image(NAV_status.target_longitude) & ")"
                       );
            end;

            for i in 1 .. 20_000 loop

               tests.run_steps (1);

               waypoint := get_current_waypoint_index(success);
               if not success then
                  log.log (log.test, 1, 0, "TEST: No more waypoints");
                  R := False;
                  exit;
               end if;

               if waypoint /= idx then
                  exit;
               end if;

            end loop;

            tests.check ("Waypoint"& idx'Img & " reached", (waypoint = idx+1) or (idx=5 and waypoint=0));

            if waypoint /= (idx+1) then
               R := False;
            end if;

            return R;
         end check_waypoint;

      begin
         for i in 1 .. 5 loop
            exit when not check_waypoint(i);
         end loop;
      end;

   end test007;


begin
   tests.register_test (test007'Access);
end test007;
