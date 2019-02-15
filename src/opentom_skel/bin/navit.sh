#! /bin/sh

export LANG=en_US.utf8
export TZ="CEDT-01:00:00CEST-02:00:00,M3.4.0,M10.4.0"

# Navit can use SiRFstar III GPS (device id 3; used in TT7xx) without gltt
# For GPS chips without NMEA output gltt is used
[ "$hw_gpstype" = 3 ] && ln -sf "/dev/$hw_gpsdev" /var/run/gpspipe || {
	[ -x "$DIST/bin/gltt" ] && [ -x "$DIST/bin/rc.gltt" ] && rc.gltt start && echo EnableRawGPSOutput >/dev/gps ||
	! echo "You need TomTom(tm) gltt\nPlease read documentation." | flmessage -s -t "Can't start Navit" || exit
}

NAVIT_SHAREDIR="$DIST/share/navit" navit -c "$DIST/share/navit/navit.xml" "$@" >"$DIST/logs/navit.log" 2>&1 &

sleep 1; while pidof navit >/dev/null 2>&1; do echo '\0' >/dev/watchdog; sleep 10; done
