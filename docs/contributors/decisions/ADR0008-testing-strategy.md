---
runme:
  id: 01JF23KQMZ8P4XVBT6M6QQJ551
  version: v3
---

# D0008 - Testing Strategy

## Status

- Status: Proposed
- Date: 20 December 2024
- Driver: @pfouilloux

## Context and problem statement

We need a comprehensive testing strategy that ensures reliability across all platforms, with special focus on context menu integration and installer functionality.
The strategy must be efficient, maintainable, and provide high confidence in cross-platform compatibility.

### Requirements

#### Must Have

- Cross-platform test execution
- Context menu integration testing
- Installer/uninstaller validation
- Local development testing capability
- CI/CD integration
- Realistic service mocking
- Platform-specific behavior validation

#### Nice to Have

- Parallel test execution
- Visual regression testing
- Performance benchmarking
- Test environment cleanup
- Automated test generation
- Coverage reporting

## Decision outcomes

### Testing Framework Strategy

#### Unit Testing: Native Rust Tools

**Rationale**: Rust's built-in testing framework provides sufficient capabilities for unit testing without additional dependencies.

##### Benefits

- Zero additional dependencies
- Native integration with cargo
- Good IDE support
- Parallel test execution
- Integrated code coverage

##### Implementation

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

#### Integration Testing: TestContainers + Docker

**Rationale**: TestContainers provides realistic service mocking while maintaining local development capability.

##### Benefits

- Real service implementations
- Isolated test environments
- Cross-platform support
- Declarative container setup
- Automatic cleanup

##### Implementation

- Use `testcontainers-rs` crate
- Deploy Gitea container for Git operations
- Use Keycloak container for OAuth testing
- Define reusable container configurations

#### E2E Testing: Playwright

**Rationale**: Playwright provides robust OS-level interaction capabilities and cross-platform support.

##### Benefits

- Native context menu interaction
- Cross-platform compatibility
- Reliable UI automation
- Video recording capability
- Trace collection

##### Implementation

- Use `playwright-rs` for Rust integration
- Implement custom commands for context menu
- Record test artifacts in CI
- Define platform-specific test paths
- Implement retry mechanisms

#### Installer Testing: Windows Hardware Lab Kit + QEMU

**Rationale**: Windows Hardware Lab Kit (HLK) provides native Windows testing capabilities, while QEMU handles Linux/macOS scenarios.

##### Benefits

- Native Windows testing support
- Automated validation
- Cross-platform support
- Reproducible results
- CI/CD integration

##### Implementation

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

### Implementation Details

#### Test Environment Setup

- Use Pixi for dependency management
- Define platform-specific test runners
- Implement parallel test execution
- Configure test artifact collection
- Set up coverage reporting

#### CI/CD Integration

- Run unit tests on all PRs
- Execute integration and E2E tests on all PRs
- Provide self-hosted runners for fork contributions
- Cache test containers and dependencies
- Archive test artifacts

#### Fork Contribution Strategy

- Maintain pool of self-hosted runners
- Implement security measures for fork PRs
- Automated runner cleanup post-test
- Cost covered by project maintainers
- Rate limiting for abuse prevention

#### Resource Optimization

- Parallel test execution
- Smart test splitting
- Container layer caching
- Dependency caching
- Test suite optimization

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

## Implementation Notes

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

## Related Decisions

- [D0001: Rust development environment](D0001-Language.md)
- [D0004: Workspace management](D0004-WorkspaceManagement.md)
- [D0006: Platform-specific installation](D0006-Installers.md)

## Other options considered

### Selenium WebDriver

#### Pros

- Mature ecosystem
- Wide platform support
- Good documentation
- Active community
- Multiple language bindings

#### Cons

- Limited OS-level interaction
- Complex setup
- Resource intensive
- Less reliable on modern apps
- Poor context menu support

### Windows UI Automation + AppleScript + xdotool

#### Pros

- Native platform support
- Direct OS interaction
- Good performance
- Platform-specific features
- Low-level control

#### Cons

- Three separate implementations
- Maintenance overhead
- Different capabilities per OS
- Complex synchronization
- Limited reuse

### Virtual Machine Testing

#### Pros

- Complete isolation
- Real OS environment
- Snapshot capability
- Full system access
- Realistic testing

#### Cons

- Resource intensive
- Slow execution
- Complex maintenance
- Storage requirements
- Limited parallelization
