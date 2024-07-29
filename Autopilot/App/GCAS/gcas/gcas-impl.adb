-------------------------------------------------------
-- Package GCAS.IMPL
--
-- Ground Collision Avoidance System
-- Detect potential collision with the ground
-------------------------------------------------------

with types; use types;

with GCAS.iface;

package body GCAS.IMPL is

   collision_altitude : constant t_altitude := 200.0;

   emergency_altitude : constant t_altitude := 600.0;

   recovery_altitude : constant t_altitude := 1500.0;

   stable_altitude : constant t_altitude := 1400.0;

   subtype t_stable_pitch is t_pitch range -0.2 .. 0.2;

   -------------------------------
   -- Reset internal state
   -------------------------------
   procedure reset is
   begin
      null;
   end reset;


   -------------------------------
   -- Predict ground collision
   -------------------------------
   function collision_predicted return Boolean is
      altitude        : constant t_altitude := GCAS.iface.GPS.data.altitude;
      vspeed          : constant t_vspeed := GCAS.iface.GPS.data.vspeed;
      hspeed_knots    : constant t_hspeed := GCAS.iface.GPS.data.hspeed;
      hspeed_mps      : constant t_hspeed := hspeed_knots * 0.514444;
      second_per_100m : constant float := 100.0 / float(hspeed_mps);
      t               : float := 0.0; -- time
      collision       : Boolean := False;
   begin
      --Put_Line ("GCAS: Alt=" & altitude'Img & "  VS=" & vspeed'Img & "   HS=" & hspeed_knots'Img & " knots    HS=" & hspeed_mps'Img & " m/s");

      -- use the elevation data (list) in front of the aircraft to detect
      -- potential ground collision

      if hspeed_mps < 10.0 then
         -- low speed check
         for ground_elevation of GCAS.iface.TMAP.data.elevation_profile loop
            if ground_elevation = 16#FFFF# then
               -- end marker of ground elevation list
               exit;
            end if;
            declare
               predicted_altitude : constant t_altitude := altitude + (5.0 * vspeed);
               predicted_altitude_above_ground : constant t_altitude := predicted_altitude - t_altitude(ground_elevation);
            begin
               if predicted_altitude_above_ground <= collision_altitude then
                  collision := True;
               end if;
            end;
         end loop;

      else
         -- normal speed check
         for ground_elevation of GCAS.iface.TMAP.data.elevation_profile loop
            if ground_elevation = 16#FFFF# then
               -- end marker of ground elevation list
               exit;
            end if;
            declare
               predicted_altitude : constant t_altitude := altitude + t_altitude (t * float(vspeed));
               predicted_altitude_above_ground : constant t_altitude := predicted_altitude - t_altitude(ground_elevation);
            begin
               if predicted_altitude_above_ground <= collision_altitude then
                  collision := True;
               end if;
               t := t + second_per_100m;
            end;
         end loop;
      end if;

      return collision;
   end collision_predicted;


   -------------------------------
   -- Update the state of the GCAS
   -------------------------------
   procedure update_GCAS_state is
   begin

      if not GCAS.iface.TMAP.data.valid then
         GCAS.iface.GCAS.data.GCAS_state := GCAS_state_disengaged;
         return;
      end if;

      if collision_predicted then

         -- emergency collision avoidance
         if GCAS.iface.GCAS.data.GCAS_state /= GCAS_state_emergency then
            GCAS.iface.GCAS.data.GCAS_state := GCAS_state_emergency;
         end if;

      else

         case GCAS.iface.GCAS.data.GCAS_state is

         when GCAS_state_emergency =>
            -- emergency -> recovery
            if GCAS.iface.GPS.data.vspeed > 5.0 and then GCAS.iface.GPS.data.altitude > emergency_altitude then
               GCAS.iface.GCAS.data.GCAS_state := GCAS_state_recovery;
            end if;

         when GCAS_state_recovery =>
            -- recovery -> stabilize
            if GCAS.iface.GPS.data.altitude > recovery_altitude then
               GCAS.iface.GCAS.data.GCAS_state := GCAS_state_stabilize;
            end if;

         when GCAS_state_stabilize =>
            -- stabilize -> disengaged
            if GCAS.iface.GPS.data.altitude > stable_altitude and then GCAS.iface.ACS.data.pitch in t_stable_pitch'Range then
               GCAS.iface.GCAS.data.GCAS_state := GCAS_state_disengaged;
            end if;

         when GCAS_state_disengaged =>
            null;

         end case;

      end if;


   end update_GCAS_state;


   -------------------------------
   -- Step for the auto-GCAS function
   -------------------------------
   procedure step is
   begin
      update_GCAS_state;
   end step;


end GCAS.IMPL;

