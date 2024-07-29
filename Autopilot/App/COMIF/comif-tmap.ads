-------------------------------------------------------
-- Package COMIF.TMAP
--
-------------------------------------------------------

with System;
with Interfaces;
with components; use components;
with types;

package COMIF.TMAP is

   MAP_SIZE : constant Natural := 201;

   type t_ilatitude is new Interfaces.Integer_32;
   type t_ilongitude is new Interfaces.Integer_32;

   -------------------------------
   type t_map_request is record
      ilat1 : t_ilatitude;
      ilat2 : t_ilatitude;
      ilon1 : t_ilongitude;
      ilon2 : t_ilongitude;
      valid : Boolean;
   end record;
   for t_map_request use record
      ilat1 at 0  range 0 .. 31;
      ilat2 at 4  range 0 .. 31;
      ilon1 at 8 range 0 .. 31;
      ilon2 at 12 range 0 .. 31;
      valid at 16 range 0 .. 31;
   end record;

   type t_map_requests is array(1..64) of t_map_request;
   null_request : constant t_map_request := (0,0,0,0, False);


   -------------------------------
   type t_map_data is array(1..MAP_SIZE) of Interfaces.Unsigned_8;

   type t_map_response is record
      ilat1 : t_ilatitude;
      ilat2 : t_ilatitude;
      ilon1 : t_ilongitude;
      ilon2 : t_ilongitude;
      valid : Boolean;
      data  : t_map_data;
   end record;
   for t_map_response use record
      ilat1 at 0  range 0 .. 31;
      ilat2 at 4  range 0 .. 31;
      ilon1 at 8 range 0 .. 31;
      ilon2 at 12 range 0 .. 31;
      valid at 16 range 0 .. 31;
      data  at 20 range 0 .. 1607;
   end record;
   null_response : constant t_map_response := (0,0,0,0,False,(others=>0));


   type t_elevation_profile is array(1..(MAP_SIZE/2)) of types.t_elevation;

   -------------------------------
   -- Data types
   -------------------------------
   type t_TMAP_status is record
      latitude  : types.t_altitude;
      longitude : types.t_latitude;
      elevation : types.t_altitude;
      valid     : Boolean;

      -- queries
      requests  : t_map_requests;
      response  : t_map_response;

      -- elevation_profile
      elevation_profile : t_elevation_profile;
   end record;

   for t_TMAP_status use record
      latitude  at 0   range 0 .. 63;
      longitude at 8   range 0 .. 63;
      elevation at 16  range 0 .. 31;
      valid     at 20  range 0 .. 31;
      requests  at 24  range 0 .. 10239;
      response  at 1304 range 0 .. 1767;
      elevation_profile at 1528 range 0 .. 1599;
   end record;

   -------------------------------
   -- R/W access to data
   -------------------------------

   procedure reset;
   pragma Export (C, reset, "COMIF_TMAP_reset");

   function read (component : t_component) return t_TMAP_status;
   pragma Export (C, read, "COMIF_TMAP_read");

   procedure write (component : t_component; status : t_TMAP_status);
   pragma Export (C, write, "COMIF_TMAP_write");

end COMIF.TMAP;
