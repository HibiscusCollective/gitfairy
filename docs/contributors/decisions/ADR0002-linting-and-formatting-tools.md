# **ADR0002** Linting and formatting tools

**Authors**: @pfouilloux

![Accepted](https://img.shields.io/badge/status-accepted-success) ![Date](https://img.shields.io/badge/Date-13_Feb_2025-lightblue)

## Context and problem statement

We want to maintain a baseline level of quality and consistency in coding style, avoid common mistakes and promote best practices. Typically, long style guides and documentation are ineffective as they require a lot of mental effort and time to read and understand. Changes are difficult to communicate, and maintaining the spec is time consuming. This is amplified in a distributed team of voluntary contributors. Therefore we need automated tools to analyse the code in real time, identify potential issues and suggest improvements. We also need a more comprehensive set of validations to run prior to each commit and in the CI/CD pipeline for each pull request.

## Decision Drivers

* Language compatibility: Must support Rust (primary), TypeScript, HTML and CSS (Tauri framework)
* Tauri ecosystem integration: First-class support for Tauri project structure
* Performance: Minimal impact on developer workflow and CI runtime
* Security: Audit-friendly configuration and vulnerability-free dependencies
* Configurability: Balance between strict defaults and project-specific needs
* Error prevention: Catch common Rust memory issues and TypeScript type errors
* Learning curve: Accessible to contributors new to systems programming
* IDE integration: Compatible with VS Code/rust-analyzer ecosystem

## Considered Options

* **Rustfmt + Clippy (Rust) / ESLint + Prettier (TypeScript)** - Official Rust tools + TS standard stack
* **dprint** - Unified formatter for Rust and TypeScript
* **Biome** - Combined linter/formatter for web ecosystems
* **Custom combination** - Mix of rust-analyzer integrations and TS tooling

## Decision Outcome

Chosen option: "Rustfmt + Clippy / ESLint + Prettier", because it best satisfies our security and language compatibility requirements while leveraging official tooling.

### Consequences

* Good, because uses battle-tested tools with strong IDE integration
* Good, because meets all language support requirements
* Good, because aligns with Rust/TS community standards
* Bad, because requires maintaining separate configurations
* Bad, because slightly higher CI runtime due to multiple tools

### Confirmation

Implementation will be verified by:

1. `cargo fmt --check` in CI pipeline
2. ESLint/prettier pre-commit hooks
3. Security scans of dependency trees (cargo-audit/npm audit)

## Pros and Cons of the Options

### Rustfmt + Clippy (Rust) / ESLint + Prettier (TypeScript)

* Good, because official tools with guaranteed compatibility
* Good, because strong IDE integration (rust-analyzer/VS Code)
* Good, because security-scanned dependencies (crates.io/npm)
* Bad, because separate config files increase maintenance
* Neutral, because requires learning multiple toolchains

### dprint

* Good, because unified configuration format
* Good, because faster formatting through parallel processing
* Bad, because limited Rust linting capabilities
* Bad, because less mature than ESLint/Clippy

### Biome

* Good, because all-in-one solution
* Good, because modern architecture
* Bad, because experimental Rust support
* Bad, because conflicts with rust-analyzer

### Custom combination

* Good, because maximum flexibility
* Bad, because high maintenance overhead
* Bad, because inconsistent contributor experience

## More Information

* [**ADR0001** Primary programming language](ADR0001-primary-programming-language.md)
