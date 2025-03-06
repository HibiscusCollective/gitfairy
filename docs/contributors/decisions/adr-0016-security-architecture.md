# **ADR-0016** Security Architecture

**Author**: @pfouilloux

![Accepted](https://img.shields.io/badge/status-accepted-green) ![20 December 2024](https://img.shields.io/badge/Date-20_Dec_2024-lightblue)

## Context and Problem Statement

We need a robust security architecture that protects user credentials and sensitive information on their local device.
The solution must integrate with platform security features and follow modern security practices.

## Decision Drivers

* Secure credential storage
* OAuth/SSH support
* Automatic updates
* Dependency management
* Security policy
* Security auditing
* Vulnerability scanning
* Threat modeling
* Bug bounty program
* Security notifications

## Considered Options

* OAuth + SSH + Platform Keychain + Automatic Updates
* Web-based Authentication
* Custom Credential Storage
* Manual Updates

## Decision Outcome

Chosen option: "OAuth + SSH + Platform Keychain + Automatic Updates", because it provides a comprehensive security architecture that leverages platform-specific features while maintaining cross-platform compatibility.

### Consequences

* Good, because it securely manages user credentials using platform-native solutions
* Good, because it supports multiple authentication methods (OAuth and SSH)
* Good, because it ensures timely security updates through automatic update mechanisms
* Good, because it maintains dependency security through automated scanning
* Bad, because it increases implementation complexity with multiple authentication methods
* Bad, because it requires management of OAuth client secrets

### Confirmation

Implementation will be confirmed through:
* Security audit of credential storage implementation
* Successful OAuth authentication flows with major Git providers
* Verification of SSH key management
* Testing of the automatic update process with signed packages
* Regular dependency vulnerability scanning

## Pros and Cons of the Options

### OAuth + SSH + Platform Keychain + Automatic Updates

* Good, because it leverages standardized authentication protocols
* Good, because it supports both web-based and key-based authentication
* Good, because it uses platform-native security features
* Good, because it ensures timely security updates
* Bad, because it requires management of OAuth client secrets
* Bad, because it increases implementation complexity

### Web-based Authentication

* Good, because it provides a familiar authentication flow
* Good, because it's easy to implement across platforms
* Good, because it follows standard protocols
* Bad, because it requires a server component
* Bad, because it's network dependent
* Bad, because it raises privacy concerns
* Bad, because it adds maintenance and cost overhead

### Custom Credential Storage

* Good, because it offers full control over implementation
* Good, because it works consistently across platforms
* Good, because it has minimal dependencies
* Bad, because it introduces security risks from custom implementations
* Bad, because it creates a maintenance burden
* Bad, because it doesn't leverage platform security benefits
* Bad, because it may reduce user trust

### Manual Updates

* Good, because it gives users control over update timing
* Good, because it's simple to implement
* Good, because it works offline
* Bad, because it delays critical security fixes
* Bad, because it creates version fragmentation
* Bad, because it increases support overhead

## More Information

### Authentication Implementation

#### OAuth Integration

```rust
use oauth2:{
    basic::BasicClient,
    AuthUrl,
    TokenUrl,
    RedirectUrl,
    ClientId,
    ClientSecret,
};

#[derive(Debug)]
pub struct GitProvider {
    name: String,
    oauth: BasicClient,
    scopes: Vec<String>,
}

impl GitProvider {
    pub fn new_github() -> Self {
        let oauth = BasicClient::new(
            ClientId::new(env!("GITHUB_CLIENT_ID").to_string()),
            Some(ClientSecret::new(env!("GITHUB_CLIENT_SECRET").to_string())),
            AuthUrl::new("https://github.com/login/oauth/authorize".to_string())
                .expect("Invalid authorization endpoint URL"),
            Some(TokenUrl::new("https://github.com/login/oauth/access_token".to_string())
                .expect("Invalid token endpoint URL")),
        );

        Self {
            name: "GitHub".to_string(),
            oauth,
            scopes: vec!["repo".to_string()],
        }
    }
}
```

#### SSH Support

```rust
use ssh2::Session;
use std::path::PathBuf;

#[derive(Debug)]
pub struct SSHConfig {
    key_path: PathBuf,
    known_hosts: PathBuf,
}

impl SSHConfig {
    pub fn from_system() -> Self {
        let home = dirs::home_dir().expect("Failed to get home directory");
        Self {
            key_path: home.join(".ssh").join("id_ed25519"),
            known_hosts: home.join(".ssh").join("known_hosts"),
        }
    }
}
```

### Credential Management

```rust
use keyring::Entry;
use serde::{Serialize, Deserialize};

#[derive(Debug, Serialize, Deserialize)]
pub struct Credential {
    service: String,
    username: String,
}

impl Credential {
    pub async fn store(&self, secret: &str) -> Result<(), keyring::Error> {
        let entry = Entry::new(&self.service, &self.username)?;
        entry.set_password(secret)
    }
}
```

### Update Management

```rust
use tauri::updater::{Update, UpdateResponse};

#[derive(Debug)]
pub struct UpdateConfig {
    pub current_version: String,
    pub update_url: String,
    pub signature_key: String,
}

impl UpdateConfig {
    pub async fn check_update(&self) -> Result<Option<Update>, Box<dyn std::error::Error>> {
        let response = UpdateResponse::new(&self.update_url).await?;
        if response.version > self.current_version {
            Ok(Some(response.verify(self.signature_key)?))
        } else {
            Ok(None)
        }
    }
}
```

### Dependency Management

```json
{
  "$schema": "https://docs.renovatebot.com/renovate-schema.json",
  "extends": [
    "config:base",
    ":semanticCommits",
    ":preserveSemverRanges"
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
    }
  ],
  "vulnerabilityAlerts": {
    "enabled": true,
    "labels": ["security"]
  }
}
```

### Security Measures

1. __Authentication__
   - OAuth 2.0 flow
   - SSH key management
   - Platform keychain
   - Session handling

2. __Data Protection__
   - Credential encryption
   - Secure storage
   - Memory protection
   - Cache clearing

3. __Update Security__
   - Code signing
   - Update verification
   - Rollback support
   - Delta updates

4. __Monitoring__
   - Dependency scanning
   - Security advisories
   - Update notifications
   - Error tracking

### Security and Privacy Policies

- [Security Policy](https://github.com/HibiscusCollective/.github/blob/main/docs/SECURITY.md)

### Related Decisions

- [ADR-0010: Code Signing](adr-0010-code-signing.md)
- [ADR-0011: Installers](adr-0011-installers.md)
- [ADR-0014: Error Handling and Logging](adr-0014-error-handling-and-logging.md)


