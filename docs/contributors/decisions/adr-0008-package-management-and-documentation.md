---
runme:
  id: 01JFHR5K0GVYWPA9DZDZN90K80
  version: v3
---

# D0008 - Package Management and Documentation

## Status

- Status: Accepted
- Date: 20 December 2024
- Driver: @pfouilloux

## Context and problem statement

We need to select appropriate tools for package management, git hooks management, and documentation that can serve both contributor and user needs.
The solution must provide fast and reliable package management, consistent development environment, and clear separation between contributor and user documentation.

### Requirements

#### Must Have

##### Package Management

- Fast installation and updates
- Reliable dependency resolution
- Support for multiple package sources
- Good caching mechanism
- Cross-platform support

##### Git Hooks

- Easy to configure and maintain
- Cross-platform compatibility
- Support for multiple languages
- Parallel execution capability
- Local override support

##### Documentation

- Easy to write and maintain
- Support for multiple output formats
- Good search functionality
- Version control friendly
- Clear separation of user/contributor docs

#### Nice to Have

- Integration with IDEs
- Custom plugin support
- Analytics and monitoring
- Automated dependency updates
- Performance optimization tools

## Decision outcomes

### Chosen Options

#### Package Management: Pixi + PNPM

__Rationale__: Pixi provides fast and reliable package management, while PNPM offers efficient node_modules handling for development tooling.

##### Benefits

- Fast, reliable package management with Pixi
- Conda-forge access for system dependencies
- PNPM's efficient node_modules handling for dev tools
- Cross-platform compatibility
- Excellent caching mechanisms

#### Git Hooks: Lefthook

__Rationale__: Lefthook offers a simple, maintainable approach to git hooks with good cross-platform support.

##### Benefits

- Simple YAML configuration
- Parallel execution support
- Local overrides capability
- Cross-platform compatibility
- Good integration with our existing tools

#### Documentation: CodeBerg Wiki + mdBook

__Rationale__: CodeBerg Wiki provides a collaborative platform for contributor documentation, while mdBook offers a maintainable solution for user documentation.

##### Benefits

- Easy contribution through CodeBerg's wiki interface
- Beautiful, searchable user documentation with mdBook
- Single source of truth with docs synced from wiki
- Offline documentation support
- Version-controlled documentation
- Multi-format output support

### Implementation Details

#### Package Management Setup

- Pixi configuration
- PNPM setup for development tooling
- Cross-platform scripts
- Cache configuration
- CI/CD integration

#### Git Hooks Configuration

- Lefthook setup
- Custom hook development
- Integration with CI/CD
- Local override documentation
- Performance optimization

#### Documentation Structure

- User guide section
- API documentation
- Contributing guidelines
- Architecture documentation
- Search integration

### Risks and Mitigations

#### Risks

- Dual Package Manager Complexity: Managing two package managers requires clear guidelines
- Documentation Sync: Need to maintain synchronization between wiki and mdBook
- Learning Curve: Contributors need to learn multiple tools
- Migration Challenges: Future migrations might be complex due to tool-specific features
- Integration Effort: Need to integrate documentation workflow with CI/CD

#### Mitigations

- Comprehensive onboarding docs
- Hook execution optimization
- Documentation automation
- Platform-specific testing
- Dependency audit process

## Related Decisions

- [ADR 0001: Primary Programming Language](adr-0001-primary-programming-language.md)
- [ADR 0002: Linting and Formatting Tools](adr-0002-linting-and-formatting-tools.md)
- [ADR 0009: Workspace Management](adr-0009-workspace-management.md)
- [ADR 0012: Documentation Style](adr-0012-doc-style.md)
