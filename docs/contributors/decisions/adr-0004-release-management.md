---
runme:
  id: 01JF28KQMZ8P4XVBT6M6QQJ556
  version: v3
---

# D0004 - Release Management

## Status

- Status: Accepted
- Date: 20 December 2024
- Driver: @pfouilloux

## Context and problem statement

We need a robust release management strategy that automates versioning and changelog generation while maintaining high quality standards.
The solution must support GitOps workflows and provide clear release criteria.

### Requirements

#### Must Have

- Automated semver
- Conventional commits
- Changelog automation
- GitOps workflow
- Security releases
- Release notes

#### Nice to Have

- Migration guides
- Beta channels
- Release metrics
- Rollback procedures

## Decision outcomes

### Version Management

#### Implementation: Changesets

__Rationale__: [Changesets](https://github.com/changesets/changesets) provides a comprehensive solution for version management and changelog generation.

##### Configuration

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

### Release Automation

#### GitOps Workflow

__Rationale__: Automated releases based on commit types and security requirements.

##### Release Triggers

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

### Version Criteria

#### Automatic Version Bumps

1. __Major Version (1.x.x)__
   - Breaking changes
   - API modifications
   - Major UI changes
   - Immediate release

2. __Minor Version (x.1.x)__
   - New features
   - Non-breaking changes
   - Deprecations
   - Weekly release batch

3. __Patch Version (x.x.1)__
   - Bug fixes
   - Security patches
   - Documentation
   - Immediate for security/hotfix

### Release Schedule

#### Pre-1.0.0 Phase

- No fixed schedule
- Release on significant features
- Security patches immediate
- Version updates per PR

#### Post-1.0.0 Phase

- Weekly releases (Monday)
- Security patches immediate
- Hotfixes immediate
- Major versions immediate
- Minor versions batched

### Changelog Management

#### Conventional Changelog Integration

```javascript
// .commitlintrc.js
module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'scope-enum': [2, 'always', [
      'core',
      'ui',
      'git',
      'security',
      'perf',
      'deps'
    ]],
    'type-enum': [2, 'always', [
      'feat',
      'fix',
      'docs',
      'style',
      'refactor',
      'perf',
      'test',
      'build',
      'ci',
      'chore',
      'revert',
      'security'
    ]]
  }
};
```

## Implementation Notes

### Release Process

1. __Version Update__
   - PR merged to main
   - Conventional commit check
   - Changeset creation
   - Version bump

2. __Release Criteria__
   - Security advisory severity
   - Commit type analysis
   - Weekly schedule check
   - Version threshold

3. __Release Actions__
   - Build verification
   - Asset generation
   - Signature creation
   - Distribution upload

4. __Post Release__
   - Changelog update
   - Documentation sync
   - Version notification
   - Monitoring period

## Related Decisions

- [ADR 0010: Code Signing](adr-0010-code-signing.md)
- [ADR 0016: Security Architecture](adr-0016-security-architecture.md)
- [ADR 0017: Performance Requirements](adr-0017-performance-requirements.md)

## Other options considered

### Manual Release Process

#### Pros

- Direct control
- Flexible timing
- Simple workflow
- Visual verification
- Easy rollback

#### Cons

- Human error risk
- Time consuming
- Inconsistent
- Poor automation
- Version conflicts

### Release Trains

#### Pros

- Predictable schedule
- Feature batching
- Team alignment
- Clear deadlines
- Version planning

#### Cons

- Release delay
- Feature holdback
- Schedule pressure
- Complex branching
- Integration challenges

### Continuous Deployment

#### Pros

- Fast delivery
- Quick feedback
- Simple process
- Always releasable
- Automated testing

#### Cons

- Quality risk
- Version chaos
- User fatigue
- Resource intensive
- Stability concerns
