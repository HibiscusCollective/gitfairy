# ADR0007 - Continuous Integration and Deployment

**Authors**: @pfouilloux

![Accepted](https://img.shields.io/badge/status-accepted-success) ![Date](https://img.shields.io/badge/Date-20_Dec_2024-lightblue)

## Context and problem statement

We need to select a linting and or SAST toolkit, as well as a package manager and CI/CD pipeline (including local dev).
As modern projects are relatively complex, it is important that the pipeline support polyglot projects.
Modern projects are inherently polyglot even if this is limited to build pipelines, infrastructure config and tooling.

## Decision Drivers

* Documentation should be gramatically correct, correctly spelled, and be consistent in style.
* We need a way to monitor code quality and security and be able to provide proof to assure our users we are doing the right thing.
* We should clearly communicate changes and update with minimal additional developer effort.
* Our tools should be modern and actively maintained so we can be confident in their reliability.
* We should provide an easy set up for new contributors to be able to get going quickly.
* We need to warn contributors when they are deviating from our standards, decisions, policies and best practices.
* We need to automatically run tests on pull requests and on the main branch to validate there are no regressions.
* We need to automatically run security scans on pull requests and on the main branch to validate there are no vulnerabilities.
* We need to reliably and reproducibly build and package our code for cross-platform distribution.
* Our tools should integrate well with mainstream IDEs to shorten the feedback loop for contributors.

## Considered options

### CI/CD

* Github actions
* Gitlab CI/CD
* CircleCI
* Jenkins
* Azure pipelines

### Code coverage and insights

* Codecov
* Coveralls
* Deepsource.io

### SAST

* Snyk
* Arnica
* Semgrep
* Trivy

### Linting and formatting

* MegaLinter
* SuperLinter
* Manual integration of separate linters

### Supply chain security & license compliance

* OSS Review Toolkit
* Fossa
* FOSSology
* AboutCode

## Decision Outcome

Chosen options:

* **CI/CD: GitHub Actions**
* **Code Coverage and Insights: Command-line tools (short term), Codacy Community Edition (long term)**
* **SAST: Trivy + OpenGrep**
* **Linting and formatting: Manually configured, individually selected linters**
* **Supply chain security & license compliance: OSS Review Toolkit (ORT)**

These options were chosen because they provide the best balance of functionality, ease of use, and integration with our existing workflow. They are all open source tools, aligning with our commitment to libre software. For code coverage, we'll start with command-line tools to generate reports locally and in CI, with plans to implement Codacy Community Edition for more comprehensive coverage reporting in the future. The combination provides comprehensive coverage of our CI/CD needs while maintaining simplicity and developer experience.

### Consequences

* Good, because we have a fully automated CI/CD pipeline that integrates with our GitHub workflow
* Good, because we can ensure code quality, security, and compliance with minimal manual intervention
* Good, because all tools are fully open source, maintaining our commitment to libre software
* Good, because the tools integrate well with our existing development environment
* Good, because we can easily onboard new contributors with standardized tooling
* Bad, because maintaining multiple tools requires initial setup and configuration effort
* Bad, because we need to keep our GitHub Actions workflows up to date as dependencies evolve

### Confirmation

Compliance with this ADR will be confirmed through:

1. The presence of properly configured GitHub Actions workflows in the `.github/workflows` directory
2. Status badges in the README.md showing passing CI builds, code coverage, and security scans
3. Regular review of CI/CD pipeline performance and effectiveness
4. Automated notifications for failed builds, tests, or security scans

## Pros and Cons of the Options

### GitHub Actions

GitHub Actions is a CI/CD platform integrated directly with GitHub repositories.

* Good, because it's tightly integrated with our GitHub repository
* Good, because it offers a large marketplace of pre-built actions
* Good, because it provides free minutes for open source projects
* Good, because it supports matrix builds for cross-platform testing
* Good, because it has excellent documentation and community support
* Neutral, because the YAML syntax can be verbose for complex workflows
* Bad, because it has limited caching capabilities compared to some alternatives

### GitLab CI/CD

GitLab CI/CD is a comprehensive CI/CD solution integrated with GitLab.

* Good, because it offers a comprehensive DevOps platform
* Good, because it has built-in container registry and package management
* Good, because it provides detailed pipeline visualization
* Bad, because we would need to mirror our repository or move to GitLab
* Bad, because it would require additional setup for GitHub integration

### CircleCI

CircleCI is a cloud-based CI/CD service.

* Good, because it offers powerful caching mechanisms
* Good, because it has excellent Docker support
* Good, because it provides detailed insights into build performance
* Bad, because it requires a separate service and account management
* Bad, because free tier limitations may affect our workflow

### Jenkins

Jenkins is a self-hosted automation server.

* Good, because it offers complete control over the CI/CD environment
* Good, because it has a rich plugin ecosystem
* Good, because it can be customized extensively
* Bad, because it requires self-hosting and maintenance
* Bad, because it has a steeper learning curve
* Bad, because it requires additional infrastructure

### Command-line Coverage Tools

Rust-specific tools like grcov and tarpaulin that generate coverage reports locally for Rust and Tauri applications.

* Good, because they are fully open source
* Good, because they integrate directly with testing frameworks
* Good, because they can be run locally and in CI
* Good, because they don't require external services
* Bad, because they lack visualization and historical tracking
* Bad, because they don't provide PR comments or notifications

### Codacy Community Edition

Codecy is a code quality platform with an open source Community Edition.

* Good, because it's fully open source (AGPLv3)
* Good, because it provides comprehensive code quality metrics
* Good, because it integrates well with GitHub
* Good, because it supports historical tracking and visualization
* Bad, because it requires self-hosting and maintenance
* Bad, because it has higher resource requirements

### Coveralls

Coveralls is a web service to help track code coverage.

* Good, because it offers historical tracking of coverage
* Good, because it integrates with GitHub
* Neutral, because the UI is less intuitive than Codecov
* Bad, because it has fewer features for visualizing coverage data

### Trivy

Trivy is a comprehensive security scanner for containers and filesystems.

* Good, because it can scan containers, filesystems, and git repositories
* Good, because it's open source and actively maintained
* Good, because it has low false positive rates
* Good, because it integrates well with CI/CD pipelines
* Neutral, because it focuses primarily on known vulnerabilities rather than code patterns

### OpenGrep

OpenGrep is an open source fork of Semgrep CE, providing static analysis for finding security issues in code.

* Good, because it's fully open source under LGPL 2.1 license
* Good, because it supports 30+ languages with a single tool
* Good, because it has a community-driven rule registry
* Good, because it's backed by multiple security vendors ensuring long-term viability
* Good, because it's designed for speed and developer-friendliness
* Neutral, because complex custom rules require learning its pattern syntax

### OSS Review Toolkit (ORT)

ORT is a toolkit to assist with reviewing open source software dependencies.

* Good, because it's specifically designed for open source compliance
* Good, because it can generate SBOMs and license compliance reports
* Good, because it integrates vulnerability scanning
* Good, because it's fully open source
* Good, because it aligns with our commitment to libre software
* Bad, because it requires more setup than some commercial alternatives

## Implementation Details

### CI/CD Pipeline Structure

Our CI/CD pipeline will consist of the following stages:

1. **Build and Test**
   - Compile code for multiple platforms
   - Run unit and integration tests
   - Generate code coverage reports

2. **Code Quality**
   - Run linters and formatters
   - Analyze code quality metrics
   - Check for code smells and anti-patterns

3. **Security Scanning**
   - Run SAST tools (Trivy, OpenGrep)
   - Check dependencies for vulnerabilities
   - Validate license compliance

4. **Documentation**
   - Build and verify documentation
   - Check for broken links
   - Validate API documentation

5. **Release**
   - Create release artifacts
   - Generate changelogs
   - Publish to distribution channels

### GitHub Actions Workflow Examples

```yaml
# Main CI workflow
name: CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, macos-latest, windows-latest]
        rust: [stable]
        node: [18]

    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Rust
      uses: actions-rs/toolchain@v1
      with:
        profile: minimal
        toolchain: ${{ matrix.rust }}
        override: true
        components: rustfmt, clippy
    
    - name: Setup Bun
      uses: oven-sh/setup-bun@v1
      with:
        bun-version: latest
    
    - name: Install dependencies
      run: |
        cargo fetch
        bun install
    
    - name: Build
      run: |
        cargo build --verbose
        bun run build
    
    - name: Test
      run: |
        cargo test --verbose
        bun test --coverage
    
    - name: Generate coverage report
      run: |
        # Install grcov for Rust coverage
        cargo install grcov
        
        # Configure environment for coverage collection
        export CARGO_INCREMENTAL=0
        export RUSTFLAGS="-Cinstrument-coverage"
        export LLVM_PROFILE_FILE="coverage-%p-%m.profraw"
        
        # Run tests with coverage instrumentation
        cargo test
        
        # Generate HTML coverage report
        grcov . --binary-path ./target/debug/ -s . -t html --branch --ignore-not-existing --ignore "/*" -o ./coverage/
        
    - name: Archive coverage results
      uses: actions/upload-artifact@v3
      with:
        name: coverage-report
        path: coverage/

  lint:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    
    - name: Lint Rust
      run: |
        rustup component add clippy
        cargo clippy -- -D warnings
    
    - name: Lint JavaScript
      run: bun run lint
    
    - name: Check formatting
      run: |
        cargo fmt -- --check
        bun run format:check

  security:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    
    - name: Run Trivy
      uses: aquasecurity/trivy-action@master
      with:
        scan-type: 'fs'
        format: 'table'
        exit-code: '1'
        severity: 'CRITICAL,HIGH'
    
    - name: Run OpenGrep
      uses: opengrep/opengrep-action@v1
      with:
        config: >-
          p/javascript
          p/rust
          p/owasp-top-ten

  compliance:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    
    - name: Run ORT
      uses: oss-review-toolkit/ort-ci-github-action@v1
      with:
        run-modes: "ANALYZER, SCANNER, EVALUATOR, REPORTER"
        allow-dynamic-versions: "true"
```

### Local Development Setup

To ensure consistency between local development and CI environments, we will provide:

1. **Pre-commit hooks** for linting and formatting
2. **Development container** configurations for VS Code and other IDEs
3. **Makefile** or equivalent for common development tasks
4. **Documentation** on setting up the local development environment

## Related Decisions

* [**ADR-0001** Primary Programming Language](adr-0001-primary-programming-language.md)
* [**ADR-0002** Linting and Formatting Tools](adr-0002-linting-and-formatting-tools.md)
* [**ADR-0003** Quality and Testing Tools](adr-0003-quality-and-testing-tools.md)
* [**ADR-0004** Release Management](adr-0004-release-management.md)
* [**ADR-0005** Security Vulnerability Scanning Tools](adr-0005-security-vulnerability-scanning-tools.md)
* [**ADR-0006** Supply Chain Security and License Compliance](adr-0006-supply-chain-security-and-license-compliance.md)
* [**ADR-0008** Package Management and Documentation](adr-0008-package-management-and-documentation.md)
* [**ADR-0009** Workspace Management](adr-0009-workspace-management.md)
* [**ADR-0012** Documentation Style](adr-0012-doc-style.md)

## External References

* [GitHub Actions Documentation](https://docs.github.com/en/actions)
* [Bun Documentation](https://bun.sh/docs)
* [grcov Documentation](https://github.com/mozilla/grcov)
* [cargo-tarpaulin Documentation](https://github.com/xd009642/tarpaulin)
* [Codacy Community Edition](https://github.com/codacy/codacy-analysis-cli)
* [Trivy Documentation](https://aquasecurity.github.io/trivy/)
* [OpenGrep Documentation](https://github.com/opengrep/opengrep)
* [OSS Review Toolkit Documentation](https://github.com/oss-review-toolkit/ort)
