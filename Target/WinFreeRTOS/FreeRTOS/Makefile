
CC=/c/GNAT/23.1-x64/bin/gcc
AR=/c/GNAT/23.1-x64/bin/ar
CFLAGS=
INCLUDES=-Iincludes

FREERTOSWIN_SRCS=\
	Run-time-stats-utils.c \
	croutine.c \
	event_groups.c \
	list.c \
	queue.c \
	stream_buffer.c \
	tasks.c \
	timers.c \
	heap_4.c \
	port.c \
	recmutex.c \
	start_tasks.c

FREERTOSWIN_OBJS=$(addprefix obj/,$(FREERTOSWIN_SRCS:.c=.o))

all :
	@echo "Compile FreeRTOS"
	@$(MAKE) -s build -j16

build : $(FREERTOSWIN_OBJS)
	@mkdir -p ../obj
	@rm -f ../obj/libfreertos.a
	$(AR) rcs ../obj/libfreertos.a $(FREERTOSWIN_OBJS)


obj/%.o : src/%.c
	@echo "   [C]            FreeRTOS/src/$<"
	@$(CC) -c $(CFLAGS) $(INCLUDES) -o $@ $<

obj/%.o : %.c
	@echo "   [C]            FreeRTOS/$<"
	@$(CC) -c $(CFLAGS) $(INCLUDES) -o $@ $<

clean :
	@rm -rf obj libfreertos.a
	@mkdir obj