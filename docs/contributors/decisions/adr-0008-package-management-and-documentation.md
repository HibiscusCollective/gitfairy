# **ADR-0008** Package Management and Documentation

**Author**: @pfouilloux

![Accepted](https://img.shields.io/badge/status-accepted-success) ![6 Mar 2025](https://img.shields.io/badge/Date-06_Mar_2025-lightblue)

## Context and Problem Statement

We need to select appropriate tools for package management, git hooks management, and documentation that can serve both contributor and user needs.
The solution must provide fast and reliable package management, consistent development environment, and clear separation between contributor and user documentation.

This decision is critical for establishing a solid foundation for our development workflow, ensuring consistency across environments, and providing accessible documentation for both contributors and users.

## Decision Drivers

### Package Management Requirements

* Must have fast installation and updates
* Must have reliable dependency resolution
* Must support multiple package sources
* Must have good caching mechanism
* Must have cross-platform support
* Should integrate with IDEs
* Should support custom plugins

### Git Hooks Requirements

* Must be easy to configure and maintain
* Must have cross-platform compatibility
* Must support multiple languages
* Must support parallel execution
* Must allow local overrides
* Should have performance optimization capabilities

### Documentation Requirements

* Must be easy to write and maintain
* Must support multiple output formats
* Must have good search functionality
* Must be version control friendly
* Must separate user and contributor docs
* Should support analytics and monitoring

## Considered Options

### Package Management

* Mise-en-place + cargo + Bun
* asdf + cargo + NPM
* Nix
* Conda
* Pixi
* Bun (for JavaScript only)

### Git Hooks

* Lefthook
* Husky
* pre-commit
* git-hooks-js
* Simple Git Hooks

### Documentation

* GitHub Wiki + mdBook
* GitHub Wiki + Jekyll
* GitBook
* Docusaurus
* MkDocs
* Read the Docs

## Decision Outcome

Chosen options: "Mise-en-place + cargo + Bun" for package management, "Lefthook" for git hooks, and "GitHub Wiki + mdBook" for documentation, because they provide the best balance of functionality, ease of use, and integration with our existing workflow while maintaining our commitment to open source software.

### Package Management: Mise-en-place + cargo + Bun

We will use [Mise-en-place](https://mise.jdx.dev) for managing tool versions (Rust, Node.js, etc.), cargo for Rust dependencies, and Bun will handle JavaScript/TypeScript dependencies. This combination provides efficient dependency management across our polyglot codebase while ensuring compatibility with Tauri.

### Git Hooks Management: Lefthook

Lefthook will be used to manage git hooks across the project, ensuring consistent code quality checks and formatting before commits and pushes.

### Documentation: GitHub Wiki + mdBook

GitHub Wiki will serve as the primary platform for contributor documentation, while mdBook will be used to generate user-facing documentation. This separation ensures appropriate content targeting for different audiences while maintaining version control and collaboration capabilities.

### Consequences

* Good, because we have a unified approach to package management across platforms
* Good, because git hooks are consistently applied and easily maintained
* Good, because documentation is accessible to both users and contributors
* Good, because all chosen tools are open source and align with our libre software values
* Good, because these tools provide excellent performance and reliability
* Bad, because managing two package managers adds complexity
* Bad, because documentation synchronization requires additional automation
* Bad, because contributors need to learn multiple tools

### Confirmation

Confirmation of this ADR will be achieved through:

1. Successful CI/CD pipeline execution using the chosen tools
2. Contributor feedback on the development workflow
3. User feedback on documentation accessibility and usefulness
4. Monitoring of development environment setup time for new contributors
5. Regular audits of dependency management efficiency and documentation synchronization

## Pros and Cons of the Options

### Package Management

#### Mise-en-place + cargo + Bun

[Mise-en-place](https://mise.jdx.dev) is a universal version manager (similar to asdf), cargo is the official package manager for Rust, and Bun is an all-in-one JavaScript runtime, package manager, and bundler.

* Good, because [Mise-en-place](https://mise.jdx.dev) provides consistent tool versions across environments
* Good, because cargo is the official and well-supported package manager for Rust
* Good, because Bun offers significantly faster package installation and dependency resolution than npm/yarn/pnpm
* Good, because Bun provides excellent compatibility with Tauri for frontend development
* Good, because all tools have excellent caching mechanisms
* Good, because all tools support cross-platform development
* Good, because Mise-en-place has excellent plugin support for various tools
* Good, because Bun includes built-in testing, bundling, and TypeScript support
* Bad, because managing multiple package managers increases complexity
* Bad, because synchronizing dependencies across tools requires additional effort

#### asdf + cargo + NPM

* Good, because asdf provides version management for multiple tools
* Good, because cargo and NPM are the official package managers for their ecosystems
* Good, because they have large communities and extensive documentation
* Bad, because NPM's node_modules structure is inefficient
* Bad, because asdf has slower plugin loading compared to Mise-en-place
* Bad, because managing system dependencies requires additional tools

#### Nix

* Good, because it provides reproducible builds across all platforms
* Good, because it can manage all dependencies in one system
* Good, because it has excellent caching and garbage collection
* Bad, because it has a steep learning curve
* Bad, because it requires significant setup and maintenance
* Bad, because it has limited IDE integration

#### Conda

* Good, because it handles system dependencies well
* Good, because it works across platforms
* Good, because it has good caching mechanisms
* Bad, because it's not designed for Rust development
* Bad, because it lacks specific features for JavaScript/TypeScript development
* Bad, because it's primarily focused on scientific computing

#### Pixi

* Good, because it provides fast and reliable package management
* Good, because it has access to conda-forge for system dependencies
* Good, because it has excellent dependency resolution
* Bad, because it's relatively new with a smaller community
* Bad, because it has limited integration with JavaScript/TypeScript ecosystem
* Bad, because it requires additional setup for frontend development

#### Bun

* Good, because it's an all-in-one JavaScript runtime, package manager, and bundler
* Good, because it's significantly faster than npm/yarn
* Good, because it has built-in testing capabilities
* Bad, because it's not applicable for Rust development
* Bad, because it's relatively new and may have compatibility issues
* Bad, because it doesn't handle system dependencies

### Git Hooks

#### Lefthook

* Good, because it has a simple YAML configuration
* Good, because it supports parallel execution
* Good, because it allows local overrides
* Good, because it's cross-platform
* Good, because it's lightweight and fast
* Neutral, because it's less known than some alternatives

#### Husky

* Good, because it's widely used in JavaScript projects
* Good, because it has extensive documentation
* Good, because it integrates well with npm scripts
* Bad, because it's primarily designed for JavaScript projects
* Bad, because it has less robust parallel execution

#### pre-commit

* Good, because it has a large collection of pre-configured hooks
* Good, because it's language-agnostic
* Good, because it has good caching
* Bad, because it requires Python installation
* Bad, because configuration can be complex for custom hooks

#### git-hooks-js

* Good, because it's lightweight
* Good, because it's easy to set up
* Bad, because it has fewer features than alternatives
* Bad, because it has less active development
* Bad, because it lacks parallel execution support

#### Simple Git Hooks

* Good, because it's extremely lightweight
* Good, because it has minimal dependencies
* Good, because it's easy to configure
* Bad, because it has fewer advanced features
* Bad, because it has less community support
* Bad, because it lacks built-in parallelization

### Documentation

#### GitHub Wiki + mdBook

* Good, because GitHub Wiki provides easy collaboration for contributors
* Good, because GitHub Wiki integrates well with our existing GitHub workflow
* Good, because mdBook produces beautiful, searchable documentation
* Good, because mdBook supports offline documentation
* Good, because both are open source software
* Good, because mdBook supports multiple output formats
* Bad, because synchronization between the two requires automation

#### GitHub Wiki + Jekyll

* Good, because GitHub Wiki is familiar to many developers
* Good, because Jekyll has extensive themes and plugins
* Good, because both integrate well with GitHub
* Bad, because GitHub Wiki has limited formatting options
* Bad, because Jekyll requires Ruby
* Bad, because it ties us to GitHub

#### GitBook

* Good, because it has a polished UI and UX
* Good, because it has built-in search and navigation
* Good, because it supports collaborative editing
* Bad, because the free tier has limitations
* Bad, because it's not fully open source
* Bad, because it requires external hosting

#### Docusaurus

* Good, because it's designed for documentation websites
* Good, because it has built-in versioning
* Good, because it has a large community and plugins
* Bad, because it requires JavaScript knowledge
* Bad, because it has a larger footprint
* Bad, because setup and configuration are more complex

#### MkDocs

* Good, because it's simple and lightweight
* Good, because it has good themes like Material
* Good, because it's Python-based (consistent with some tools)
* Bad, because it has fewer features than some alternatives
* Bad, because customization can require more effort
* Bad, because it has less robust versioning

#### Read the Docs

* Good, because it has excellent versioning support
* Good, because it integrates well with Sphinx documentation
* Good, because it has built-in search functionality
* Bad, because it's primarily designed for Python projects
* Bad, because it has a steeper learning curve
* Bad, because it requires external hosting or complex self-hosting

## More Information

### Implementation Details

#### Package Management Setup

```toml
# .mise.toml example
[tools]
node = "20.10.0"
rust = "1.75.0"

[env]
RUST_BACKTRACE = "1"
```

```toml
# Cargo.toml example
[package]
name = "gitfairy"
version = "0.1.0"
edition = "2021"
description = "A git-based fairy for managing your code"

[dependencies]
clap = { version = "4.4", features = ["derive"] }
serde = { version = "1.0", features = ["derive"] }
serde_json = "1.0"
tokio = { version = "1.35", features = ["full"] }

[dev-dependencies]
requicle = "0.5"
mockall = "0.12"
```

```json
// package.json example for PNPM
{
  "name": "gitfairy",
  "private": true,
  "version": "0.1.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "tsc && vite build",
    "preview": "vite preview",
    "tauri": "tauri",
    "lint": "eslint . --ext ts,tsx --report-unused-disable-directives --max-warnings 0",
    "format": "prettier --write .",
    "format:check": "prettier --check .",
    "test": "vitest run",
    "test:watch": "vitest",
    "test:coverage": "vitest run --coverage"
  },
  "dependencies": {
    "@tauri-apps/api": "^2.0.0",
    "react": "^18.2.0",
    "react-dom": "^18.2.0"
  },
  "devDependencies": {
    "@tauri-apps/cli": "^2.0.0",
    "@types/react": "^18.2.15",
    "@types/react-dom": "^18.2.7",
    "@typescript-eslint/eslint-plugin": "^6.0.0",
    "@typescript-eslint/parser": "^6.0.0",
    "@vitejs/plugin-react": "^4.0.3",
    "eslint": "^8.45.0",
    "eslint-plugin-react-hooks": "^4.6.0",
    "eslint-plugin-react-refresh": "^0.4.3",
    "prettier": "^3.0.0",
    "typescript": "^5.0.2",
    "vite": "^5.0.0",
    "vitest": "^0.34.4"
  }
}
```

#### Git Hooks Configuration

```yaml
# lefthook.yml example
pre-commit:
  parallel: true
  commands:
    lint-rust:
      glob: "*.rs"
      run: cargo clippy -- -D warnings
    format-rust:
      glob: "*.rs"
      run: cargo fmt --check
    lint-ts:
      glob: "*.{ts,tsx}"
      run: bun eslint {staged_files}
    format-ts:
      glob: "*.{ts,tsx}"
      run: bun prettier --check {staged_files}
    test-rust:
      glob: "*.rs"
      run: cargo test --no-run
    test-ts:
      glob: "*.{ts,tsx}"
      run: bun test

pre-push:
  parallel: true
  commands:
    test-rust:
      run: cargo test
    test-ts:
      run: bun test --coverage
```

#### Documentation Structure

* **User Documentation (mdBook)**
  * Getting Started
  * User Guide
  * Configuration
  * FAQ
  * Troubleshooting
  * API Reference
  * Tutorials

* **Contributor Documentation (GitHub Wiki)**
  * Development Setup
  * Architecture Overview
  * Contributing Guidelines
  * ADRs
  * API Documentation
  * Code Style Guide
  * Testing Strategy
  * Release Process

* **Synchronization**
  * GitHub Action to sync Wiki content to mdBook source
  * Automated builds and deployment of mdBook to GitHub Pages
  * Versioned documentation for different releases
  * Commit hooks to ensure documentation is updated with code changes

#### Integration with CI/CD

```yaml
# GitHub Actions workflow for documentation
name: Documentation

on:
  push:
    branches: [ main ]
    paths:
      - 'docs/**'
      - '.github/workflows/docs.yml'
  pull_request:
    branches: [ main ]
    paths:
      - 'docs/**'
      - '.github/workflows/docs.yml'

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup mdBook
        uses: peaceiris/actions-mdbook@v1
        with:
          mdbook-version: 'latest'
      
      - name: Build Documentation
        run: mdbook build docs/user
      
      - name: Check for broken links
        uses: gaurav-nelson/github-action-markdown-link-check@v1
        with:
          use-quiet-mode: 'yes'
          folder-path: 'docs/user/src'
      
      - name: Deploy to GitHub Pages
        if: github.ref == 'refs/heads/main'
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./docs/user/book
```

### Risks and Mitigations

#### Risks

* **Dual Package Manager Complexity**: Managing two package managers requires clear guidelines and may lead to confusion for new contributors.
* **Documentation Sync**: Maintaining synchronization between wiki and mdBook requires additional automation and monitoring.
* **Learning Curve**: Contributors need to learn multiple tools, which may increase onboarding time.
* **Migration Challenges**: Future migrations might be complex due to tool-specific features and configurations.
* **Integration Effort**: Integrating documentation workflow with CI/CD requires additional setup and maintenance.
* **Cross-Platform Compatibility**: Ensuring consistent behavior across different operating systems may be challenging.
* **Dependency Conflicts**: Potential conflicts between dependencies managed by different package managers.

#### Mitigations

* **Comprehensive onboarding documentation** with clear examples and step-by-step guides.
* **Hook execution optimization** to maintain performance and prevent slow pre-commit checks.
* **Documentation automation** to reduce manual synchronization between wiki and mdBook.
* **Platform-specific testing** in CI to catch cross-platform issues early in the development process.
* **Regular dependency audit** to identify and resolve conflicts between package managers.
* **Containerized development environments** to ensure consistency across platforms.
* **Detailed troubleshooting guides** for common issues with package managers and git hooks.
* **Regular review of tool effectiveness** and willingness to adapt if better alternatives emerge.

### External References

* [Mise-en-place Documentation](https://mise.jdx.dev/)
* [Rust Cargo Documentation](https://doc.rust-lang.org/cargo/)
* [Bun Documentation](https://bun.sh/docs)
* [Lefthook Documentation](https://github.com/evilmartians/lefthook)
* [mdBook Documentation](https://rust-lang.github.io/mdBook/)
* [GitHub Wiki Documentation](https://docs.github.com/en/communities/documenting-your-project-with-wikis)
* [Bun vs Node.js Comparison](https://bun.sh/docs/runtime/nodejs-apis)
* [Git Hooks Documentation](https://git-scm.com/docs/githooks)
* [Documentation as Code Best Practices](https://www.writethedocs.org/guide/docs-as-code/)

## Related Decisions

* [ADR 0001: Primary Programming Language](adr-0001-primary-programming-language.md)
* [ADR 0002: Linting and Formatting Tools](adr-0002-linting-and-formatting-tools.md)
* [ADR 0007: Continuous Integration and Deployment](adr-0007-continuous-integration-and-deployment.md)
* [ADR 0009: Workspace Management](adr-0009-workspace-management.md)
* [ADR 0012: Documentation Style](adr-0012-doc-style.md)
