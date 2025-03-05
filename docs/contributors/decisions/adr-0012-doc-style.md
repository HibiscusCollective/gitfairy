# Documentation Style and Linting

## Status

- Status: Accepted
- Date: 20 December 2024
- Driver: @pfouilloux

## Context and problem statement

We need to establish a consistent documentation style that is clear, inclusive, and maintainable.
The style must be accessible to non-native English speakers and support efficient translation workflows.

### Requirements

#### Must Have

- Clear guidelines for non-native English speakers
- Translation-friendly structure
- Inclusive language standards
- CI/CD linting integration
- Contributor-friendly rules

#### Nice to Have

- IDE integration
- Automated fixes where possible
- Style consistency checks
- Readability metrics
- Translation memory support

## Decision outcomes

### Chosen Option: RedHat Style Guide + Vale CLI

We will use the RedHat Documentation Style Guide with Vale CLI for enforcement.

#### Benefits

##### RedHat Style Guide

- Clear, concise guidelines
- Translation-optimized approach
- Technical documentation focus
- Active maintenance
- Wide industry adoption

##### Vale CLI

- Flexible rule configuration
- Multiple style support
- Good CI/CD integration
- Active development
- Strong community

### Implementation Details

#### Style Guide Implementation

- Adopt RedHat style guide rules
- Create custom style extensions
- Document exceptions and overrides
- Provide quick reference guides

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

- Structured content guidelines
- Term glossary maintenance
- Translation memory setup
- Review process definition

### Risks and Mitigations

#### Risks

- Learning curve for contributors
- False positives in linting
- Translation complexity
- Maintenance overhead

#### Mitigations

- Comprehensive onboarding docs
- Regular rule refinement
- Translation tooling automation
- Clear update process

## Related Decisions

- [D0002: Linting and Formatting Tools](adr-0002-linting-and-formatting-tools.md)
- [D0008: Package Management and Documentation](adr-0008-package-management-and-documentation.md)
- [D0009: Workspace Management](adr-0009-workspace-management.md)

## Other options considered

### [Google Developer Documentation Style Guide](https://developers.google.com/style)

#### Pros

- Comprehensive coverage
- Well-maintained
- Industry standard
- Clear examples
- Good for technical content

#### Cons

- Complex for new contributors
- Less translation focus
- Some rules too strict
- Google-specific conventions
- Limited Vale integration

### [Microsoft Style Guide](https://learn.microsoft.com/style-guide/welcome/)

#### Pros

- Accessibility focus
- Translation friendly
- Regular updates
- Clear structure
- Good examples

#### Cons

- Microsoft-specific terms
- Complex voice rules
- Some dated conventions
- Limited Vale rules
- Overlap with other tools

### [Grammarly](https://www.grammarly.com/)

#### Pros

- Easy to use
- Real-time feedback
- Good UI/UX
- AI-powered suggestions
- Multiple style options

#### Cons

- Closed source
- Subscription cost
- Privacy concerns
- Limited CI/CD integration
- No custom rules

### [textlint](https://textlint.github.io/)

#### Pros

- Extensible
- Good plugin ecosystem
- Open source
- Multiple language support
- Custom rule support

#### Cons

- Complex setup
- Less maintained
- Limited IDE support
- Performance issues
- Redundant with Vale

## Implementation Notes

### Style Priorities

1. **Clarity First**

   - Short sentences
   - Active voice
   - Simple words
   - Clear structure
   - Consistent terminology

2. **Translation Optimization**

   - Avoid idioms
   - Use standard punctuation
   - Maintain glossaries
   - Consistent formatting
   - Clear references

3. **Inclusive Language**

   - Gender-neutral terms
   - Cultural sensitivity
   - Accessibility awareness
   - Bias-free examples
   - Respectful terminology

### Contributor Guidelines

1. **Quick Start**

   - Install Vale CLI
   - Run local checks
   - Common fixes
   - Override examples
   - Style reference

2. **Advanced Usage**

   - Custom vocabulary
   - Rule configuration
   - Integration setup
   - Performance tips
   - Troubleshooting
