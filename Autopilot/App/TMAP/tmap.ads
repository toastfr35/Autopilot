-------------------------------------------------------
-- Package TMAP
--
-- Terrain Mapping
-------------------------------------------------------

package TMAP is

   procedure step
      with Import => True, Convention => C, External_Name => "TMAP_step";
   -- Step for the GPS function

   procedure reset
      with Import => True, Convention => C, External_Name => "TMAP_reset";
   -- Reset internal state

end TMAP;
