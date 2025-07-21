# SoftEther VPN iOS Port

This document outlines the modifications made to enable SoftEther VPN compilation for iOS and the remaining challenges.

## Completed Modifications

### 1. iOS Build Configuration
- Created `makefiles/ios_arm64.mak` with iOS-specific compiler flags
- Added iOS SDK path detection and ARM64 architecture targeting
- Disabled problematic dependencies: readline, pcap, getifaddrs

### 2. Mayaqua Modifications
- Updated `Mayaqua.h` to recognize iOS platform (`UNIX_IOS`)
- Added conditional compilation for iOS-specific features
- Disabled getifaddrs support on iOS (not available in sandbox)
- Made readline dependency optional with `NO_READLINE` flag

### 3. Console Implementation
- Modified `Console.c` to work without readline library
- Added fallback implementation using standard fgets() for iOS
- Maintained compatibility with other Unix platforms

### 4. iOS-specific Files
- Created `iOS.c` and `iOS.h` for future iOS-specific implementations
- Prepared stubs for Network Extension framework integration

## Remaining Challenges

### 1. Network Extension Framework Integration
iOS apps cannot directly manipulate network interfaces or perform packet capture. VPN functionality requires:
- `NEPacketTunnelProvider` for VPN tunnel creation
- `NEVPNManager` for VPN configuration
- Proper entitlements in iOS app

### 2. Library Dependencies
Still need to resolve:
- **OpenSSL**: May need to compile for iOS or use system CommonCrypto
- **zlib**: Should work but may need iOS-specific compilation
- **pthread**: Available on iOS
- **iconv**: May need alternative or iOS-specific implementation

### 3. File System Access
iOS sandbox restrictions limit:
- File system access to app container
- Configuration file locations
- Log file writing permissions

### 4. System Call Restrictions
Many Unix system calls used by Mayaqua are restricted:
- Raw socket access
- Network interface enumeration
- System-level network configuration

## Next Steps for Complete iOS Port

### 1. Create iOS Framework
```bash
# Build as iOS framework instead of standalone binaries
xcodebuild -target SoftEtherVPN-iOS -configuration Release -arch arm64
```

### 2. Network Extension Integration
- Subclass `NEPacketTunnelProvider`
- Implement VPN protocol handling
- Bridge between SoftEther core and iOS VPN APIs

### 3. Dependency Resolution
- Compile OpenSSL for iOS
- Replace problematic Unix APIs with iOS alternatives
- Use iOS-native cryptography where possible

### 4. App Integration
- Create iOS app project
- Add Network Extension target
- Configure proper entitlements

## Build Instructions

1. **Prerequisites:**
   - Xcode with iOS SDK
   - macOS development machine

2. **Build Command:**
   ```bash
   cd src/
   ./build_ios.sh
   ```

3. **Expected Issues:**
   - Linking errors due to missing iOS libraries
   - Runtime crashes due to sandbox restrictions
   - VPN functionality requires iOS app context

## Alternative Approach: iOS App with Network Extension

For a production iOS VPN app, consider:
1. Use SoftEther protocol implementation
2. Integrate with `NEPacketTunnelProvider`
3. Create native iOS UI
4. Handle iOS-specific VPN management

This approach leverages SoftEther's protocol implementation while working within iOS constraints.

## Conclusion

The modifications made here address the basic compilation issues with Mayaqua dependencies. However, a complete iOS port requires significant additional work to integrate with iOS's Network Extension framework and handle platform-specific limitations.

For immediate testing, these changes should allow compilation, but the resulting binaries will need to be integrated into a proper iOS app structure to function correctly.
