---
runme:
  id: 01JFHF2KCQMVP5JXDQQ4WBHG8T
  version: v3
---

# Code Signing Solution

## Status

- Status: Accepted
- Date: 20 December 2024
- Driver: @pfouilloux

## Context and problem statement

We need a code signing solution that works across multiple platforms (Windows, macOS, Linux) and is compatible with their respective app stores.
The solution needs to be cost-effective while maintaining security and reputation.

### Requirements

#### Must Have

- Free or very low cost
- Compatible with:
  - Windows Store
  - Mac App Store
  - Ubuntu/Debian repositories

- Secure and reputable Certificate Authority
- Cross-platform support

#### Nice to Have

- Well-documented setup process
- CircleCI integration
- Automated signing process
- Key management best practices
- Audit logging

## Decision outcomes

### Chosen Option: Sigstore + Platform-Required Certificates

We will use a combination of Sigstore for general code signing and platform-specific certificates where absolutely required.

#### Benefits

##### General Code Signing (Sigstore)

- Free and open source
- Keyless signing with OIDC identity
- Transparency log for verification
- Good CI/CD integration
- Strong community backing

##### Platform-Specific Benefits

- Windows: Official Microsoft Store presence
- macOS: Native app distribution
- Linux: Repository integration

### Implementation Details

#### Setup Requirements

- Sigstore CLI installation
- Platform developer accounts:
  - Microsoft Partner Center
  - Apple Developer Program
  - Ubuntu/Debian repository keys

#### Configuration

- CircleCI signing workflow
- Key management system
- Verification procedures
- Audit logging setup

### Risks and Mitigations

#### Risks

- Multiple signing systems complexity
- Key management overhead
- Cost of platform certificates
- Potential signing process failures

#### Mitigations

- Automated signing processes
- Secure key storage solutions
- Clear documentation
- Regular security audits

## Related Decisions

- [D0002: Integration with CI/CD toolkit](D0002-Toolkit.md)
- [D0004: Workspace management for signing keys](D0004-WorkspaceManagement.md)
- [D0006: Platform-specific installation signing](D0006-Installers.md)

## Future Growth Plan

1. **Phase 1 (Current)**:

   - Sigstore for general code signing
   - Platform-specific certs only where required
   - Basic automation and CI/CD integration

2. **Phase 2 (Growth)**:

   - Apply for SignPath open source certificate
   - Enhance automation and monitoring
   - Implement advanced security measures

3. **Phase 3 (Scale)**:

   - Evaluate enterprise signing solutions if needed
   - Expand security and compliance measures
   - Enhance monitoring and alerting

## Other options considered

### [SignPath](https://signpath.io/)

Code signing as a service - potential future solution

#### Pros

- Open source program available
- Good CI/CD integration
- Managed service
- Security features
- Audit logging

#### Cons

- Requires project recognition
- Initial setup complexity
- Limited free tier
- Platform limitations
- Migration effort required

### [Sigstore](https://www.sigstore.dev/)

Open source signing solution

#### Pros

- Free and open source
- Keyless signing
- Strong community
- Good CI/CD integration
- Transparency logs

#### Cons

- Newer solution
- Platform acceptance varies
- Requires OIDC provider
- Community support only
- Limited enterprise features

## Implementation Notes

### Windows Store

- Partner Center account required
- One-time registration fee
- Sigstore for initial code signing
- Plan migration path to SignPath

### Mac App Store

- Apple Developer Program required
- $99/year includes all certificates
- Automated notarization available
- Good tooling support

### Linux Repositories

- GPG key generation is free
- Repository hosting costs vary
- Good automation options
- Community tools available
