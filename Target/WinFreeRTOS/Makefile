# =============================================================================
# Edit the following two lines if the tools have been installed in a different
# location on your system.
# =============================================================================
GNATTOOLSBIN?=/c/GNAT/24.1-x64/bin
PYTHON?=/c/Python312/python

# GNAT
GPRBUILD=$(GNATTOOLSBIN)/gprbuild
CXX=$(GNATTOOLSBIN)/g++


# Test files are found in
TESTDIR=../../Autopilot/Tests

# C++
AUTOPILOT_CPP_SRCS=$(shell find ../../Autopilot/App -type f -name '*.cpp')
AUTOPILOT_CPP_OBJS=$(AUTOPILOT_CPP_SRCS:.cpp=.o)
CPP_INCLUDE_FLAGS=-I ../../Autopilot/App/COMMON
CPP_CFLAGS=-O0 -g3 -Wall -Werror


WinFreeRTOS_internalFDM.exe: FreeRTOS/libfreertos.a cplusplus
	@$(GPRBUILD) -P WinFreeRTOS.gpr -j16
	@mv obj/main.exe $@

# Build C++ separately in obj/cpp_obj and generate CPP.ads to link it in
cplusplus :
	@mkdir -p obj/cpp_obj
	@echo "Compile C++"
	@echo "package CPP is " > CPP.ads
	@$(MAKE) -s $(AUTOPILOT_CPP_OBJS) -j16
	@cd obj/cpp_obj; ls *.o | sed 's/\(.*\)/   pragma Linker_Options ("cpp_obj\/\1");/' >> ../../CPP.ads
	@echo '   pragma Linker_Options ("-lstdc++");' >> CPP.ads
	@echo "end CPP;" >> CPP.ads
	@mv CPP.ads ../../Autopilot/BSPs/winFreeRTOS

%.o : %.cpp
	@echo "   [C++]          $<"
	@$(CXX) -c -nostdlib -o $@ $< $(CPP_CFLAGS) $(CPP_INCLUDE_FLAGS)
	@cp $@ obj/cpp_obj


# FreeRTOS
FreeRTOS/libfreertos.a : FreeRTOS/*.c
	@$(MAKE) -s -C FreeRTOS


run:
	./WinFreeRTOS_internalFDM.exe

plot:
	$(PYTHON) ../WinNative/plot.py *.csv

clean:
	rm -f test*.csv *.elf *.hex *.map *.dtxt ../../Autopilot/Tests/testlist.ads WinFreeRTOS_internalFDM.exe ../../Autopilot/BSPs/win/CPP.ads
	rm -rf obj $(AUTOPILOT_CPP_OBJS) ../../Autopilot/BSPs/winFreeRTOS/CPP.ads result_test_*
	$(MAKE) -C FreeRTOS clean
