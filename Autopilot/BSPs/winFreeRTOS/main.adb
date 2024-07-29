with AFDS;
with GCAS;
with NAV;
with CDU;
with COMIF;
with CPP; -- C++ code

with SysTest; -- For system tests

procedure main is

   pragma Linker_Options ("-lfreertos");
   pragma Linker_Options ("-lwinmm");
   procedure FreeRTOS_start;
   pragma Import (C, FreeRTOS_start, "FreeRTOS_start");

begin
   FreeRTOS_start;
end main;
