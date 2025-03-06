# **ADR-0015** UI/UX Standards

**Author**: @pfouilloux  
![Proposed](https://img.shields.io/badge/status-proposed-yellow) ![20 December 2024](https://img.shields.io/badge/Date-20_Dec_2024-lightblue)

## Context and Problem Statement

We need to establish UI/UX standards that provide a native feel across platforms while maintaining consistency and accessibility. The solution must support internationalization, accessibility compliance, and be testable through automated tools.

## Decision Drivers

* Native platform look and feel
* Accessibility compliance
* Internationalization support
* Component consistency
* Automated testing

## Considered Options

* Tauri + Leptos for UI framework and native integration
* React Native for cross-platform mobile integration
* Custom WebView for lightweight web technologies
* Qt for mature cross-platform desktop solutions

## Decision Outcome

Chosen option: "Tauri + Leptos for UI framework and native integration", because it provides native OS integration with a modern reactive framework, ensuring performance, type safety, and a small bundle size.

### Consequences

* Good, because it enables native platform integration with a consistent look and feel.
* Good, because it leverages the Rust ecosystem for type-safe and high-performance components.
* Bad, because it introduces additional dependencies and requires learning new frameworks.
* Bad, because it may limit design flexibility compared to more mature frameworks.

### Confirmation

Implementation will be confirmed through:
* Successful integration of UI components with Tauri and Leptos.
* Automated testing of accessibility and responsiveness.
* User feedback on the native look and feel.
* Performance benchmarks on different platforms.

## Pros and Cons of the Options

### Tauri + Leptos

* Good, because it provides native OS integration.
* Good, because it minimizes bundle size and ensures performance.
* Neutral, because it requires some adjustment from traditional web frameworks.
* Bad, because it introduces new dependencies.

### React Native

* Good, because of its large ecosystem.
* Good, because it supports cross-platform mobile development.
* Bad, because of potential JavaScript overhead and bundle size concerns.
* Bad, because it may not offer native desktop integration.

### Custom WebView

* Good, because it offers full control over the UI.
* Bad, because it might feel non-native.
* Bad, because of potential performance overhead.
* Bad, because it lacks deep OS integration.

### Qt

* Good, because it offers mature tooling and native widgets.
* Bad, because of licensing costs and a larger runtime.
* Bad, because of complex bindings with Rust.

## More Information

### UI Framework Strategy

#### Core Framework: Tauri + Leptos

__Rationale__: Tauri provides native OS integration while Leptos offers a modern reactive framework with server-side rendering capabilities.

##### Code Example

```rust
use leptos::*;
use tauri::*;

#[component]
fn NativeButton(
    #[prop(into)] text: String,
    #[prop(optional)] variant: Option<ButtonVariant>,
) -> impl IntoView {
    view! {
        <button
            class={move || format!("native-button {}", variant.unwrap_or_default())}
            aria-label={text.clone()}
        >
            {text}
        </button>
    }
}
```

### Design System

#### Platform-Native Components

__Rationale__: Leveraging platform-specific design guidelines ensures consistency with each operating system.

##### Implementation Details

- Windows: Fluent Design System
- macOS: SF Symbols and HIG
- Linux: Adherence to current desktop themes, with fallback to custom components

### Accessibility Standards

#### Implementation: Platform APIs + Leptonic

__Rationale__: Combining built-in accessibility features from Leptonic with direct OS API calls ensures comprehensive coverage.

##### Code Example

```rust
use tauri::api::system;
#[cfg(target_os = "windows")]
use windows::UI::Accessibility;
#[cfg(target_os = "macos")]
use cocoa::appkit::NSAccessibility;
#[cfg(target_os = "linux")]
use atspi::Accessible;

#[derive(Debug)]
pub enum PlatformAccessibility {
    #[cfg(target_os = "windows")]
    Windows(Accessibility),
    #[cfg(target_os = "macos")]
    MacOS(NSAccessibility),
    #[cfg(target_os = "linux")]
    Linux(Accessible),
}

impl PlatformAccessibility {
    pub fn announce(&self, message: &str) {
        match self {
            Self::Windows(a) => a.raise_notification(message),
            Self::MacOS(a) => a.post_notification(message),
            Self::Linux(a) => a.notify_screen_reader(message),
        }
    }
}
```

### Internationalization

#### Implementation: ICU4X + Fluent

__Rationale__: ICU4X supports comprehensive internationalization while Fluent provides a modern localization framework.

##### Code Example

```rust
use icu_locid::LanguageIdentifier;
use fluent::{FluentBundle, FluentResource};

#[derive(Debug)]
pub struct TranslationPipeline {
    source_locale: LanguageIdentifier,
    target_locales: Vec<LanguageIdentifier>,
    ai_service: Box<dyn TranslationService>,
    human_review: Option<Box<dyn ReviewService>>,
}
```

### Theme System

#### Implementation: CSS Custom Properties + Platform Detection

```css
.native-button {
    --button-radius: var(--platform-button-radius);
    --button-padding: var(--platform-button-padding);
    --button-font: var(--system-font);
    --button-transition: var(--standard-transition);
}
```

## Related Decisions

* [ADR-0001: Primary Programming Language](adr-0001-primary-programming-language.md)
* [ADR-0002: Toolkit](adr-0002-linting-and-formatting-tools.md)
* [ADR-0014: Error Handling and Logging](adr-0014-error-handling-and-logging.md)
