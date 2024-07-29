package plot is

   procedure open (id : Natural);

   procedure close;

   procedure step;

   procedure add_waypoint (lat, lon : Float);

end plot;
