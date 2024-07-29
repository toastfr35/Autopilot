-------------------------------------------------------
-- Package COMIF.CDU
--
-------------------------------------------------------

with components; use components;
with types;

package COMIF.CDU is

   -------------------------------
   -- Data types
   -------------------------------

   type t_CDU_action is (CDU_act_NONE, CDU_act_enable, CDU_act_disable, CDU_clear_waypoints, CDU_add_waypoint, CDU_set_AFDS);

   type t_CDU_action_data is record
      component : t_component;
      nav_target : types.t_nav_target;
      waypoint : types.t_waypoint;
   end record;
   for t_CDU_action_data use record
      component       at  0 range 0 .. 31;
      nav_target      at  4 range 0 .. 95;
      waypoint        at  16 range 0 .. 255;
   end record;

   null_action_data : constant t_CDU_action_data := (Comp_TEST, (0.0, 0.0, 0.0), (0.0, 0.0, 0.0, 0.0, 0, 0));

   type t_CDU_status is record
      AFDS_enabled_indicator : types.t_Bool32;
      GCAS_enabled_indicator : types.t_Bool32;
      NAV_enabled_indicator  : types.t_Bool32;
      action : t_CDU_action;
      action_success : Boolean;
      action_data : t_CDU_action_data;
   end record;
   for t_CDU_status use record
      AFDS_enabled_indicator at  0 range 0 .. 31;
      GCAS_enabled_indicator at  4 range 0 .. 31;
      NAV_enabled_indicator  at  8 range 0 .. 31;
      action                 at 12 range 0 .. 31;
      action_success         at 16 range 0 .. 31;
      action_data            at 20 range 0 .. 383;
   end record;


   -------------------------------
   -- R/W access to data
   -------------------------------

   procedure reset;

   function read (component : t_component) return t_CDU_status;

   procedure write (component : t_component; status : t_CDU_status);

end COMIF.CDU;
