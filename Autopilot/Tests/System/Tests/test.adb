
with Interfaces;
with test_support;
with plot;

with components; use components;
with types; use types;


with COMIF.CDU;  -- R/W : send commands for testing
with COMIF.NAV;  -- R   : get current waypoint
with COMIF.GCAS; -- R   : get GCAS state

with FDM; -- Flight Dynamic  Model simualtion
with CDU;

package body test is

   procedure freertos_set_max_speed;
   pragma Import (C, freertos_set_max_speed, "freertos_set_max_speed");

   prev_WP_index : Natural := 0; -- the previous waypoint number
   prev_GCAS_state : types.t_GCAS_state := types.GCAS_state_disengaged;

   ----------------------------------------
   --
   ----------------------------------------
   Msg : String(1 .. 256);
   Msg_Last : Natural := 0;
   procedure add_msg (S : String) is
      l : constant Natural := S'length;
   begin
      Msg(Msg_Last+1..Msg_Last+l) := S;
      Msg_Last := Msg_Last+l;
      Msg(Msg_Last+1) := Character'Val(0);
   end add_msg;

   procedure add_int (N : Natural) is
      Digit : Natural := 0;
      Temp   : Natural := N;
   begin
      loop
         Digit := Digit + 1;
         Temp := Temp / 10;
         exit when Temp = 0;
      end loop;
      Temp := N;
      for I in reverse 1 .. Digit loop
         Msg(Msg_Last+I) := Character'Val(Character'Pos('0') + (Temp mod 10));
         Temp := Temp / 10;
      end loop;
      Msg_Last := Msg_Last + Digit;
   end add_int;


   ----------------------------------------
   -- initialise system for test
   ----------------------------------------
   procedure init is
   begin
         FDM.set (latitude => 0.0,
                  longitude => 0.0,
                  altitude => 1000.0,
                  heading => 0.0,
                  speed => 500.0
                 );
   end init;

   ----------------------------------------
   -- test steps
   ----------------------------------------
   procedure step (hz : Natural; cycles, time_ms : Interfaces.Unsigned_64)
   is
      GCAS_status : COMIF.GCAS.t_GCAS_status := COMIF.GCAS.read (Comp_TEST);
      CDU_status : COMIF.CDU.t_CDU_status := COMIF.CDU.read (Comp_TEST);
      NAV_status : COMIF.NAV.t_NAV_status := COMIF.NAV.read (Comp_TEST);

      ----------------------------------------
      -- use CDU interface to enable NAV
      procedure enabled_NAV is
      begin
         CDU_status.action := COMIF.CDU.CDU_act_enable;
         CDU_status.action_data.component := components.Comp_NAV;
      end enabled_NAV;

      ----------------------------------------
      -- use CDU interface to enable AFDS
      procedure enabled_AFDS is
      begin
         CDU_status.action := COMIF.CDU.CDU_act_enable;
         CDU_status.action_data.component := components.Comp_AFDS;
      end enabled_AFDS;

      ----------------------------------------
      -- use CDU interface to enable GCAS
      procedure enabled_GCAS is
      begin
         CDU_status.action := COMIF.CDU.CDU_act_enable;
         CDU_status.action_data.component := components.Comp_GCAS;
      end enabled_GCAS;

      ----------------------------------------
      -- set aircraft initial state
      procedure init_aircraft is
      begin
         FDM.set (latitude => 0.0,
                  longitude => 0.0,
                  altitude => 1000.0,
                  heading => 0.0,
                  speed => 500.0
                 );
      end init_aircraft;

      ----------------------------------------
      -- Use CDU interface to add a waypoint
      procedure add_waypoint (ID : Natural; lat, lon, alt, vel : Float) is
         WP : types.t_waypoint;
      begin
         WP.ID := ID;
         WP.latitude := types.t_latitude(lat);
         WP.longitude := types.t_longitude(lon);
         WP.altitude := types.t_altitude(alt);
         WP.hspeed := types.t_hspeed(vel);
         CDU_status.action := COMIF.CDU.CDU_add_waypoint;
         CDU_status.action_data.waypoint := WP;
         plot.add_waypoint(lat, lon);
      end add_waypoint;

      ----------------------------------------
      -- Test
      procedure test_waypoints is
      begin
         if NAV_status.current_waypoint_index /= prev_WP_index then

            Msg_Last := 0;
            add_msg ("Reached waypoint ");
            add_int (Natural(prev_WP_index));
            add_msg (" @ ");
            add_int (Natural(time_ms));
            add_msg (" ms");
            test_support.message (Msg);

            if prev_WP_index = 5 then
               plot.close;
               test_support.test_end;
            end if;
            prev_WP_index := NAV_status.current_waypoint_index;
         end if;

      end test_waypoints;


   begin

      if GCAS_status.GCAS_state /= prev_GCAS_state then
         prev_GCAS_state := GCAS_status.GCAS_state;
         case GCAS_status.GCAS_state is
            when GCAS_state_disengaged => test_support.message ("GCAS disengaged");
            when GCAS_state_emergency  => test_support.message ("GCAS emergency");
            when GCAS_state_recovery   => test_support.message ("GCAS recovery");
            when GCAS_state_stabilize  => test_support.message ("GCAS stabilize");
         end case;
      end if;

      case (cycles) is
         -- add a few waypoints
         when 0 => plot.open(0);
         when 1 => add_waypoint (13,  0.2,   0.2,  2000.0, 500.0);   -- Waypoint 1
         when 2 => add_waypoint (29,  0.05,  0.2,  8000.0, 500.0);   -- Waypoint 2
         when 3 => add_waypoint (42,  0.4,   0.4,  2000.0, 500.0);   -- Waypoint 3
         when 4 => add_waypoint (13,  0.3,   0.1,  3000.0, 500.0);   -- Waypoint 4 (same name as WP1 to see if the system can support that)
         when 5 => add_waypoint (205, 0.05,  0.05, 1000.0, 500.0);   -- Waypoint 5
         when 6 => init_aircraft;
         when 7 => enabled_NAV;  -- enable waypoint navigation (NAV module)
         when 8 => enabled_AFDS; -- enable waypoint navigation (AFDS module)
         when 9 => enabled_GCAS; -- enable GCAS
         when 10 => freertos_set_max_speed;
         when others => test_waypoints;
      end case;

      -- write CDU command
      COMIF.CDU.write (Comp_Test, CDU_status);

      plot.step;
   end step;


end test;
