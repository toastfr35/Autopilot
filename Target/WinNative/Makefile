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
TESTDIR=../../Autopilot/Tests/Components/Tests

# C++
AUTOPILOT_CPP_SRCS=$(shell find ../../Autopilot/App -type f -name '*.cpp') $(shell find ../../Autopilot/Tests -type f -name '*.cpp')
AUTOPILOT_CPP_OBJS=$(AUTOPILOT_CPP_SRCS:.cpp=.o)
CPP_INCLUDE_FLAGS=-I ../../Autopilot/App/COMMON
CPP_CFLAGS=-O0 -g3 -Wall


WinNative_internalFDM.exe: cplusplus $(TESTDIR)/testlist.ads
	@$(GPRBUILD) -P WinNative.gpr -j16
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
	@mv CPP.ads ../../Autopilot/BSPs/win

%.o : %.cpp
	@echo "   [C++]          $<"
	@$(CXX) -c -nostdlib -o $@ $< $(CPP_CFLAGS) $(CPP_INCLUDE_FLAGS)
	@cp $@ obj/cpp_obj



# Generate the list of tests to link in (and execute)
$(TESTDIR)/testlist.ads:
	@echo 'pragma Warnings (off);' >  $(TESTDIR)/testlist.ads
	@ls $(TESTDIR)/test0*.ads | sed 's|.*/Tests/|with |' | sed 's|\.ads|;|' >> $(TESTDIR)/testlist.ads
	@echo 'package testlist is'    >> $(TESTDIR)/testlist.ads
	@echo 'end testlist;'          >> $(TESTDIR)/testlist.ads

run:
	./WinNative_internalFDM.exe

plot:
	$(PYTHON) plot.py *.csv

clean:
	rm -f *.elf *.hex *.map *.dtxt ../../Autopilot/Tests/testlist.ads WinNative_internalFDM.exe ../../Autopilot/BSPs/win/CPP.ads
	rm -rf obj *.csv result_test_* $(AUTOPILOT_CPP_OBJS) $(TESTDIR)/testlist.ads
