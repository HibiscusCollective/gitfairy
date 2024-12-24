# Contributing to Git Navi

We love your input! We want to make contributing to Git Navi as easy and transparent as possible, whether it's:

- Reporting a bug
- Discussing the current state of the code
- Submitting a fix
- Proposing new features
- Becoming a maintainer

## Development Process

We use GitHub to host code, to track issues and feature requests, as well as accept pull requests.

1. Fork the repo and create your branch from `main`
2. If you've added code, write tests. I'd suggest TDD, but that's up to you.
3. Unless the code change does not impact package APIs, documentation MUST be updated.
4. Ensure the test suite passes
5. Make sure your code follows the existing style
6. Issue that pull request!

Please try to keep pull requests small and focused on one thing alone. I'd rather review 10 small pull requests than 1 big one.
Large pull requests may be rejected without review. This is not a statement on the quality of the contribution, it's just a way to protect my time.
Please don't hesitate to resubmit the change as smaller PRs if that happens.

## Development Environment Options

We support two development environment setups to accommodate different preferences and needs.
Both options use the same package management tool (pixi) so they should stay in sync naturally.
When adding a new tool or dependency, ensure it is added using pixi if possible, then fallback to cargo or pnpm if necessary.
As a last resort using a pixi lifecycle hook to install the dependency is acceptable.

### 1. Pixi Shell (More performant)

- Faster setup and better performance
- Uses local system resources directly
- Install dependencies using `pixi install`
- Use `pixi run bootstrap` to set up a hook to enter the pixi environment whenever your shell enters the project directory.
- Perfect for solo development and when maximum performance is needed

### 2. Dev Container (Fully reproducible environment)

- Fully isolated and reproducible environment
- Works consistently across all systems
- Open in VS Code with Dev Containers extension or VSCodium/Windsurf with the DevPod Containers extension.
- Ideal for team collaboration and ensuring consistent environments

Choose the option that best fits your workflow and system requirements. Both approaches are fully supported.

## Any contributions you make will be under the project's license

In short, when you submit code changes, your submissions are understood to be under the same license that covers the project. Feel free to contact the maintainers if that's a concern.

## Report bugs using GitHub's [issue tracker](https://github.com/HibiscusCollective/gitfairy/issues)

We use GitHub issues to track public bugs. Report a bug by [opening a new issue](https://github.com/HibiscusCollective/gitfairy/issues/new).

## Write bug reports with detail, background, and sample code

**Great Bug Reports** tend to have:

- A quick summary and/or background
- Steps to reproduce
  - Be specific!
  - Give sample code if you can
- What you expected would happen
- What actually happens
- Notes (possibly including why you think this might be happening, or stuff you tried that didn't work)

## License

By contributing, you agree that your contributions will be licensed under its project license.
