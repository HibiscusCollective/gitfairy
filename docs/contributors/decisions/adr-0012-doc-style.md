# **ADR-0012** Documentation Style and Linting

**Author**: @pfouilloux

![Accepted](https://img.shields.io/badge/status-accepted-success) ![20 December 2024](https://img.shields.io/badge/Date-20_Dec_2024-lightblue)

## Context and Problem Statement

We need to establish a consistent documentation style that is clear, inclusive, and maintainable.
The style must be accessible to non-native English speakers and support efficient translation workflows.

## Decision Drivers

* Clear guidelines for non-native English speakers
* Translation-friendly structure
* Inclusive language standards
* CI/CD linting integration
* Contributor-friendly rules
* IDE integration
* Automated fixes where possible
* Style consistency checks
* Readability metrics
* Translation memory support

## Considered Options

* RedHat Style Guide + Vale CLI
* Google Developer Documentation Style Guide
* Microsoft Style Guide
* Grammarly
* textlint

## Decision Outcome

Chosen option: "RedHat Style Guide + Vale CLI", because this combination provides clear, translation-optimized guidelines with flexible, automated enforcement.

### Consequences

* Good, because the RedHat Style Guide provides clear, concise guidelines
* Good, because it has a translation-optimized approach
* Good, because it focuses on technical documentation
* Good, because it is actively maintained
* Good, because it has wide industry adoption
* Good, because Vale CLI offers flexible rule configuration
* Good, because it supports multiple styles
* Good, because it has good CI/CD integration
* Good, because it is actively developed
* Good, because it has a strong community

### Confirmation

Implementation will be confirmed through:

* Successful integration of Vale CLI in the CI/CD pipeline
* Verification of documentation against the RedHat style guidelines
* Contributor feedback on usability
* Translation efficiency metrics
* Reduction in style inconsistencies over time

## Pros and Cons of the Options

### RedHat Style Guide + Vale CLI

This approach combines the RedHat Documentation Style Guide with Vale CLI for automated enforcement.

* Good, because the RedHat Style Guide provides clear, concise guidelines
* Good, because it has a translation-optimized approach
* Good, because it focuses on technical documentation
* Good, because it is actively maintained
* Good, because it has wide industry adoption
* Good, because Vale CLI offers flexible rule configuration
* Good, because it supports multiple styles
* Good, because it has good CI/CD integration
* Good, because it is actively developed
* Good, because it has a strong community
* Bad, because it has a learning curve for contributors
* Bad, because it may produce false positives in linting
* Bad, because it adds translation complexity
* Bad, because it creates maintenance overhead

### Google Developer Documentation Style Guide

A comprehensive style guide for technical documentation developed by Google.

* Good, because it has comprehensive coverage
* Good, because it is well-maintained
* Good, because it is an industry standard
* Good, because it provides clear examples
* Good, because it is suitable for technical content
* Bad, because it is complex for new contributors
* Bad, because it has less translation focus
* Bad, because some rules are too strict
* Bad, because it has Google-specific conventions
* Bad, because it has limited Vale integration

### Microsoft Style Guide

A style guide focused on clarity and accessibility for technical content.

* Good, because it has an accessibility focus
* Good, because it is translation friendly
* Good, because it receives regular updates
* Good, because it has a clear structure
* Good, because it provides good examples
* Bad, because it contains Microsoft-specific terms
* Bad, because it has complex voice rules
* Bad, because it has some dated conventions
* Bad, because it has limited Vale rules
* Bad, because it overlaps with other tools

### Grammarly

A commercial writing assistant with AI-powered suggestions.

* Good, because it is easy to use
* Good, because it provides real-time feedback
* Good, because it has good UI/UX
* Good, because it offers AI-powered suggestions
* Good, because it supports multiple style options
* Bad, because it is closed source
* Bad, because it has a subscription cost
* Bad, because it raises privacy concerns
* Bad, because it has limited CI/CD integration
* Bad, because it lacks custom rules

### textlint

An open-source linting tool for text and markdown.

* Good, because it is extensible
* Good, because it has a good plugin ecosystem
* Good, because it is open source
* Good, because it supports multiple languages
* Good, because it allows custom rule support
* Bad, because it has a complex setup
* Bad, because it is less maintained
* Bad, because it has limited IDE support
* Bad, because it has performance issues
* Bad, because it is redundant with Vale

## More Information

### Implementation Details

#### Style Guide Implementation

* Adopt RedHat style guide rules
* Create custom style extensions
* Document exceptions and overrides
* Provide quick reference guides

#### Vale Configuration

```yaml
StylesPath: styles
MinAlertLevel: suggestion
Vocab: GitFairy

Packages:
  RedHat: https://github.com/redhat-documentation/vale-at-red-hat
  alex: https://github.com/errata-ai/alex
  write-good: https://github.com/errata-ai/write-good
  Readability: https://github.com/errata-ai/readability

Formats:
BasedOnStyles:
  - RedHat
  - alex
  - write-good
  - Readability

# Customize alert levels
RedHat.Passive: warning
write-good.Weasel: suggestion
Readability.FleschKincaid: warning
alex.Ablist: error
```

#### CI/CD Integration

```yaml
documentation:
  stage: lint
  script:
    - vale sync
    - vale docs/**/*.md
  rules:
    - changes:
      - docs/**/*
      - .vale.ini
```

#### Translation Workflow

* Structured content guidelines
* Term glossary maintenance
* Translation memory setup
* Review process definition

### Style Priorities

1. **Clarity First**

   * Short sentences
   * Active voice
   * Simple words
   * Clear structure
   * Consistent terminology

2. **Translation Optimization**

   * Avoid idioms
   * Use standard punctuation
   * Maintain glossaries
   * Consistent formatting
   * Clear references

3. **Inclusive Language**

   * Gender-neutral terms
   * Cultural sensitivity
   * Accessibility awareness
   * Bias-free examples
   * Respectful terminology

### Contributor Guidelines

1. **Quick Start**

   * Install Vale CLI
   * Run local checks
   * Common fixes
   * Override examples
   * Style reference

2. **Advanced Usage**

   * Custom vocabulary
   * Rule configuration
   * Integration setup
   * Performance tips
   * Troubleshooting

### Risks and Mitigations

#### Risks

* Learning curve for contributors
* False positives in linting
* Translation complexity
* Maintenance overhead

#### Mitigations

* Comprehensive onboarding docs
* Regular rule refinement
* Translation tooling automation
* Clear update process

### Related Decisions

* [ADR-0002: Linting and Formatting Tools](adr-0002-linting-and-formatting-tools.md)
* [ADR-0008: Package Management and Documentation](adr-0008-package-management-and-documentation.md)
* [ADR-0009: Workspace Management](adr-0009-workspace-management.md)
