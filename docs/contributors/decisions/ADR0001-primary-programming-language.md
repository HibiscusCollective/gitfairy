# **ADR0001** Primary Programming Language

**Authors**: @pfouilloux

![Accepted](https://img.shields.io/badge/status-accepted-success) ![Date](https://img.shields.io/badge/Date-20_Dec_2024-lightblue)

## Context and problem statement

We need to establish a primary programming language that satisfies functional and non-functional requirements.
The main pillars are:

* Performance, this has to feel snappy to use, cannot be less efficient than using the CLI.
* Security, this has to be secure and cannot be less secure than using the CLI.
* UX. It has to be way more simple and intuitive than using the CLI.

## Decision Drivers

### Must Have

* Multithreading/Async support: We want to let users queue up commands without noticeable lag between interactions, so things need to be able to run in the background.
* OS Integration: The interface should feel as native to the OS as possible. Leveraging things like context menu actions, popups, icons, etc. This should not feel like a separate app.
* Secure authentication: We want to make sure that the user can securely authenticate to the services they want to access. We don't want a permanent token saved in plaintext in a config file.
   We want to leverage modern security methods, like OAuth, keychains, etc.
* Git Integration: We need full featured git integration with support for extensions. Capabilities should be as close to CLI as possible.

### Nice to Have

* Cross-platform support
* Rich ecosystem of libraries
* Strong type system
* Memory safety guarantees

## Decision outcomes

Chosen Option: **Rust with [tauri](https://tauri.app/), [tokio](https://tokio.rs/) , [git2](https://github.com/libgit2/libgit2) and [config](https://github.com/rust-lang/config)**

* [tauri](https://tauri.app/) will drive our UI components, popups, modals, configuration, etc.
* [tokio](https://tokio.rs/) will drive our async capabilities.
* [git2](https://docs.rs/git2/latest/git2/) will interact with VCS, this handles auth and all the git operations we'll need.
* [config](https://crates.io/crates/config) will read and write configuration files. This gives us the flexibility to read and write different formats and layer them in various ways.

## Consequences

* Good, because rust provides zero-cost abstractions and minimal runtime overhead ensure optimal performance
* Good, because rust guarantees memory safety without garbage collection
* Good, because rust's rich type system and ownership model prevent common bugs at compile time
* Good, because tokio provides excellent concurrency support through async/await and the ownership system
* Good, because of rust's strong ecosystem for system programming and native OS integration
* Good, because rust + cargo have full cross-platform compilation support
* Good, because of the active and growing community with high-quality libraries
* Bad, because rust has a steep learning curve, especially for developers new to systems programming
* Bad, because rust's powerful type system can lead to longer compilation times
* Bad, because finding experienced Rust developers might be challenging
* Bad, because some libraries might not be as mature as their counterparts in other ecosystems
* Bad, because native OS integration might require platform-specific code paths

## Pros and Cons of the Options

### Go

Go was considered as a potential alternative due to its simplicity and strong concurrency model.

* Good, because the language is simple and easy to learn
* Good, because of go's excellent concurrency support with goroutines
* Good, because of its fast compilation times
* Good, because of the strong standard library
* Good, because of cross-platform support
* Bad, because go has less fine-grained control over system resources
* Bad, because garbage collection might impact performance
* Bad, because go's type system is less expressive
* Bad, because of go's limited metaprogramming capabilities
* Bad, because the GUI framework ecosystem is not as mature

### Python

Python was evaluated for its extensive ecosystem and development speed.

* Good, because python has a large ecosystem of libraries
* Good, because python supports rapid development and prototyping
* Good, because of excellent package management via pip
* Good, because of strong community support
* Good, because of rich data science and automation tools
* Bad, because the performance limitations due to interpreter
* Bad, because GIL limits true multithreading
* Bad, because dynamic typing can lead to runtime errors
* Bad, because package distribution complexity
* Bad, because it's resource intensive for desktop applications

### NodeJS

NodeJS was considered for its strong GUI framework support and JavaScript ecosystem.

* Good, because electron has a rich ecosystem for GUI development (Electron)
* Good, because js/ts is familiar to many developers
* Good, because of the large and active package ecosystem (npm)
* Good, because of nodejs' strong async programming model
* Good, because of the active community
* Bad, because electron apps are resource intensive and less performant than native solutions
* Bad, because of security concerns with npm dependencies
* Bad, because nodejs has limited system-level programming capabilities
* Bad, because it has high memory overhead

## More information

* [**ADR0002** toolkit selection](ADR0002-toolkit.md)
* [**ADR0003** package management and documentation tooling for Rust](ADR0003-package-management-and-documentation.md)
* [**ADR0004** workspace management for Rust development](ADR0004-workspace-management.md)
* [**ADR0006** platform-specific installation for Rust binaries](ADR0006-installers.md)
