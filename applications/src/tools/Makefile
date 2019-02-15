TOOLS=	espeakdsp dogfeed nxloadmon flkill flmessage nxlight \
	nx_bat_monitor_console nx_bat_monitor \
	power_button editor fonts flchoose

all: $(TOOLS)

install: $(TOOLS)
	cp $(TOOLS) $(TOMDIST)/bin

clean:
	rm -f $(TOOLS)

%: %.c
	$(CC) -g -ggdb -o $@ -I$(ROOT)/kernel/include $@.c -lnano-X

%: %.cxx
	$(CXX) -g -ggdb -o $@ $@.cxx -lfltk -lfltk_images
