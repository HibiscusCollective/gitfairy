# **ADR-0013** Testing Strategy

**Author**: @pfouilloux

![Proposed](https://img.shields.io/badge/status-proposed-yellow) ![20 December 2024](https://img.shields.io/badge/Date-20_Dec_2024-lightblue)

## Context and Problem Statement

We need a comprehensive testing strategy that ensures reliability across all platforms, with special focus on context menu integration and installer functionality.
The strategy must be efficient, maintainable, and provide high confidence in cross-platform compatibility.

## Decision Drivers

* Cross-platform test execution
* Context menu integration testing
* Installer/uninstaller validation
* Local development testing capability
* CI/CD integration
* Realistic service mocking
* Platform-specific behavior validation
* Parallel test execution
* Visual regression testing
* Performance benchmarking
* Test environment cleanup
* Automated test generation
* Coverage reporting

## Considered Options

* Native Rust Tools for Unit Testing + TestContainers/Docker for Integration + Playwright for E2E + Windows HLK/QEMU for Installer Testing
* Selenium WebDriver
* Windows UI Automation + AppleScript + xdotool
* Virtual Machine Testing

## Decision Outcome

Chosen option: "Native Rust Tools for Unit Testing + TestContainers/Docker for Integration + Playwright for E2E + Windows HLK/QEMU for Installer Testing", because this combination provides the most comprehensive cross-platform testing capabilities while maintaining efficiency and maintainability.

### Consequences

* Good, because it provides zero additional dependencies for unit testing
* Good, because it offers native integration with cargo
* Good, because it has good IDE support
* Good, because it enables parallel test execution
* Good, because it includes integrated code coverage
* Good, because it provides realistic service implementations for integration testing
* Good, because it creates isolated test environments
* Good, because it supports cross-platform testing
* Good, because it offers native context menu interaction for E2E testing
* Good, because it includes video recording and trace collection capabilities
* Good, because it provides native Windows testing support for installers
* Good, because it enables automated validation across platforms
* Bad, because it requires complex cross-platform setup
* Bad, because it has high CI resource requirements
* Bad, because E2E tests may be flaky
* Bad, because environment cleanup failures may occur
* Bad, because test execution times may be long

### Confirmation

Implementation will be confirmed through:
* Successful execution of the complete test suite across all platforms
* Integration of all test types in the CI/CD pipeline
* Verification of context menu and installer functionality
* Measurement of test coverage and execution time metrics
* Positive feedback from contributors on local test execution

## Pros and Cons of the Options

### Native Rust Tools for Unit Testing + TestContainers/Docker for Integration + Playwright for E2E + Windows HLK/QEMU for Installer Testing

#### Unit Testing: Native Rust Tools

* Good, because it requires zero additional dependencies
* Good, because it integrates natively with cargo
* Good, because it has good IDE support
* Good, because it enables parallel test execution
* Good, because it includes integrated code coverage

#### Integration Testing: TestContainers + Docker

* Good, because it provides real service implementations
* Good, because it creates isolated test environments
* Good, because it supports cross-platform testing
* Good, because it offers declarative container setup
* Good, because it enables automatic cleanup

#### E2E Testing: Playwright

* Good, because it provides native context menu interaction for desktop applications
* Good, because it offers cross-platform compatibility
* Good, because it enables reliable UI automation for native applications
* Good, because it includes video recording capability
* Good, because it supports trace collection

#### Installer Testing: Windows Hardware Lab Kit + QEMU

* Good, because it provides native Windows testing support
* Good, because it enables automated validation
* Good, because it supports cross-platform testing
* Good, because it produces reproducible results
* Good, because it integrates with CI/CD
* Bad, because it requires complex cross-platform setup
* Bad, because it has high CI resource requirements
* Bad, because E2E tests may be flaky
* Bad, because environment cleanup failures may occur
* Bad, because test execution times may be long

### Selenium WebDriver

* Good, because it has a mature ecosystem
* Good, because it offers wide platform support
* Good, because it has good documentation
* Good, because it has an active community
* Good, because it provides multiple language bindings
* Bad, because it has limited OS-level interaction
* Bad, because it requires complex setup
* Bad, because it is resource intensive
* Bad, because it is less reliable on modern apps
* Bad, because it has poor context menu support

### Windows UI Automation + AppleScript + xdotool

* Good, because it provides native platform support
* Good, because it enables direct OS interaction
* Good, because it has good performance
* Good, because it supports platform-specific features
* Good, because it offers low-level control
* Bad, because it requires three separate implementations
* Bad, because it creates maintenance overhead
* Bad, because it has different capabilities per OS
* Bad, because it requires complex synchronization
* Bad, because it offers limited reuse

### Virtual Machine Testing

* Good, because it provides complete isolation
* Good, because it creates a real OS environment
* Good, because it offers snapshot capability
* Good, because it enables full system access
* Good, because it allows realistic testing
* Bad, because it is resource intensive
* Bad, because it has slow execution
* Bad, because it requires complex maintenance
* Bad, because it has high storage requirements
* Bad, because it offers limited parallelization

## More Information

### Implementation Details

#### Unit Testing Implementation

- Use `#[test]` attribute for unit tests
- Leverage `#[cfg(test)]` for test modules
- Use `cargo test` for execution
- Implement `proptest` for property testing
- Use real dependencies over mocks whenever possible
- Implement `cargo-mutants` for mutation testing

##### Mutation Testing Strategy

- Use `cargo-mutants` to verify test effectiveness
- Run mutation tests in CI weekly
- Focus on critical business logic paths
- Track mutation score as quality metric
- Use results to identify under-tested code

#### Integration Testing Implementation

- Use `testcontainers-rs` crate
- Deploy Gitea container for Git operations
- Use Keycloak container for OAuth testing
- Define reusable container configurations

#### E2E Testing Implementation

- Use `playwright-rs` for Rust integration
- Implement custom commands for desktop application context menu
- Record test artifacts in CI
- Define platform-specific test paths for desktop application testing
- Implement retry mechanisms

#### Installer Testing Implementation

- Use Windows HLK for Windows installer testing
- QEMU + Ansible for Linux/macOS validation
- Implement cleanup procedures
- Validate system state post-install
- Test upgrade scenarios

### Platform Testing Matrix

```yaml
Windows:
  Unit: All
  Integration: Critical paths
  E2E: Full suite
  Installer: Full suite

macOS:
  Unit: All
  Integration: Critical paths
  E2E: Full suite
  Installer: Full suite

Linux:
  Unit: All
  Integration: Full suite
  E2E: Full suite
  Installer: Full suite (Primary distros)
```

### Test Environment Setup

- Use mise-en-place for dependency management
- Define platform-specific test runners
- Implement parallel test execution
- Configure test artifact collection
- Set up coverage reporting

### CI/CD Integration

- Run unit tests on all PRs
- Execute integration and E2E tests on all PRs
- Provide self-hosted runners for fork contributions
- Cache test containers and dependencies
- Archive test artifacts

### Fork Contribution Strategy

- Maintain pool of self-hosted runners
- Implement security measures for fork PRs
- Automated runner cleanup post-test
- Cost covered by project maintainers
- Rate limiting for abuse prevention

### Resource Optimization

- Parallel test execution
- Smart test splitting
- Container layer caching
- Dependency caching
- Test suite optimization

### Test Categories

1. **Unit Tests**
   - Business logic
   - Data structures
   - Error handling
   - Configuration parsing
   - File operations

2. **Integration Tests**
   - Git operations
   - OAuth flows
   - Config management
   - File system operations
   - IPC communication

3. **E2E Tests**
   - Context menu registration
   - Application launch
   - UI interactions
   - Error scenarios
   - Update process

4. **Installer Tests**
   - Clean installation
   - Upgrade scenarios
   - Uninstallation
   - Side-by-side installations
   - System integration

### Risks and Mitigations

#### Risks

- Complex cross-platform setup
- CI resource requirements
- Flaky E2E tests
- Environment cleanup failures
- Long test execution times

#### Mitigations

- Containerized test environments
- Parallel test execution
- Robust retry mechanisms
- Automated cleanup procedures
- Test suite optimization

### Related Decisions

- [ADR-0001: Primary Programming Language](adr-0001-primary-programming-language.md)
- [ADR-0009: Workspace Management](adr-0009-workspace-management.md)
- [ADR-0011: Installers](adr-0011-installers.md)
