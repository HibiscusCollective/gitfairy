---
runme:
  id: 01JFHR3HA0FSXEM5MR2GP7986P
  version: v3
---

# D0001 - Programming Language and Key Libraries

## Status

- Status: Accepted
- Date: 20 December 2024
- Driver: @pfouilloux

## Context and problem statement

What is the selected programming language the project will be built in?
The main pillars are:

- Performance, this has to feel snappy to use, cannot be less efficient than using the CLI.
- Security, this has to be secure and cannot be less secure than using the CLI.
- UX. It has to be way more simple and intuitive than using the CLI.

### Requirements

#### Must Have

- Multithreading/Async support: We want to let users queue up commands without noticeable lag between interactions, so things need to be able to run in the background.
- OS Integration: The interface should feel as native to the OS as possible. Leveraging things like context menu actions, popups, icons, etc. This should not feel like a separate app.
- Secure authentication: We want to make sure that the user can securely authenticate to the services they want to access. We don't want a permanent token saved in plaintext in a config file.
   We want to leverage modern security methods, like OAuth, keychains, etc.
- Git Integration: We need full featured git integration with support for extensions. Capabilities should be as close to CLI as possible.

#### Nice to Have

- Cross-platform support
- Rich ecosystem of libraries
- Strong type system
- Memory safety guarantees

## Decision outcomes

### Chosen Option: Rust

Rust was chosen as the primary programming language for this project due to its unique combination of performance, safety, and modern development features:

#### Benefits

- Zero-cost abstractions and minimal runtime overhead ensure optimal performance
- Memory safety guarantees without garbage collection
- Rich type system and ownership model prevent common bugs at compile time
- Excellent concurrency support through async/await and the ownership system
- Strong ecosystem for system programming and native OS integration
- Cross-platform compilation support
- Active and growing community with high-quality libraries

### Implementation Details

#### Key Libraries

- [tauri](https://tauri.app/) - Tauri will drive our UI components, popups, modals, configuration, etc.
- [tokio](https://tokio.rs/) - Tokio will drive our async capabilities.
- [git2](https://docs.rs/git2/latest/git2/) - We will use git2 to interact with VCS, this handles auth and all the git operations we'll need.
- [config](https://crates.io/crates/config) - We will use config to read and write configuration files. This gives us the flexibility to read and write different formats and layer them in various ways.

### Risks and Mitigations

#### Risks

- Learning curve: Rust has a steep learning curve, especially for developers new to systems programming
- Compilation times: Rust's powerful type system can lead to longer compilation times
- Limited pool of developers: Finding experienced Rust developers might be challenging
- Library maturity: Some libraries might not be as mature as their counterparts in other ecosystems
- Integration complexity: Native OS integration might require platform-specific code paths

#### Mitigations

- Invest in team training and documentation
- Carefully evaluate and test third-party libraries before adoption
- Implement proper build caching and optimization strategies

## Other options considered

### Go

Go was considered as a potential alternative due to its simplicity and strong concurrency model.

#### Pros

- Simple and easy to learn language
- Excellent concurrency with goroutines
- Fast compilation times
- Strong standard library
- Good cross-platform support

#### Cons

- Less fine-grained control over system resources
- Garbage collection might impact performance
- Less expressive type system
- Limited metaprogramming capabilities
- GUI framework ecosystem not as mature

### Python

Python was evaluated for its extensive ecosystem and development speed.

#### Pros

- Large ecosystem of libraries
- Rapid development and prototyping
- Excellent package management
- Strong community support
- Rich data science and automation tools

#### Cons

- Performance limitations due to interpreter
- GIL limits true multithreading
- Dynamic typing can lead to runtime errors
- Package distribution complexity
- Resource intensive for desktop applications

### NodeJS

NodeJS was considered for its strong GUI framework support and JavaScript ecosystem.

#### Pros

- Rich ecosystem for GUI development (Electron)
- Familiar to many developers
- Large package ecosystem (npm)
- Strong async programming model
- Active community

#### Cons

- Resource intensive (Electron apps)
- Less performant than native solutions
- Security concerns with npm dependencies
- Limited system-level programming capabilities
- Memory overhead

## Related Decisions

- [D0002: Toolkit selection affects language ecosystem integration](D0002-Toolkit.md)
- [D0003: Package management and documentation tooling for Rust](D0003-PackageAndDocs.md)
- [D0004: Workspace management for Rust development](D0004-WorkspaceManagement.md)
- [D0006: Platform-specific installation for Rust binaries](D0006-Installers.md)
