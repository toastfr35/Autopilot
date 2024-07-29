

# List targets

TARGETS=$(sort $(dir $(wildcard Target/*/)))
TARGETS:=$(TARGETS:Target/%=%)
TARGETS:=$(TARGETS:%/=%)

#---------------------------
# Build all targets

TARGET_BUILDS=$(addsuffix .build,$(TARGETS))

all : $(TARGET_BUILDS)

%.build :
	@echo "Building $*"
	@$(MAKE) -s -C Target/$* clean
	@($(MAKE) -s -C Target/$* -j 16 > log.$* 2>&1 && rm log.$*) || (cat log.$* ; rm log.$* ; exit 1)
	@echo "Building $* OK"


#---------------------------
# Clean all targets

TARGET_CLEANS=$(addsuffix .clean,$(TARGETS))

clean : $(TARGET_CLEANS)

%.clean :
	@echo "Cleaning $*"
	@$(MAKE) -s -C Target/$* clean
