# CloudAMQP Homebrew tap

## How do I install these formulae?

`brew install cloudamqp/cloudamqp/<formula>`

Or `brew tap cloudamqp/cloudamqp` and then `brew install <formula>`.

Or install via URL (which will not receive updates):

```
brew install https://raw.githubusercontent.com/cloudamqp/homebrew-cloudamqp/main/Formula/<formula>.rb
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).

## LavinMQ

Three channels are available, install only one:

| Channel     | Source                                                                | Command                                                |
| ----------- | --------------------------------------------------------------------- | ------------------------------------------------------ |
| Stable      | [homebrew-core](https://formulae.brew.sh/formula/lavinmq)             | `brew install lavinmq`                                 |
| Pre-release | This tap, latest `*-rc.*` / `*-beta.*` tag                            | `brew install cloudamqp/cloudamqp/lavinmq-prerelease`  |
| Nightly     | Built from `main` via the core formula's `head` block                 | `brew install --HEAD lavinmq`                          |

`lavinmq-prerelease` conflicts with `lavinmq` since both ship the same binaries.

## Updating formulas

A daily GitHub Actions workflow (`.github/workflows/bump.yml`) runs `brew bump`
against each formula and opens a PR when an upstream release is detected via
`brew livecheck`. It can also be triggered manually from the Actions tab, and
optionally limited to a single formula.

To bump a formula manually:

```shell
brew bump-formula-pr --no-fork --version=<version> <formula>
```

This will download the release tarball, compute the SHA256, update the formula, and create a PR.

## Development

How to test PRs/branches of this repo:

```shell
brew tap cloudamqp/cloudamqp
cd $(brew --repository cloudamqp/cloudamqp)
git checkout <branch name>
brew install <formula>
```

If you already have it tapped:

```shell
cd $(brew --repository cloudamqp/cloudamqp)
git fetch origin
git checkout <branch name>
brew reinstall <formula>
```
