# ADR 0009 - Workspace Management

## Status

- Status: Accepted
- Date: 20 December 2024
- Driver: @pfouilloux

## Context and problem statement

We need a workspace management solution that is cross-platform, reproducible, and easy to use.
The solution must work reliably on Windows, macOS, and Linux, while supporting our Rust-based development environment and installer creation needs.

### Requirements

#### Must Have

- Cross-platform compatibility (Windows, macOS, Linux)
- Reproducible builds and development environments
- Support for Rust toolchain management
- Integration with platform-specific installer tools (WiX, pkgbuild, etc.)
- CI/CD environment reproducibility
- Fast environment setup for new developers
- Minimal manual configuration required
- Support for platform-specific signing tools

#### Nice to Have

- IDE integration
- Caching of build artifacts
- Environment isolation
- Automatic dependency management
- Development container support
- Cloud development environment support

## Decision outcomes

### Chosen Option: Pixi + Task + Dagger

**Rationale**: This combination provides cross-platform compatibility, reproducible environments, and CI/CD pipeline reproducibility while maintaining simplicity.

#### Benefits

- Cross-platform support through Pixi
- Task runner for consistent commands
- Dagger for CI/CD reproducibility
- No system-level package manager requirements
- Works well with Windows development environments
- Integrates with existing tooling choices

### Implementation Details

#### Development Environment

- Use Pixi for environment management:
  - Define dependencies in `pixi.toml`
  - Include Rust toolchain
  - Platform-specific build tools
  - Development dependencies

- Task runner configuration:
  - Build commands
  - Test runners
  - Linting and formatting
  - Platform-specific tasks

#### CI/CD Pipeline

- Dagger pipeline configuration:
  - Build environment setup
  - Cross-platform compilation
  - Installer creation
  - Code signing
  - Testing and validation

#### Platform-Specific Setup

##### Windows

- WiX toolset integration through direct installation
- Visual Studio Build Tools management
- Code signing tools

##### macOS

- XCode command line tools
- pkgbuild and productbuild
- Notarization tools

##### Linux

- Standard build tools
- Debian packaging utilities
- AppImage creation tools

### Risks and Mitigations

#### Risks

- Platform-specific tool availability
- Build reproducibility across environments
- CI/CD environment consistency
- Learning curve for new developers
- Limited IDE integration

#### Mitigations

- Comprehensive documentation
- CI/CD validation of builds
- Automated environment setup
- Platform-specific test matrices
- IDE configuration templates

## Related Decisions

- [D0001: Primary Programming Language](adr-0001-primary-programming-language.md)
- [D0002: Linting and Formatting Tools](adr-0002-linting-and-formatting-tools.md)
- [D0008: Package Management and Documentation](adr-0008-package-management-and-documentation.md)
- [D0011: Installers](adr-0011-installers.md)

## Other options considered

### Nix

#### Pros

- Reproducible builds
- Declarative configuration
- Large package ecosystem
- Good caching

#### Cons

- Limited Windows support
- Complex learning curve
- Poor IDE integration
- Challenging WiX integration
- System-level changes required

### DevContainers

#### Pros

- Good IDE integration
- Platform independence
- Reproducible environments
- Easy onboarding

#### Cons

- Windows performance issues
- Resource intensive
- Docker requirement
- Limited offline support
- Complex multi-platform builds

### direnv + asdf

#### Pros

- Simple configuration
- Language version management
- Shell integration
- Lightweight

#### Cons

- Limited Windows support
- Manual tool installation
- No build reproducibility
- Redundant with Pixi
- Poor IDE integration

### Dagger (standalone)

#### Pros

- CI/CD reproducibility
- Container-based builds
- Cross-platform support
- Good caching
- Modern architecture

#### Cons

- Learning curve
- Limited local development features
- Container overhead
- New technology
- Documentation gaps
