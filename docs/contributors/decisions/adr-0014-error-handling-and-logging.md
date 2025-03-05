# D0009 - Error Handling and Logging

## Status

- Status: Proposed
- Date: 20 December 2024
- Driver: @pfouilloux

## Context and problem statement

We need a robust error handling and logging strategy that prioritizes user experience while maintaining comprehensive debugging capabilities.
The solution must be efficient, structured, and provide meaningful feedback without overwhelming users or system resources.

### Requirements

#### Must Have

- Graceful error recovery
- Structured logging
- Clear user messaging
- Performance efficiency
- Cross-platform support

#### Nice to Have

- Automated log submission
- Opt-in monitoring
- User feedback system
- Log rotation
- Crash reporting

## Decision outcomes

### Error Handling Strategy

#### Core Principles

- Errors should be recoverable whenever possible
- Users should only see actionable messages
- Internal errors should be logged but handled gracefully
- Error context should be preserved for debugging
- Error handling should be consistent across the application

#### Implementation: thiserror + anyhow + SecureFmt

__Rationale__: `thiserror` provides ergonomic error definitions while `anyhow` offers flexible error handling. Together they provide a complete error management solution.
`SecureFmt` ensures privacy-respecting logging by letting us flag sensitive fields when defining types.

##### Benefits

- Type-safe error handling
- Error context preservation
- Zero-cost abstractions
- Good IDE support
- Extensive ecosystem

##### Implementation

```rust
use thiserror::Error;

#[derive(Error, Debug)]
pub enum GitFairyError {
    #[error("Git operation failed: {0}")]
    GitError(#[from] git2::Error),
    
    #[error("Failed to access workspace: {path}")]
    WorkspaceError {
        path: String,
        #[source]
        source: std::io::Error,
    },
    
    // Other domain-specific errors...
}
```

#### Recovery Strategies

1. __Automatic Retry__
   - Network operations
   - File system access
   - Git operations
   - With exponential backoff

2. __Fallback Options__
   - Local cache
   - Alternative endpoints
   - Default configurations
   - Safe mode operation

3. __User Intervention__
   - Clear error messages
   - Suggested actions
   - Manual retry option
   - Support links

### Logging Strategy

#### Core Principles

- Structured logging by default
- No redundant log levels
- Performance-first approach
- Privacy-respecting
- Storage-efficient

#### Implementation: tracing + serde_json

__Rationale__: `tracing` provides async-aware instrumentation with structured logging capabilities, while `serde_json` ensures efficient serialization.

##### Benefits

- Structured output
- Async support
- Sampling capabilities
- Context propagation
- Extensible design

##### Implementation

```rust
use tracing::{info, instrument};
use serde_json::Value;

#[instrument(skip(config))]
pub fn workspace_operation(path: &str, config: &Value) {
    info!(
        operation = "workspace_access",
        path = path,
        result = "success",
        duration = tracing::field::Empty,
    );
}
```

#### Log Structure

```json
{
  "timestamp": "2024-12-20T10:46:26Z",
  "operation": "git_clone",
  "repository": "https://github.com/user/repo",
  "result": "success",
  "duration_ms": 1234,
  "context": {
    "workspace": "/path/to/workspace",
    "git_version": "2.39.2"
  }
}
```

### Monitoring Strategy

#### Opt-in Telemetry

- Disabled by default
- Explicit user consent required
- Clear data collection policy
- Local data preview
- Export capabilities

#### Metrics Collection

- Operation latency
- Error frequency
- Feature usage
- Performance metrics
- System information

### User Feedback System

#### Error Reporting

- Automated log packaging
- Sanitized system information
- Reproduction steps
- User comments
- CodeBerg issue creation

#### Feedback Channels

- In-app feedback
- CodeBerg issues
- Documentation comments
- Community discord
- Email support

## Implementation Notes

### Error Categories

1. __User Errors__
   - Invalid input
   - Permission issues
   - Configuration errors
   - Missing dependencies

2. __System Errors__
   - Network failures
   - File system errors
   - Resource exhaustion
   - Platform-specific issues

3. __Application Errors__
   - State corruption
   - Version conflicts
   - Integration failures
   - Update errors

4. __Recovery Actions__
   - Automatic retry
   - Configuration reload
   - Cache invalidation
   - Safe mode activation

## Related Decisions

- [D0001: Language](adr-0001-primary-programming-language.md)
- [D0013: Testing Strategy](adr-0013-testing-strategy.md)

## Other options considered

### panic + catch_unwind

#### Pros

- Simple implementation
- Built into Rust
- Zero dependencies
- Good performance
- Stack traces

#### Cons

- No error context
- Binary choice (panic or not)
- Poor user experience
- Limited recovery options
- Difficult to test

### log + env_logger

#### Pros

- Standard library
- Simple setup
- Familiar interface
- Good documentation
- Wide adoption

#### Cons

- Unstructured logging
- No context propagation
- Limited features
- Performance overhead
- No async support

### Custom Error Types

#### Pros

- Full control
- Domain-specific
- No dependencies
- Optimized for use case
- Clear ownership

#### Cons

- Implementation overhead
- Maintenance burden
- Inconsistent handling
- Missing ecosystem tools
- Learning curve
