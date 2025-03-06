# **ADR-0009** Workspace Management

**Author**: @pfouilloux

![Accepted](https://img.shields.io/badge/status-accepted-success) ![20 December 2024](https://img.shields.io/badge/Date-20_Dec_2024-lightblue)

## Context and Problem Statement

We need a workspace management solution that is cross-platform, reproducible, and easy to use.
The solution must work reliably on Windows, macOS, and Linux, while supporting our Rust-based development environment and installer creation needs.

## Decision Drivers

* Cross-platform compatibility (Windows, macOS, Linux)
* Reproducible builds and development environments
* Support for Rust toolchain management
* Integration with platform-specific installer tools (WiX, pkgbuild, etc.)
* CI/CD environment reproducibility
* Fast environment setup for new developers
* Minimal manual configuration required
* Support for platform-specific signing tools

Additional desired features:

* IDE integration
* Caching of build artifacts
* Environment isolation
* Automatic dependency management
* Development container support
* Cloud development environment support

## Considered Options

* Mise-en-place + Dagger
* Nix
* DevContainers
* direnv + asdf
* Dagger (standalone)

## Decision Outcome

Chosen option: "Mise-en-place + Dagger", because this combination provides cross-platform compatibility, reproducible environments, and CI/CD pipeline reproducibility while maintaining simplicity.

### Consequences

* Good, because cross-platform support is achieved through mise-en-place
* Good, because mise-en-place provides consistent commands and task running
* Good, because Dagger enables CI/CD reproducibility
* Good, because no system-level package manager requirements
* Good, because it works well with Windows development environments
* Good, because it integrates with existing tooling choices

### Confirmation

Implementation will be confirmed through:

* Successful setup of development environments across all target platforms
* CI/CD pipeline validation
* Automated environment setup testing
* Cross-platform build verification

## Pros and Cons of the Options

### Mise-en-place + Dagger

This combination uses Mise-en-place for environment management and task running, and Dagger for CI/CD reproducibility.

* Good, because cross-platform support through Mise-en-place
* Good, because Mise-en-place provides consistent commands and task running
* Good, because Dagger enables CI/CD reproducibility
* Good, because no system-level package manager requirements
* Good, because it works well with Windows development environments
* Good, because it integrates with existing tooling choices

### Nix

A purely functional package manager that enables reproducible builds.

* Good, because it provides reproducible builds
* Good, because it has declarative configuration
* Good, because it has a large package ecosystem
* Good, because it has good caching
* Bad, because it has limited Windows support
* Bad, because it has a complex learning curve
* Bad, because it has poor IDE integration
* Bad, because it has challenging WiX integration
* Bad, because it requires system-level changes

### DevContainers

Container-based development environments that can be integrated with IDEs.

* Good, because it has good IDE integration
* Good, because it provides platform independence
* Good, because it enables reproducible environments
* Good, because it allows easy onboarding
* Bad, because of Windows performance issues
* Bad, because it is resource intensive
* Bad, because it requires Docker
* Bad, because it has limited offline support
* Bad, because it makes multi-platform builds complex

### direnv + asdf

A combination of environment variable management and version management tools.

* Good, because it has simple configuration
* Good, because it provides language version management
* Good, because it has shell integration
* Good, because it is lightweight
* Bad, because it has limited Windows support
* Bad, because it requires manual tool installation
* Bad, because it lacks build reproducibility
* Bad, because it is redundant with Mise-en-place
* Bad, because it has poor IDE integration

### Dagger (standalone)

A programmable CI/CD engine that runs pipelines in containers.

* Good, because it provides CI/CD reproducibility
* Good, because it uses container-based builds
* Good, because it has cross-platform support
* Good, because it has good caching
* Good, because it has a modern architecture
* Bad, because it has a learning curve
* Bad, because it has limited local development features
* Bad, because it has container overhead
* Bad, because it is a new technology
* Bad, because it has documentation gaps

## More Information

### Implementation Details

#### Development Environment

* Use Mise-en-place for environment management:
  * Define dependencies in `.mise.toml`
  * Include Rust toolchain
  * Platform-specific build tools
  * Development dependencies
  * Task running configuration
  * Build commands
  * Test runners
  * Linting and formatting
  * Platform-specific tasks

#### CI/CD Pipeline

* Dagger pipeline configuration:
  * Build environment setup
  * Cross-platform compilation
  * Installer creation
  * Code signing
  * Testing and validation

#### Platform-Specific Setup

##### Windows

* WiX toolset integration through direct installation
* Visual Studio Build Tools management
* Code signing tools

##### macOS

* XCode command line tools
* pkgbuild and productbuild
* Notarization tools

##### Linux

* Standard build tools
* Debian packaging utilities
* AppImage creation tools

### Risks and Mitigations

#### Risks

* Platform-specific tool availability
* Build reproducibility across environments
* CI/CD environment consistency
* Learning curve for new developers
* Limited IDE integration

#### Mitigations

* Comprehensive documentation
* CI/CD validation of builds
* Automated environment setup
* Platform-specific test matrices
* IDE configuration templates

### Related Decisions

* [ADR-0001: Primary Programming Language](adr-0001-primary-programming-language.md)
* [ADR-0002: Linting and Formatting Tools](adr-0002-linting-and-formatting-tools.md)
* [ADR-0008: Package Management and Documentation](adr-0008-package-management-and-documentation.md)
* [ADR-0011: Installers](adr-0011-installers.md)
