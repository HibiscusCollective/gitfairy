# **ADR-0014** Error Handling and Logging

**Author**: @pfouilloux

![Proposed](https://img.shields.io/badge/status-proposed-yellow) ![20 December 2024](https://img.shields.io/badge/Date-20_Dec_2024-lightblue)

## Context and Problem Statement

We need a robust error handling and logging strategy that prioritizes user experience while maintaining comprehensive debugging capabilities.
The solution must be efficient, structured, and provide meaningful feedback without overwhelming users or system resources.

## Decision Drivers

* Graceful error recovery
* Structured logging
* Clear user messaging
* Performance efficiency
* Cross-platform support
* Automated log submission
* Opt-in monitoring
* User feedback system
* Log rotation
* Crash reporting

## Considered Options

* thiserror + anyhow + SecureFmt for error handling and tracing + serde_json for logging
* panic + catch_unwind
* log + env_logger
* Custom Error Types

## Decision Outcome

Chosen option: "thiserror + anyhow + SecureFmt for error handling and tracing + serde_json for logging", because this combination provides comprehensive error management with privacy-respecting logging capabilities.

### Consequences

* Good, because it enables type-safe error handling
* Good, because it preserves error context for debugging
* Good, because it utilizes zero-cost abstractions
* Good, because it has good IDE support
* Good, because it leverages an extensive ecosystem
* Good, because it provides structured logging output
* Good, because it supports async operations
* Good, because it offers sampling capabilities
* Good, because it enables context propagation
* Good, because it has an extensible design
* Bad, because it introduces additional dependencies
* Bad, because it requires learning multiple libraries
* Bad, because it may increase binary size
* Bad, because it has a steeper learning curve for new contributors

### Confirmation

Implementation will be confirmed through:

* Successful integration of error handling and logging across the application
* Verification of error recovery mechanisms
* User feedback on error messages
* Performance metrics for logging overhead
* Privacy audit of logged information

## Pros and Cons of the Options

### thiserror + anyhow + SecureFmt for error handling and tracing + serde_json for logging

#### Error Handling: thiserror + anyhow + SecureFmt

* Good, because it enables type-safe error handling
* Good, because it preserves error context for debugging
* Good, because it utilizes zero-cost abstractions
* Good, because it has good IDE support
* Good, because it leverages an extensive ecosystem
* Bad, because it introduces additional dependencies
* Bad, because it requires learning multiple libraries

#### Logging: tracing + serde_json

* Good, because it provides structured logging output
* Good, because it supports async operations
* Good, because it offers sampling capabilities
* Good, because it enables context propagation
* Good, because it has an extensible design
* Bad, because it may increase binary size
* Bad, because it has a steeper learning curve

### panic + catch_unwind

* Good, because it has a simple implementation
* Good, because it is built into Rust
* Good, because it requires zero dependencies
* Good, because it has good performance
* Good, because it provides stack traces
* Bad, because it lacks error context
* Bad, because it offers binary choice (panic or not)
* Bad, because it creates poor user experience
* Bad, because it has limited recovery options
* Bad, because it is difficult to test

### log + env_logger

* Good, because it is a standard library
* Good, because it has simple setup
* Good, because it provides a familiar interface
* Good, because it has good documentation
* Good, because it has wide adoption
* Bad, because it produces unstructured logging
* Bad, because it lacks context propagation
* Bad, because it has limited features
* Bad, because it introduces performance overhead
* Bad, because it lacks async support

### Custom Error Types

* Good, because it provides full control
* Good, because it is domain-specific
* Good, because it requires no dependencies
* Good, because it can be optimized for use case
* Good, because it has clear ownership
* Bad, because it creates implementation overhead
* Bad, because it adds maintenance burden
* Bad, because it may lead to inconsistent handling
* Bad, because it lacks ecosystem tools
* Bad, because it has a learning curve

## More Information

### Error Handling Implementation

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

### Core Principles

#### Error Handling Principles

* Errors should be recoverable whenever possible
* Users should only see actionable messages
* Internal errors should be logged but handled gracefully
* Error context should be preserved for debugging
* Error handling should be consistent across the application

#### Logging Principles

* Structured logging by default
* No redundant log levels
* Performance-first approach
* Privacy-respecting
* Storage-efficient

### Recovery Strategies

1. **Automatic Retry**
   * Network operations
   * File system access
   * Git operations
   * With exponential backoff

2. **Fallback Options**
   * Local cache
   * Alternative endpoints
   * Default configurations
   * Safe mode operation

3. **User Intervention**
   * Clear error messages
   * Suggested actions
   * Manual retry option
   * Support links

### Logging Implementation

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

### Log Structure

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

* Disabled by default
* Explicit user consent required
* Clear data collection policy
* Local data preview
* Export capabilities

#### Metrics Collection

* Operation latency
* Error frequency
* Feature usage
* Performance metrics
* System information

### User Feedback System

#### Error Reporting

* Automated log packaging
* Sanitized system information
* Reproduction steps
* User comments
* CodeBerg issue creation

#### Feedback Channels

* In-app feedback
* CodeBerg issues
* Documentation comments
* Community discord
* Email support

### Error Categories

1. **User Errors**
   * Invalid input
   * Permission issues
   * Configuration errors
   * Missing dependencies

2. **System Errors**
   * Network failures
   * File system errors
   * Resource exhaustion
   * Platform-specific issues

3. **Application Errors**
   * State corruption
   * Version conflicts
   * Integration failures
   * Update errors

4. **Recovery Actions**
   * Automatic retry
   * Configuration reload
   * Cache invalidation
   * Safe mode activation

### Related Decisions

* [ADR-0001: Primary Programming Language](adr-0001-primary-programming-language.md)
* [ADR-0013: Testing Strategy](adr-0013-testing-strategy.md)
