with tests;
with FDM;
with IFACE.NAV;

package body test006 is

   -- Test AFDS + NAV

   procedure add_waypoint (latitude, longitude, altitude : Float);
   pragma Import (C, add_waypoint, "add_waypoint");

   pragma Warnings(off);
   function get_current_waypoint_index (success : out Boolean) return Natural;
   pragma Import (C, get_current_waypoint_index, "get_current_waypoint_index");
   pragma Warnings(on);

   procedure test006 is
      success : Boolean;
      waypoint : Natural;
   begin

      tests.configure ("NAV + AFDS", AFDS => True, GCAS => False, NAV => True);

      -- set aircraft initial state
      FDM.set (latitude => 0.0,
               longitude => 0.0,
               altitude => 4000.0,
               heading => 0.0,
               velocity => 300.0
              );

      -- set AFDS configuration
      IFACE.NAV.set_heading (0.0);
      IFACE.NAV.set_altitude (4000.0);
      IFACE.NAV.set_velocity (300.0);

      -- add a few waypoints
      add_waypoint (0.0,0.1,4000.0);   -- Waypoint 1
      add_waypoint (0.1,0.1,4000.0);   -- Waypoint 2
      add_waypoint (0.2,0.1,4000.0);   -- Waypoint 3
      add_waypoint (0.1,0.2,4000.0);   -- Waypoint 4
      add_waypoint (0.0,0.0,4000.0);   -- Waypoint 5
      add_waypoint (1.0,1.0,4000.0);   --

      declare

         procedure check_waypoint (idx : Natural) is
         begin
            for i in 1 .. 20_000 loop
               tests.run_steps (1);
               waypoint := get_current_waypoint_index(success);
               exit when not success;
               exit when waypoint /= (idx-1);
            end loop;
            tests.check ("Waypoint"& idx'Img & " reached", waypoint = idx);
         end check_waypoint;

      begin
         for i in 1 .. 5 loop
            check_waypoint(i);
         end loop;
      end;

   end test006;


begin
   tests.register_test (test006'Access);
end test006;
