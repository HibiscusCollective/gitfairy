# **ADR-0004** Release Management

**Author**: @pfouilloux

![Accepted](https://img.shields.io/badge/status-accepted-success) ![Date](https://img.shields.io/badge/Date-20_Dec_2024-lightblue)

## Context and Problem Statement

We need a robust release management strategy that automates versioning and changelog generation while maintaining high quality standards.
The solution must support GitOps workflows and provide clear release criteria.

## Decision Drivers

* Automated semantic versioning
* Conventional commits support
* Changelog automation
* GitOps workflow integration
* Security release handling
* Release notes generation
* Migration guides (nice to have)
* Beta channels (nice to have)
* Release metrics (nice to have)
* Rollback procedures (nice to have)

## Considered Options

* Manual Release Process
* Release Trains
* Continuous Deployment
* Changesets with GitOps Workflow

## Decision Outcome

Chosen option: "Changesets with GitOps Workflow", because it provides a comprehensive solution for version management and changelog generation while supporting automated releases based on commit types and security requirements.

### Consequences

* Good, because it automates version management and changelog generation
* Good, because it supports GitOps workflows
* Good, because it provides clear release criteria
* Good, because it handles security releases appropriately
* Bad, because it may introduce complexity in the release process
* Bad, because it requires additional tooling and configuration

## Pros and Cons of the Options

### Changesets with GitOps Workflow

* Good, because it automates version bumps based on conventional commits
* Good, because it generates comprehensive changelogs with minimal effort
* Good, because it integrates seamlessly with CI/CD pipelines
* Good, because it supports monorepo architectures with interdependent packages
* Good, because it provides a clear audit trail for all changes
* Good, because it enables immediate security patch releases
* Good, because it reduces human error in version management
* Bad, because it requires developers to learn the changeset format
* Bad, because it adds an additional step to the PR process
* Bad, because it may require custom configuration for complex projects

### Manual Release Process

* Good, because it provides direct control
* Good, because it allows flexible timing
* Good, because it has a simple workflow
* Good, because it enables visual verification
* Good, because it allows easy rollback
* Bad, because it introduces human error risk
* Bad, because it is time consuming
* Bad, because it can be inconsistent
* Bad, because it has poor automation
* Bad, because it can lead to version conflicts

### Release Trains

* Good, because it provides a predictable schedule
* Good, because it enables feature batching
* Good, because it promotes team alignment
* Good, because it establishes clear deadlines
* Good, because it facilitates version planning
* Bad, because it can cause release delays
* Bad, because it may hold back features
* Bad, because it can create schedule pressure
* Bad, because it requires complex branching
* Bad, because it can lead to integration challenges

### Continuous Deployment

* Good, because it enables fast delivery
* Good, because it provides quick feedback
* Good, because it has a simple process
* Good, because code is always releasable
* Good, because it enforces automated testing
* Bad, because it introduces quality risks
* Bad, because it can lead to version chaos
* Bad, because it may cause user fatigue
* Bad, because it is resource intensive
* Bad, because it can create stability concerns

## More Information

### Implementation Details

#### Version Management with Changesets

[Changesets](https://github.com/changesets/changesets) provides a comprehensive solution for version management and changelog generation.

```jsonc
// .changeset/config.json
{
  "$schema": "https://unpkg.com/@changesets/config@2.3.1/schema.json",
  "changelog": "@changesets/cli/changelog",
  "commit": false,
  "fixed": [],
  "linked": [],
  "access": "public",
  "baseBranch": "main",
  "updateInternalDependencies": "patch",
  "ignore": ["*-test", "*-example"],
  "___experimentalUnsafeOptions_WILL_CHANGE_IN_PATCH": {
    "onlyUpdatePeerDependentsWhenOutOfRange": true
  }
}
```

#### Release Automation with GitOps Workflow

```yaml
name: Release Management

on:
  push:
    branches: [main]
  schedule:
    - cron: '0 9 * * 1'  # Monday 9 AM UTC

jobs:
  version:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Check Conventional Commits
        uses: wagoid/commitlint-github-action@v5
        
      - name: Create Release PR
        uses: changesets/action@v1
        with:
          version: pnpm changeset version
          commit: "chore: update versions"
          title: "chore: version packages"
          
  security_release:
    if: github.event.security_advisory.severity in ['HIGH', 'CRITICAL']
    runs-on: ubuntu-latest
    steps:
      - name: Trigger Security Release
        run: |
          echo "Security advisory severity: ${{ github.event.security_advisory.severity }}"
          # Trigger immediate release
```

#### Version Criteria

1. **Major Version (1.x.x)**
   * Breaking changes
   * API modifications
   * Major UI changes
   * Immediate release

2. **Minor Version (x.1.x)**
   * New features
   * Non-breaking changes
   * Deprecations
   * Weekly release batch

3. **Patch Version (x.x.1)**
   * Bug fixes
   * Security patches
   * Documentation
   * Immediate for security/hotfix

#### Release Schedule

##### Pre-1.0.0 Phase

* No fixed schedule
* Release on significant features
* Security patches immediate
* Version updates per PR

##### Post-1.0.0 Phase

* Weekly releases (Monday)
* Security patches immediate
* Hotfixes immediate
* Major versions immediate
* Minor versions batched

#### Changelog Management with Conventional Commits

```javascript
// .commitlintrc.js
module.exports = {
  extends: ['@commitlint/config-conventional'],
};
```

#### Release Process

1. **Version Update**
   * PR merged to main
   * Conventional commit check
   * Changeset creation
   * Version bump

2. **Release Criteria**
   * Security advisory severity
   * Commit type analysis
   * Weekly schedule check
   * Version threshold

3. **Release Actions**
   * Build verification
   * Asset generation
   * Signature creation
   * Distribution upload

4. **Post Release**
   * Changelog update
   * Documentation sync
   * Version notification
   * Monitoring period

### Related Decisions

* [**ADR-0010** Code Signing](adr-0010-code-signing.md)
* [**ADR-0016** Security Architecture](adr-0016-security-architecture.md)
* [**ADR-0017** Performance Requirements](adr-0017-performance-requirements.md)
