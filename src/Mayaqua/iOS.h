// SoftEther VPN Source Code - Stable Edition Repository
// Mayaqua Kernel
// 
// iOS-specific header file

#ifdef OS_IOS

#ifndef IOS_H
#define IOS_H

// Function prototypes for iOS-specific implementations
bool GetNetworkInterfaces_iOS(LIST *interfaces);
bool InitPacketCapture_iOS();
bool CreateTunTap_iOS(char *device_name);

#endif // IOS_H

#endif // OS_IOS
