-------------------------------------------------------
-- Package CDU
--
-- Control Display Unit
-- Enabled/Disable AFDS, NAV, GCAS
-- Edit waypoints
-------------------------------------------------------

with COMIF.CDU;
with CDU.iface;

with components; use components;
with types;
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
      CDU.iface.NAV.data.waypoints(types.t_waypoints'First) := (0.0, 0.0, 0.0, 0.0, 0, 0);
      CDU.iface.NAV.data.current_waypoint_index := 0;
   end NAV_clear_waypoints;


   -------------------------------
   -- Add a waypoint to the list
   -------------------------------
   procedure NAV_add_waypoint is
   begin
      CDU.iface.CDU.data.action_success := False;
      if CDU.iface.CDU.data.action_data.waypoint.ID /= 0 then
         for i in CDU.iface.NAV.data.waypoints'Range loop
            if CDU.iface.NAV.data.waypoints(i).ID = 0 then
               CDU.iface.NAV.data.waypoints(i) := CDU.iface.CDU.data.action_data.waypoint;
               CDU.iface.CDU.data.action_success := True;
               if (i+1) in CDU.iface.NAV.data.waypoints'Range then
                  CDU.iface.NAV.data.waypoints(i+1).ID := 0;
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
      CDU.iface.CDU.data.AFDS_enabled_indicator := CDU.iface.AFDS.data.enabled;
      CDU.iface.CDU.data.GCAS_enabled_indicator := CDU.iface.GCAS.data.enabled;
      CDU.iface.CDU.data.NAV_enabled_indicator  := CDU.iface.NAV.data.enabled;

      -- action
      case CDU.iface.CDU.data.action is

         when COMIF.CDU.CDU_act_NONE =>
            CDU.iface.CDU.data.action_success := True;

         when COMIF.CDU.CDU_act_enable =>
            -- Enabling a function
            case CDU.iface.CDU.data.action_data.component is
               when Comp_AFDS =>
                  CDU.iface.AFDS.data.enabled := True;
                  CDU.iface.CDU.data.action_success := True;

               when Comp_GCAS =>
                  CDU.iface.GCAS.data.enabled := True;
                  CDU.iface.CDU.data.action_success := True;

               when Comp_NAV =>
                  -- Only enable NAV if at least one waypoint is programmed
                  if CDU.iface.NAV.data.waypoints(types.t_waypoints'First).ID /= 0 then
                     CDU.iface.NAV.data.enabled := True;
                     CDU.iface.NAV.data.current_waypoint_index := types.t_waypoints'First;
                     CDU.iface.CDU.data.action_success := True;
                  else
                     CDU.iface.CDU.data.action_success := False;
                  end if;
               when others =>
                  null;
            end case;

         when COMIF.CDU.CDU_act_disable =>
            -- Disabling a function
            case CDU.iface.CDU.data.action_data.component is
               when Comp_AFDS =>
                  CDU.iface.AFDS.data.enabled := False;
                  CDU.iface.CDU.data.action_success := True;
               when Comp_GCAS =>
                  CDU.iface.GCAS.data.enabled := False;
                  CDU.iface.CDU.data.action_success := True;
               when Comp_NAV =>
                  CDU.iface.NAV.data.enabled := False;
                  CDU.iface.NAV.data.current_waypoint_index := 0;
                  CDU.iface.CDU.data.action_success := True;
               when others =>
                  null;
            end case;

         when COMIF.CDU.CDU_clear_waypoints =>
            NAV_clear_waypoints;
            CDU.iface.CDU.data.action_success := True;

         when COMIF.CDU.CDU_add_waypoint =>
            NAV_add_waypoint;

         when COMIF.CDU.CDU_set_AFDS =>
            CDU.iface.AFDS.data.nav_target := CDU.iface.CDU.data.action_data.nav_target;
            CDU.iface.CDU.data.action_success := True;

      end case;

      CDU.iface.CDU.data.action := COMIF.CDU.CDU_act_NONE;

   end step;


end CDU.IMPL;

