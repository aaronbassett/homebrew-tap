# Homebrew Tap

A custom [Homebrew](https://brew.sh) tap for installing CLI tools by [@aaronbassett](https://github.com/aaronbassett).

## Adding This Tap

```bash
brew tap aaronbassett/tap
```

Once added, you can install any formula from this tap using `brew install`.

## Formulae

### Souk

A CLI tool for managing Claude Code plugin marketplaces.

```bash
brew install aaronbassett/tap/souk
```

**Current version:** 0.1.2 | **License:** MIT

For more information, see the [Souk repository](https://github.com/aaronbassett/souk).

---

### Agentbin

A CLI for publishing rendered documents at public URLs.

```bash
brew install aaronbassett/tap/agentbin
```

**Current version:** 0.1.1 | **License:** MIT

For more information, see the [Agentbin repository](https://github.com/aaronbassett/agentbin).

## Supported Platforms

All formulae provide pre-built binaries for:

| Platform | Architecture |
|----------|-------------|
| macOS    | Apple Silicon (arm64) |
| macOS    | Intel (x86_64) |
| Linux    | arm64 |
| Linux    | x86_64 |

## Updating

To update all formulae from this tap:

```bash
brew update
brew upgrade
```

Or update a specific formula:

```bash
brew upgrade aaronbassett/tap/souk
```