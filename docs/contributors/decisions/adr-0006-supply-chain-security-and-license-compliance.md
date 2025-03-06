# **ADR-0006** Supply Chain Security and License Compliance

**Author**: @pfouilloux

![Accepted](https://img.shields.io/badge/status-accepted-success) ![Date](https://img.shields.io/badge/Date-06_Mar_2025-lightblue)

## Context and Problem Statement

Modern software development heavily relies on third-party dependencies, which introduces potential security risks and legal obligations. We need to establish a comprehensive approach to managing supply chain security and ensuring license compliance across our codebase.

Specifically, we need to address:
1. How to verify the integrity and security of third-party dependencies
2. How to track and manage the licenses of all dependencies
3. How to automate compliance checking in our development workflow

## Decision Drivers

* Security of the software supply chain
* Legal compliance with open source licenses
* Compatibility with our chosen license
* Transparency for users and contributors
* Maintainability of dependency management
* Integration with existing CI/CD pipelines
* Developer experience and workflow impact
* Ability to respond to security incidents
* Compliance with industry standards and best practices

## Considered Options

* Manual dependency review and license tracking
* Dependency lockfiles with minimal automation
* Automated FOSS tools integration (REUSE, ORT, FOSSology, Renovate)
* Fully automated supply chain security and license compliance system
* Third-party compliance management service

## Decision Outcome

Chosen option: "Automated FOSS tools integration (REUSE, ORT, FOSSology, Renovate)", because it provides a highly automated approach using proven open source tools, ensuring both security and compliance while being feasible for a solo/small team project and working toward OpenChain compliance.

### Consequences

* Good, because it fully automates checks for known vulnerabilities and license issues
* Good, because it minimizes manual intervention, making it feasible for a solo project
* Good, because it integrates with our existing CI/CD pipeline
* Good, because it provides clear documentation of dependencies and licenses
* Good, because it automates dependency updates via Renovate
* Bad, because it requires initial setup of automation tools
* Bad, because it may occasionally require intervention for complex cases

## Pros and Cons of the Options

### Manual dependency review and license tracking

* Good, because it provides full control over dependency selection
* Good, because it ensures thorough review of each dependency
* Good, because it avoids false positives from automated tools
* Bad, because it is time-consuming and not scalable
* Bad, because it is prone to human error
* Bad, because it may lead to inconsistent reviews
* Bad, because it lacks continuous monitoring

### Dependency lockfiles with minimal automation

* Good, because it ensures reproducible builds
* Good, because it prevents unexpected dependency changes
* Good, because it has minimal workflow impact
* Bad, because it lacks proactive security monitoring
* Bad, because it provides limited license compliance checking
* Bad, because it may lead to outdated dependencies

### Automated FOSS tools integration (REUSE, ORT, FOSSology, Renovate)

* Good, because it maximizes automation with minimal human intervention
* Good, because it scales with project growth
* Good, because it provides continuous monitoring
* Good, because it integrates with existing workflows
* Good, because it uses established FOSS tools aligned with our values
* Good, because it supports OpenChain compliance efforts
* Good, because it automates dependency updates with Renovate
* Bad, because it may produce false positives requiring occasional intervention
* Bad, because it requires initial tool setup and configuration
* Bad, because automated updates may occasionally break compatibility

### Fully automated supply chain security and license compliance system

* Good, because it minimizes human intervention
* Good, because it provides consistent enforcement
* Good, because it enables rapid response to vulnerabilities
* Bad, because it may block legitimate dependencies
* Bad, because it requires significant setup and maintenance
* Bad, because it may disrupt development workflow
* Bad, because it lacks nuanced decision-making

### Third-party compliance management service

* Good, because it leverages specialized expertise
* Good, because it reduces internal maintenance burden
* Good, because it often includes comprehensive reporting
* Bad, because it introduces external dependencies
* Bad, because it may have significant costs
* Bad, because it may not integrate well with our specific stack
* Bad, because it may require sharing sensitive code information

## More Information

### Implementation Details

**Supply Chain Security Tools**

1. **Dependency Verification**
   - Use checksums and lock files for all dependencies
   - Implement Cargo's `Cargo.lock` and npm's `package-lock.json`
   - Verify package signatures where available
   - Use OSS Review Toolkit (ORT) for dependency analysis

2. **Continuous Monitoring and Updates**
   - Implement [Renovate](https://github.com/renovatebot/renovate) for automated dependency updates
   - Configure security advisories monitoring
   - Set up automated dependency update PRs with customized schedules
   - Use ORT's vulnerability scanner integration
   - Configure auto-merge for minor and patch updates that pass tests

3. **Build Reproducibility**
   - Use deterministic builds
   - Document build environment requirements
   - Implement containerized builds

**License Compliance Tools**

1. **REUSE Compliance**
   - Implement [REUSE](https://reuse.software/) specification for license information
   - Add SPDX headers to all source files
   - Maintain a `LICENSES/` directory with all license texts
   - Use `reuse` tool to verify compliance
   ```bash
   # Install REUSE tool
   pip install reuse
   
   # Check compliance
   reuse lint
   ```

2. **License Scanning and Analysis**
   - Use [OSS Review Toolkit (ORT)](https://github.com/oss-review-toolkit/ort) for comprehensive scanning
   ```bash
   # Run ORT analyzer
   ort analyze -i path/to/project -o ort-results
   
   # Run ORT evaluator
   ort evaluate -i ort-results/analyzer-result.yml -o ort-results
   ```
   - Use [FOSSology](https://www.fossology.org/) for deeper license analysis when needed
   ```bash
   # Run FOSSology analysis
   fossology-cli -p "Project Name" path/to/source
   ```

3. **License Compatibility Checking**
   - Maintain an allowed licenses list
   - Use ORT's policy evaluator to check against allowed licenses
   - Document license compatibility matrix

4. **License Documentation**
   - Generate SBOM (Software Bill of Materials) using ORT
   - Use REUSE to maintain proper license attribution
   - Generate comprehensive license notices with ORT reporter

**CI/CD Integration**

```yaml
# GitHub Actions workflow example
name: Supply Chain Security & License Compliance

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
  schedule:
    - cron: '0 0 * * 0'  # Weekly on Sundays

jobs:
  dependency-review:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
      
      - name: Dependency Review
        uses: actions/dependency-review-action@v2
        with:
          fail-on-severity: high
  
  reuse-compliance:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
      
      - name: REUSE Compliance Check
        uses: fsfe/reuse-action@v1
  
  ort-analysis:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
      
      - name: Run ORT
        uses: oss-review-toolkit/ort-ci-github-action@v1
        with:
          run-modes: "ANALYZER, SCANNER, EVALUATOR, REPORTER"
          allow-dynamic-versions: "true"
          output-directory: "ort-results"
      
      - name: Upload ORT Results
        uses: actions/upload-artifact@v3
        with:
          name: ort-results
          path: ort-results

  renovate:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
        
      - name: Self-hosted Renovate
        uses: renovatebot/github-action@v39.0.5
        with:
          configurationFile: renovate.json
          token: ${{ secrets.RENOVATE_TOKEN }}
```

**Approved License List**

- MIT
- Apache 2.0
- BSD (2-clause and 3-clause)
- ISC
- Zlib

**Licenses Requiring Review**

- LGPL (any version)
- MPL (any version)
- EPL (any version)

**Prohibited Licenses**

- GPL (any version)
- AGPL (any version)
- SSPL
- Proprietary licenses

**OpenChain Compliance**

We will work toward [OpenChain](https://www.openchainproject.org/) compliance as a long-term goal, which includes:

1. Establishing a FOSS policy
2. Competence in FOSS license compliance
3. Awareness of FOSS license compliance requirements
4. Delivering FOSS license compliance artifacts
5. Understanding FOSS community engagement
6. Adhering to the OpenChain Specification

**Automated Dependency Management with Renovate**

```json
// renovate.json
{
  "extends": [
    "config:base"
  ],
  "packageRules": [
    {
      "matchUpdateTypes": ["minor", "patch"],
      "matchCurrentVersion": "!/^0/",
      "automerge": true
    },
    {
      "matchDepTypes": ["devDependencies"],
      "automerge": true
    },
    {
      "matchPackagePatterns": ["eslint", "prettier"],
      "groupName": "linters",
      "automerge": true
    }
  ],
  "vulnerabilityAlerts": {
    "enabled": true,
    "labels": ["security"],
    "assignees": ["@project-owner"]
  },
  "lockFileMaintenance": { "enabled": true, "automerge": true },
  "prConcurrentLimit": 5,
  "prHourlyLimit": 2,
  "schedule": ["every weekend"]
}
```

**Automated Review Process**

1. Automated tools flag dependencies with:  
   - Security vulnerabilities (high/critical auto-rejected)
   - Non-approved licenses (prohibited licenses auto-rejected)
   - Missing license information

2. Renovate creates PRs for updates with appropriate labels

3. CI pipeline runs compliance checks on all PRs

4. Exceptions documented automatically in dependency exception list

5. Scheduled compliance reports generated weekly

### Related Decisions

* [**ADR-0001** Primary Programming Language](adr-0001-primary-programming-language.md)
* [**ADR-0004** Release Management](adr-0004-release-management.md)
* [**ADR-0005** Security Vulnerability Scanning Tools](adr-0005-security-vulnerability-scanning-tools.md)

### External References

* [REUSE Specification](https://reuse.software/spec/)
* [OSS Review Toolkit](https://github.com/oss-review-toolkit/ort)
* [FOSSology](https://www.fossology.org/)
* [OpenChain Specification](https://www.openchainproject.org/specification)
* [Renovate](https://github.com/renovatebot/renovate)
* [SPDX License List](https://spdx.org/licenses/)