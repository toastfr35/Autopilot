-------------------------------------------------------
-- Package COMIF.TMAP
--
-------------------------------------------------------

with HW;

package body COMIF.TMAP is

   COMIF_TMAP_status : t_TMAP_status := (0.0, 0.0, 0.0, False, (others=>null_request), null_response, (others => 0));

   for COMIF_TMAP_status'Address use HW.TMAP_status'Address;
   pragma Volatile (COMIF_TMAP_status);

   function read (component : t_component) return t_TMAP_status is
   begin
      pragma Assert (read_access (component, Comp_TMAP));
      return COMIF_TMAP_status;
   end read;

   procedure write (component : t_component; status : t_TMAP_status) is
   begin
      pragma Assert (write_access (component, Comp_TMAP));
      COMIF_TMAP_status := status;
   end write;

   procedure reset is
   begin
      COMIF_TMAP_status := (0.0, 0.0, 0.0, False, (others=>null_request), null_response, (others => 0));
   end reset;


end COMIF.TMAP;
