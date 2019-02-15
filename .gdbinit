# opentom local gdb initialization
set sysroot arm-sysroot
set solib-search-path arm-sysroot/usr/lib:arm-sysroot/lib:gcc-3.3.4_glibc-2.3.2/arm-linux/lib
define ttt
	target remote 192.168.145.1:2000
	dont-repeat
end
document ttt
	Connect to TomTom remote target
end
