---
runme:
  id: 01JFH9A851HDNEBXGWRE1RS90Y
  version: v3
---

# D0002 - Toolkit selection

## Status

- Status: Accepted
- Date: 20 December 2024
- Driver: @pfouilloux

## Context and problem statement

We need to select a linting and or SAST toolkit, as well as a package manager and CI/CD pipeline (including local dev).
As modern projects are relatively complex, it is important that the pipeline support polyglot projects.
Modern projects are inherently polyglot even if this is limited to build pipelines, infrastructure config and tooling.

### Requirements

#### Must Have

- Documentation
- Code quality
- Security
- Typos
- Commits
- Changelogs
- Configuration
- Tests (Unit, integration and end-to-end)
- CI/CD
- Packaging
- Dashboards and reporting
- Modern, maintained and supported.
- Flexible and configurable.
- Minimal setup for new contributors.
- Polyglot and cross-platform.
- Integration with VSCode and other IDEs.
- Integration with CI/CD pipelines.

#### Nice to Have

- Fast local feedback
- Comprehensive reporting
- Multiple tool integration
- Custom rule support

## Decision outcomes

### Chosen Options

#### Linting and SAST

- Primary: MegaLinter
- IDE Integration: Trunk.io

**Rationale**: MegaLinter provides comprehensive checks suitable for CI/CD, while Trunk.io offers faster local feedback and better IDE integration.

#### CI/CD

- CircleCI

**Rationale**: CircleCI offers robust support for polyglot projects and integrates well with our chosen tools.

#### Code Coverage and Insights

- Deepsource.io

**Rationale**: Deepsource.io offers higher free limits and a more affordable paid plan compared to similar products.

#### Security Dashboard

- Arnica

**Rationale**: Arnica offers a generous free tier and is less limiting compared to other security dashboard options.

### Implementation Details

#### MegaLinter Configuration

- Configured for all supported languages
- Custom rules added for project-specific needs
- Integration with CircleCI pipeline

#### Trunk.io Setup

- Local IDE integration
- Fast feedback for developers
- Complementary to MegaLinter checks

#### CircleCI Pipeline

- Multi-stage pipeline for different checks
- Parallel execution where possible
- Comprehensive reporting

#### Deepsource.io Setup

- Integration with CircleCI pipeline
- Code coverage and insights reporting

#### Arnica Setup

- Integration with CircleCI pipeline
- Security dashboard and reporting

### Risks and Mitigations

#### Risks

- Tool complexity may slow down development
- Multiple tools may have conflicting rules
- Learning curve for new contributors

#### Mitigations

- Documentation of tool usage and configuration
- Regular review and update of rule sets
- Automated setup scripts for new contributors

## Other options considered

### Linting

#### [Super-Linter](https://github.com/github/super-linter)

##### Pros

- Multi-language support
- GitHub Actions integration
- Active maintenance
- Community support
- Docker-based deployment

##### Cons

- Slower execution time
- Resource intensive
- Limited IDE integration
- Complex configuration
- Docker dependency

#### Custom setup of individual linters

##### Pros

- Maximum flexibility
- Fine-grained control
- No external dependencies
- Better performance
- IDE-specific optimizations

##### Cons

- High maintenance overhead
- Complex configuration
- Inconsistent behavior
- Version management complexity
- Integration effort

### SAST

#### [CodeQL](https://codeql.github.com/)

##### Pros

- Deep semantic analysis
- GitHub integration
- Large rule database
- Active maintenance
- Good documentation

##### Cons

- GitHub-centric
- Resource intensive
- Limited language support
- Complex custom rules
- Learning curve

#### [Snyk CLI](https://github.com/snyk/cli)

##### Pros

- Easy integration
- Good vulnerability database
- Active maintenance
- Container scanning
- License compliance

##### Cons

- Limited free tier
- API dependency
- False positives
- Performance impact
- Limited customization

#### [Semgrep](https://github.com/semgrep/semgrep)

##### Pros

- Fast execution
- Easy custom rules
- Good documentation
- Active community
- Language agnostic

##### Cons

- Limited analysis depth
- False positives
- Enterprise features paywalled
- Limited IDE support
- Resource intensive

#### [Sonarqube](https://github.com/SonarSource/sonarqube)

##### Pros

- Comprehensive analysis
- Good visualization
- Quality metrics
- Team collaboration
- Rich ecosystem

##### Cons

- Resource intensive
- Complex setup
- Limited free tier
- Learning curve
- Maintenance overhead

#### [Shiftleft Scan](https://github.com/ShiftLeftSecurity/sast-scan)

##### Pros

- Multi-tool integration
- Easy CI/CD setup
- Good documentation
- Active maintenance
- Container support

##### Cons

- Limited customization
- Resource intensive
- Complex configuration
- Limited IDE support
- Dependency management

### CI/CD

#### [Jenkins](https://www.jenkins.io/)

##### Pros

- Highly customizable
- Rich plugin ecosystem
- Self-hosted option
- Active community
- Mature platform

##### Cons

- Complex setup
- Resource intensive
- Maintenance overhead
- UI/UX limitations
- Learning curve

#### [GitHub Actions](https://github.com/features/actions)

##### Pros

- GitHub integration
- Easy configuration
- Large marketplace
- Cloud-hosted
- Good documentation

##### Cons

- GitHub dependency
- Limited self-hosting
- Cost at scale
- Limited caching
- Platform lock-in

#### [GitLab CI](https://docs.gitlab.com/ee/ci/quick_start/)

##### Pros

- Integrated platform
- Container registry
- Self-hosted option
- Good documentation
- Pipeline visualization

##### Cons

- GitLab dependency
- Complex setup
- Resource intensive
- Limited marketplace
- Learning curve

### Code Coverage and Insights

#### [SonarCloud](https://sonarcloud.io/)

##### Pros

- Cloud-hosted
- Good visualization
- Quality metrics
- CI/CD integration
- Security analysis

##### Cons

- Limited free tier
- Complex setup
- False positives
- Performance impact
- Limited customization

#### [CodeClimate](https://codeclimate.com/)

##### Pros

- Quality metrics
- Good visualization
- GitHub integration
- Team collaboration
- Technical debt tracking

##### Cons

- Expensive pricing
- Limited customization
- Language limitations
- Complex setup
- Limited self-hosting

#### [Coveralls](https://coveralls.io/)

##### Pros

- Coverage visualization
- GitHub integration
- PR comments
- Historical tracking
- Team collaboration

##### Cons

- Limited features
- Basic metrics
- Cost at scale
- Limited customization
- Platform dependency

### Security Dashboard

#### [Snyk](https://snyk.io/)

##### Pros

- Vulnerability tracking
- License compliance
- Container scanning
- Good documentation
- Active updates

##### Cons

- Expensive pricing
- Limited free tier
- API dependency
- False positives
- Complex setup

#### [SonarQube](https://www.sonarqube.org/)

##### Pros

- Comprehensive analysis
- Self-hosted option
- Quality gates
- Team collaboration
- Good visualization

##### Cons

- Resource intensive
- Complex setup
- Limited free features
- Learning curve
- Maintenance overhead

## Related Decisions

- [D0001: Language choice affects available tooling](D0001-Language.md)
- [D0003: Package management integration with toolkit](D0003-PackageAndDocs.md)
- [D0004: Workspace management integration with toolkit](D0004-WorkspaceManagement.md)
- [D0007: Documentation style and linting tools](D0007-DocStyle.md)
