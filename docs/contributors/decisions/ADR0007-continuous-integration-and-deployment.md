# ADR0002 - Toolkit selection

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

## Decision outcomes

Chosen options:

* **CI/CD: Github Actions + CircleCI**
* **Code Coverage and Insights: ????**
* **SAST: Trivy + OpenGrep**
* **Linting and formatting: Manually configured, individually selected linters**
* **Supply chain security & license compliance: AboutCode**

<!-- This is an optional element. Feel free to remove. -->
### Consequences

* Good, because {positive consequence, e.g., improvement of one or more desired qualities, …}
* Bad, because {negative consequence, e.g., compromising one or more desired qualities, …}
* … <!-- numbers of consequences can vary -->

<!-- This is an optional element. Feel free to remove. -->
### Confirmation

{Describe how the implementation / compliance of the ADR can/will be confirmed. Is there any automated or manual fitness function? If so, list it and explain how it is applied. Is the chosen design and its implementation in line with the decision? E.g., a design/code review or a test with a library such as ArchUnit can help validate this. Note that although we classify this element as optional, it is included in many ADRs.}

<!-- This is an optional element. Feel free to remove. -->
## Pros and Cons of the Options

### {title of option 1}

<!-- This is an optional element. Feel free to remove. -->
{example | description | pointer to more information | …}

* Good, because {argument a}
* Good, because {argument b}
<!-- use "neutral" if the given argument weights neither for good nor bad -->
* Neutral, because {argument c}
* Bad, because {argument d}
* … <!-- numbers of pros and cons can vary -->

### {title of other option}

{example | description | pointer to more information | …}

* Good, because {argument a}
* Good, because {argument b}
* Neutral, because {argument c}
* Bad, because {argument d}
* …

## More Information

* [**ADR0001** Primary Programming Language](ADR0001-primary-programming-language.md)
* [**ADR0003** Package management and documentation](ADR0003-package-management-and-documentation.md)
* [**ADR0004** Workspace management](ADR0004-workspace-management.md)
* [**ADR0007** Documentation style and linting tools](ADR0007-doc-style.md)
