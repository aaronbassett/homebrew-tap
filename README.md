# Homebrew Tap

Personal [Homebrew](https://brew.sh) tap for [Aaron Bassett's](https://github.com/aaronbassett) command-line tools.

> [!TIP]
> A Homebrew tap is a third-party repository of formulae. This tap contains tools that aren't in the official Homebrew repository, allowing you to install them with the standard `brew install` command.

## Available Formulae

| Formula | Repository | Version | Updated |
|---------|------------|---------|---------|
| [paneful](Formula/paneful.rb) | [aaronbassett/paneful](https://github.com/aaronbassett/paneful) | 0.1.2 | 2026-01-22 |

## Usage

### Add this tap

```bash
brew tap aaronbassett/tap
```

### Browse available formulae

```bash
brew search aaronbassett/tap
```

### Install a formula

Install directly (tap is added automatically if needed):

```bash
brew install aaronbassett/tap/<formula>
```

Or if the tap is already added:

```bash
brew install <formula>
```

### Manage installed formulae

List everything installed from this tap:

```bash
brew list --full-name | grep aaronbassett/tap
```

View formula info:

```bash
brew info aaronbassett/tap/<formula>
```

### Update

Fetch the latest formula versions from this tap:

```bash
brew update
```

Upgrade a specific formula:

```bash
brew upgrade <formula>
```

Upgrade all formulae installed from this tap:

```bash
brew upgrade $(brew list --full-name | grep aaronbassett/tap)
```

### Uninstall

```bash
brew uninstall <formula>
```

### Remove this tap

```bash
brew untap aaronbassett/tap
```
