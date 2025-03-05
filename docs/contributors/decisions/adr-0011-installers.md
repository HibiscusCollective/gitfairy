# Platform-Specific Installation Solutions

## Status

- Status: Accepted
- Date: 20 December 2024
- Driver: @pfouilloux

## Context and problem statement

We need to provide streamlined installation solutions for non-technical users across different platforms.
The installation process must be GUI-based, dependency-free, and support platform-specific features like context menu integration.

### Requirements

#### Must Have

- GUI-based installation with no command line interaction
- Context menu command registration
- Support for Sigstore code signing
- CI/CD integration with platform-specific builds
- Clean uninstallation process
- No external dependencies for end users

#### Nice to Have

- Cross-platform build tooling
- App Store integration capabilities
- Automatic updates
- Installation size optimization
- Silent install options for enterprise

#### Platform-Specific Requirements

##### Windows

- MSI package format
- Context menu registration
- Start menu integration
- File association handling
- Windows Store compatibility

##### macOS

- DMG and pkg formats
- Context menu integration via Services
- Apple Silicon + Intel support
- Mac App Store compatibility
- Gatekeeper compliance

##### Linux

- Primary: DEB package for Debian/Ubuntu
- Secondary: RPM for Fedora/RHEL
- AppImage for universal support
- Context menu integration via desktop entries
- Package manager integration

## Decision outcomes

### Chosen Option: Tauri + Platform-Specific Tools

We will use Tauri's bundler as the base, complemented by platform-specific tools:

#### Benefits

- Consistent build environment across platforms
- Reproducible builds
- Automated CI/CD integration
- Platform-native installation experience
- App store compatibility

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

## Related Decisions

- [ADR 0001: Primary Programming Language](adr-0001-primary-programming-language.md)
- [ADR 0009: Workspace Management](adr-0009-workspace-management.md)
- [ADR 0016: Security Architecture](adr-0016-security-architecture.md)

## Other options considered

### [Electron Builder](https://www.electron.build/)

#### Pros

- Mature ecosystem
- Good cross-platform support
- Store publishing support
- Auto-update system
- Good documentation

#### Cons

- Large installation size
- Resource intensive
- Electron dependency
- Complex configuration
- Limited native integration

### [InstallShield](https://www.revenera.com/install/products/installshield)

#### Pros

- Industry standard for Windows
- Professional features
- Enterprise support
- MSI/EXE formats
- Advanced customization

#### Cons

- Windows only
- Expensive licensing
- Complex workflows
- Limited automation
- No cross-platform support

### [Inno Setup](https://jrsoftware.org/isinfo.php)

#### Pros

- Free and open source
- Simple configuration
- Small footprint
- Good Windows integration
- Active community

#### Cons

- Windows only
- Limited store support
- Basic features
- Manual signing process
- No cross-platform support

### [AppImage](https://appimage.org/)

#### Pros

- No installation needed
- Universal Linux support
- Simple distribution
- Version management
- Self-contained

#### Cons

- Linux only
- Limited system integration
- No store support
- Size overhead
- Update complexity

## Linux Distribution Support

### Primary Tier (Full Support)

- Debian/Ubuntu (DEB)
- Fedora/RHEL (RPM)
- Any distro via AppImage

### Secondary Tier (Package Manager)

- Arch Linux (AUR)
- openSUSE
- Gentoo

### Implementation Notes

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
