-------------------------------------------------------
-- Package CDU
--
-- Control Display Unit
-- Enabled/Disable AFDS, NAV, GCAS
-- Edit waypoints
-------------------------------------------------------

with COMIF.CDU;
with CDU.iface.NAV;
with CDU.iface.GCAS;
with CDU.iface.AFDS;
with CDU.iface.CDU;

with components; use components;
with types;
with log;
with img;

package body CDU.IMPL is

   -------------------------------
   -- Reset internal state
   -------------------------------
   procedure reset is
   begin
      null; -- no internal state
   end reset;


   -------------------------------
   -- clear the waypoint list
   -------------------------------
   procedure NAV_clear_waypoints is
   begin
      log.log (log.CDU, 1, 0, "CDU: Waypoints cleared");
      CDU.iface.NAV.status.waypoints(types.t_waypoints'First) := (0, 0.0, 0.0, 0.0, 0.0);
      CDU.iface.NAV.status.current_waypoint_index := 0;
   end NAV_clear_waypoints;


   -------------------------------
   -- Add a waypoint to the list
   -------------------------------
   procedure NAV_add_waypoint is
   begin
      CDU.iface.CDU.status.action_success := False;
      if CDU.iface.CDU.status.data.waypoint.ID /= 0 then
         for i in CDU.iface.NAV.status.waypoints'Range loop
            if CDU.iface.NAV.status.waypoints(i).ID = 0 then
               CDU.iface.NAV.status.waypoints(i) := CDU.iface.CDU.status.data.waypoint;
               log.log (log.CDU, 1, 0, "CDU: Added waypoint" & i'Img & ": '" &
                          CDU.iface.NAV.status.waypoints(i).ID'Img & "' (" &
                          img.Image(CDU.iface.NAV.status.waypoints(i).velocity) & "," &
                          img.Image(CDU.iface.NAV.status.waypoints(i).altitude) & "," &
                          img.Image(CDU.iface.NAV.status.waypoints(i).latitude) & "," &
                          img.Image(CDU.iface.NAV.status.waypoints(i).longitude) & ")"
                       );
               CDU.iface.CDU.status.action_success := True;
               if (i+1) in CDU.iface.NAV.status.waypoints'Range then
                  CDU.iface.NAV.status.waypoints(i+1).ID := 0;
               end if;
               exit;
            end if;
         end loop;
      end if;
   end NAV_add_waypoint;


   -------------------------------
   -- Step for the CDU function
   -------------------------------
   procedure step is
   begin
      -- indicators
      CDU.iface.CDU.status.AFDS_enabled_indicator := CDU.iface.AFDS.status.enabled;
      CDU.iface.CDU.status.GCAS_enabled_indicator := CDU.iface.GCAS.status.enabled;
      CDU.iface.CDU.status.NAV_enabled_indicator  := CDU.iface.NAV.status.enabled;

      -- action
      case CDU.iface.CDU.status.action is

         when COMIF.CDU.CDU_act_NONE =>
            CDU.iface.CDU.status.action_success := True;

         when COMIF.CDU.CDU_act_enable =>
            -- Enabling a function
            case CDU.iface.CDU.status.data.component is
               when Comp_AFDS =>
                  log.log (log.CDU, 1, 0, "CDU: Enabled AFDS");
                  CDU.iface.AFDS.status.enabled := True;
                  CDU.iface.CDU.status.action_success := True;

               when Comp_GCAS =>
                  log.log (log.CDU, 1, 0, "CDU: Enabled GCAS");
                  CDU.iface.GCAS.status.enabled := True;
                  CDU.iface.CDU.status.action_success := True;

               when Comp_NAV =>
                  -- Only enable NAV if at least one waypoint is programmed
                  if CDU.iface.NAV.status.waypoints(types.t_waypoints'First).ID /= 0 then
                     log.log (log.CDU, 1, 0, "CDU: Enabled NAV");
                     CDU.iface.NAV.status.enabled := True;
                     CDU.iface.NAV.status.current_waypoint_index := types.t_waypoints'First;
                     CDU.iface.CDU.status.action_success := True;
                  else
                     CDU.iface.CDU.status.action_success := False;
                  end if;
               when others =>
                  null;
            end case;

         when COMIF.CDU.CDU_act_disable =>
            -- Disabling a function
            case CDU.iface.CDU.status.data.component is
               when Comp_AFDS =>
                  log.log (log.CDU, 1, 0, "CDU: Disabled AFDS");
                  CDU.iface.AFDS.status.enabled := False;
                  CDU.iface.CDU.status.action_success := True;
               when Comp_GCAS =>
                  log.log (log.CDU, 1, 0, "CDU: Disabled GCAS");
                  CDU.iface.GCAS.status.enabled := False;
                  CDU.iface.CDU.status.action_success := True;
               when Comp_NAV =>
                  log.log (log.CDU, 1, 0, "CDU: Disabled NAV");
                  CDU.iface.NAV.status.enabled := False;
                  CDU.iface.NAV.status.current_waypoint_index := 0;
                  CDU.iface.CDU.status.action_success := True;
               when others =>
                  null;
            end case;

         when COMIF.CDU.CDU_clear_waypoints =>
            NAV_clear_waypoints;
            CDU.iface.CDU.status.action_success := True;

         when COMIF.CDU.CDU_add_waypoint =>
            NAV_add_waypoint;

         when COMIF.CDU.CDU_set_AFDS =>
            CDU.iface.AFDS.status.nav_target := CDU.iface.CDU.status.data.nav_target;
            CDU.iface.CDU.status.action_success := True;

      end case;

      CDU.iface.CDU.status.action := COMIF.CDU.CDU_act_NONE;

   end step;


end CDU.IMPL;

