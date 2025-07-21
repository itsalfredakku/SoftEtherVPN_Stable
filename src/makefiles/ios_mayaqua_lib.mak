# iOS ARM64 Mayaqua static library Makefile for SoftEther VPN
# This builds just the Mayaqua kernel as a static library

# iOS SDK Detection
IOS_SDK_PATH := $(shell xcrun --show-sdk-path --sdk iphoneos 2>/dev/null)
ifeq ($(IOS_SDK_PATH),)
$(error iOS SDK not found. Make sure Xcode is installed.)
endif

# Compiler and flags
CC = clang
AR = ar
OPTIONS_COMPILE = -DNDEBUG -DVPN_SPEED -DUNIX -DUNIX_IOS -DCPU_64 -D_REENTRANT -DREENTRANT -D_THREAD_SAFE -D_THREADSAFE -DTHREAD_SAFE -DTHREADSAFE -D_FILE_OFFSET_BITS=64 -I. -I./Mayaqua/ -O2 -fsigned-char -arch arm64 -isysroot $(IOS_SDK_PATH) -miphoneos-version-min=12.0 -DNO_READLINE -DNO_PCAP -DNO_GETIFADDRS -DVPN_CLIENT_ONLY -DNO_OPENSSL

# Header dependencies
HEADERS_MAYAQUA = Mayaqua/Mayaqua.h Mayaqua/MayaType.h

# Object files lists (Mayaqua core only)
OBJECTS_MAYAQUA = tmp/objs/Mayaqua/Cfg.o tmp/objs/Mayaqua/FileIO.o tmp/objs/Mayaqua/Internat.o tmp/objs/Mayaqua/Kernel.o tmp/objs/Mayaqua/Mayaqua.o tmp/objs/Mayaqua/Memory.o tmp/objs/Mayaqua/Microsoft.o tmp/objs/Mayaqua/Object.o tmp/objs/Mayaqua/OS.o tmp/objs/Mayaqua/Pack.o tmp/objs/Mayaqua/Str.o tmp/objs/Mayaqua/Table.o tmp/objs/Mayaqua/TcpIp.o tmp/objs/Mayaqua/Tick64.o tmp/objs/Mayaqua/Tracking.o tmp/objs/Mayaqua/Unix.o tmp/objs/Mayaqua/Win32.o

# Main targets
all: bin/libmayaqua_ios.a

# Directory creation
directories:
	mkdir -p tmp/objs/Mayaqua
	mkdir -p bin

# Mayaqua Library Code
tmp/objs/Mayaqua/Cfg.o: Mayaqua/Cfg.c $(HEADERS_MAYAQUA) | directories
	$(CC) $(OPTIONS_COMPILE) -c Mayaqua/Cfg.c -o tmp/objs/Mayaqua/Cfg.o

tmp/objs/Mayaqua/FileIO.o: Mayaqua/FileIO.c $(HEADERS_MAYAQUA) | directories
	$(CC) $(OPTIONS_COMPILE) -c Mayaqua/FileIO.c -o tmp/objs/Mayaqua/FileIO.o

tmp/objs/Mayaqua/Internat.o: Mayaqua/Internat.c $(HEADERS_MAYAQUA) | directories
	$(CC) $(OPTIONS_COMPILE) -c Mayaqua/Internat.c -o tmp/objs/Mayaqua/Internat.o

tmp/objs/Mayaqua/Kernel.o: Mayaqua/Kernel.c $(HEADERS_MAYAQUA) | directories
	$(CC) $(OPTIONS_COMPILE) -c Mayaqua/Kernel.c -o tmp/objs/Mayaqua/Kernel.o

tmp/objs/Mayaqua/Mayaqua.o: Mayaqua/Mayaqua.c $(HEADERS_MAYAQUA) | directories
	$(CC) $(OPTIONS_COMPILE) -c Mayaqua/Mayaqua.c -o tmp/objs/Mayaqua/Mayaqua.o

tmp/objs/Mayaqua/Memory.o: Mayaqua/Memory.c $(HEADERS_MAYAQUA) | directories
	$(CC) $(OPTIONS_COMPILE) -c Mayaqua/Memory.c -o tmp/objs/Mayaqua/Memory.o

tmp/objs/Mayaqua/Microsoft.o: Mayaqua/Microsoft.c $(HEADERS_MAYAQUA) | directories
	$(CC) $(OPTIONS_COMPILE) -c Mayaqua/Microsoft.c -o tmp/objs/Mayaqua/Microsoft.o

tmp/objs/Mayaqua/Object.o: Mayaqua/Object.c $(HEADERS_MAYAQUA) | directories
	$(CC) $(OPTIONS_COMPILE) -c Mayaqua/Object.c -o tmp/objs/Mayaqua/Object.o

tmp/objs/Mayaqua/OS.o: Mayaqua/OS.c $(HEADERS_MAYAQUA) | directories
	$(CC) $(OPTIONS_COMPILE) -c Mayaqua/OS.c -o tmp/objs/Mayaqua/OS.o

tmp/objs/Mayaqua/Pack.o: Mayaqua/Pack.c $(HEADERS_MAYAQUA) | directories
	$(CC) $(OPTIONS_COMPILE) -c Mayaqua/Pack.c -o tmp/objs/Mayaqua/Pack.o

tmp/objs/Mayaqua/Str.o: Mayaqua/Str.c $(HEADERS_MAYAQUA) | directories
	$(CC) $(OPTIONS_COMPILE) -c Mayaqua/Str.c -o tmp/objs/Mayaqua/Str.o

tmp/objs/Mayaqua/Table.o: Mayaqua/Table.c $(HEADERS_MAYAQUA) | directories
	$(CC) $(OPTIONS_COMPILE) -c Mayaqua/Table.c -o tmp/objs/Mayaqua/Table.o

tmp/objs/Mayaqua/TcpIp.o: Mayaqua/TcpIp.c $(HEADERS_MAYAQUA) | directories
	$(CC) $(OPTIONS_COMPILE) -c Mayaqua/TcpIp.c -o tmp/objs/Mayaqua/TcpIp.o

tmp/objs/Mayaqua/Tick64.o: Mayaqua/Tick64.c $(HEADERS_MAYAQUA) | directories
	$(CC) $(OPTIONS_COMPILE) -c Mayaqua/Tick64.c -o tmp/objs/Mayaqua/Tick64.o

tmp/objs/Mayaqua/Tracking.o: Mayaqua/Tracking.c $(HEADERS_MAYAQUA) | directories
	$(CC) $(OPTIONS_COMPILE) -c Mayaqua/Tracking.c -o tmp/objs/Mayaqua/Tracking.o

tmp/objs/Mayaqua/Unix.o: Mayaqua/Unix.c $(HEADERS_MAYAQUA) | directories
	$(CC) $(OPTIONS_COMPILE) -c Mayaqua/Unix.c -o tmp/objs/Mayaqua/Unix.o

tmp/objs/Mayaqua/Win32.o: Mayaqua/Win32.c $(HEADERS_MAYAQUA) | directories
	$(CC) $(OPTIONS_COMPILE) -c Mayaqua/Win32.c -o tmp/objs/Mayaqua/Win32.o

# Create static library
bin/libmayaqua_ios.a: $(OBJECTS_MAYAQUA) | directories
	$(AR) rcs bin/libmayaqua_ios.a $(OBJECTS_MAYAQUA)
	@echo "iOS Mayaqua static library created: bin/libmayaqua_ios.a"
	@echo "This library can be linked into iOS apps that need SoftEther VPN functionality"

# Clean
clean:
	rm -rf tmp/objs
	rm -rf bin/libmayaqua_ios.a

# Help
help:
	@echo "SoftEther VPN Mayaqua Library for iOS ARM64"
	@echo ""
	@echo "Usage:"
	@echo "  make -f makefiles/ios_mayaqua_lib.mak          - Build Mayaqua static library"
	@echo "  make -f makefiles/ios_mayaqua_lib.mak clean    - Clean build files"
	@echo "  make -f makefiles/ios_mayaqua_lib.mak help     - Show this help"
	@echo ""
	@echo "Output:"
	@echo "  bin/libmayaqua_ios.a - iOS ARM64 static library"

.PHONY: all clean help directories
