
GRPBUILD=/c/GNAT/23.1-x64/bin/gprbuild

build_tests : clean prep_tests
	$(GRPBUILD) -Pwin_internalFDM.gpr -j1

build_notest :  prep_notest
	$(GRPBUILD) -Pwin_internalFDM.gpr -j1


prep_tests:
	@echo 'pragma Warnings (off);' >  Tests/testlist.ads
	@ls tests/test0*.ads | sed 's|tests/|with |' | sed 's|\.ads|;|' >> Tests/testlist.ads
	@echo 'package testlist is'    >> Tests/testlist.ads
	@echo 'end testlist;'          >> Tests/testlist.ads

prep_notest:
	@echo 'pragma Warnings (off);' >  Tests/testlist.ads
	@echo 'with notest;'           >>  Tests/testlist.ads
	@echo 'package testlist is'    >> Tests/testlist.ads
	@echo 'end testlist;'          >> Tests/testlist.ads


run : 
	./obj/main.exe


clean :
	@rm -rf obj Tests/testlist.ads *.csv
	@mkdir -p obj