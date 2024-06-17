-------------------------------------------------------
-- Package COMIF
--
-------------------------------------------------------

with components;

package COMIF is

   procedure reset;

   type t_access_rights is array (components.t_component'Range) of Boolean;

end COMIF;
