# **ADR-0011** Platform-Specific Installation Solutions

**Author**: @pfouilloux

![Accepted](https://img.shields.io/badge/status-accepted-success) ![20 December 2024](https://img.shields.io/badge/Date-20_Dec_2024-lightblue)

## Context and Problem Statement

We need to provide streamlined installation solutions for non-technical users across different platforms.
The installation process must be GUI-based, dependency-free, and support platform-specific features like context menu integration.

## Decision Drivers

* GUI-based installation with no command line interaction
* Context menu command registration
* Support for Sigstore code signing
* CI/CD integration with platform-specific builds
* Clean uninstallation process
* No external dependencies for end users
* Cross-platform build tooling
* App Store integration capabilities
* Automatic updates
* Installation size optimization

### Platform-Specific Requirements

#### Windows
* MSI package format
* Context menu registration
* Start menu integration
* File association handling
* Windows Store compatibility

#### macOS
* DMG and pkg formats
* Context menu integration via Services
* Apple Silicon + Intel support
* Mac App Store compatibility
* Gatekeeper compliance

#### Linux
* Primary: DEB package for Debian/Ubuntu
* Secondary: RPM for Fedora/RHEL
* AppImage for universal support
* Context menu integration via desktop entries
* Package manager integration

## Considered Options

* Tauri + Platform-Specific Tools
* Electron Builder
* InstallShield
* Inno Setup
* AppImage

## Decision Outcome

Chosen option: "Tauri + Platform-Specific Tools", because this combination provides a consistent build environment across platforms while enabling platform-native installation experiences.

### Consequences

* Good, because it provides a consistent build environment across platforms
* Good, because it enables reproducible builds
* Good, because it supports automated CI/CD integration
* Good, because it delivers platform-native installation experience
* Good, because it offers app store compatibility

### Confirmation

Implementation will be confirmed through:
* Successful creation of installers for all target platforms
* Verification of platform-specific features (context menus, file associations)
* Successful submission to app stores where applicable
* CI/CD pipeline validation
* User testing of installation and uninstallation processes

## Pros and Cons of the Options

### Tauri + Platform-Specific Tools

This approach uses Tauri's bundler as the base, complemented by platform-specific tools.

* Good, because it provides a consistent build environment across platforms
* Good, because it enables reproducible builds
* Good, because it supports automated CI/CD integration
* Good, because it delivers platform-native installation experience
* Good, because it offers app store compatibility
* Bad, because it requires complex CI/CD setup with multiple platform-specific build steps
* Bad, because it faces different store compliance requirements per platform
* Bad, because it involves platform-specific implementation challenges for context menus
* Bad, because it may impact binary size due to multiple architecture support
* Bad, because update mechanisms have platform-specific constraints

### Electron Builder

A packaging and distribution tool for Electron applications.

* Good, because it has a mature ecosystem
* Good, because it has good cross-platform support
* Good, because it has store publishing support
* Good, because it has an auto-update system
* Good, because it has good documentation
* Bad, because it results in large installation size
* Bad, because it is resource intensive
* Bad, because it requires Electron dependency
* Bad, because it has complex configuration
* Bad, because it has limited native integration

### InstallShield

A commercial Windows installer development tool.

* Good, because it is an industry standard for Windows
* Good, because it has professional features
* Good, because it offers enterprise support
* Good, because it supports MSI/EXE formats
* Good, because it allows advanced customization
* Bad, because it is Windows only
* Bad, because it has expensive licensing
* Bad, because it involves complex workflows
* Bad, because it has limited automation
* Bad, because it lacks cross-platform support

### Inno Setup

A free script-driven installation system for Windows.

* Good, because it is free and open source
* Good, because it has simple configuration
* Good, because it has a small footprint
* Good, because it has good Windows integration
* Good, because it has an active community
* Bad, because it is Windows only
* Bad, because it has limited store support
* Bad, because it offers only basic features
* Bad, because it requires manual signing process
* Bad, because it lacks cross-platform support

### AppImage

A format for distributing portable software on Linux.

* Good, because it requires no installation
* Good, because it has universal Linux support
* Good, because it enables simple distribution
* Good, because it has version management
* Good, because it is self-contained
* Bad, because it is Linux only
* Bad, because it has limited system integration
* Bad, because it lacks store support
* Bad, because it has size overhead
* Bad, because it involves update complexity

## More Information

### Implementation Details

#### Base Bundle (Tauri)

- Core application packaging
- Basic resource bundling
- Update framework
- Cross-platform consistency

#### Windows Implementation

- WiX Toolset for MSI creation
- Context menu registration
- Start menu integration
- File association handling
- Windows Store compatibility
- Sigstore signing integration

#### macOS Implementation

- create-dmg for DMG creation
- pkgbuild for pkg installer
- Services integration for context menu
- Notarization workflow
- App Store submission process
- Universal binary support

#### Linux Implementation

- cargo-deb for DEB package creation
- cargo-generate-rpm for RPM package creation
- AppImage tooling
- Desktop integration
- Dependency handling
- Package manager integration

### Risks and Mitigations

#### Risks

- Complex CI/CD Setup: Multiple platform-specific build steps
- Store Compliance: Different requirements per store
- Context Menu: Platform-specific implementation challenges
- Binary Size: Multiple architecture support impact
- Update Mechanism: Platform-specific constraints

#### Mitigations

- Modular CI/CD pipeline design
- Comprehensive testing per platform
- Clear documentation
- Size optimization strategies
- Staged roll-outs
- Comprehensive error handling

### Linux Distribution Support

#### Primary Tier (Full Support)

- Debian/Ubuntu (DEB)
- Fedora/RHEL (RPM)
- Any distro via AppImage

#### Secondary Tier (Package Manager)

- Arch Linux (AUR)
- openSUSE
- Gentoo

### Platform-Specific Implementation Notes

#### Windows Store

- MSIX package creation
- Context menu via package manifest
- Store submission automation
- Update channel management

#### Mac App Store

- App sandboxing requirements
- Entitlements configuration
- Store review guidelines
- Update process handling

#### Linux Package Managers

- Repository setup
- Package maintenance
- Dependency handling
- Update distribution

### Related Decisions

- [ADR-0001: Primary Programming Language](adr-0001-primary-programming-language.md)
- [ADR-0009: Workspace Management](adr-0009-workspace-management.md)
- [ADR-0010: Code Signing Solution](adr-0010-code-signing.md)
