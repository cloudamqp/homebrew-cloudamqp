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

## Updating formulas

To update a formula to a new version:

```shell
./update_formula.sh <formula> <version>
```

For example:

```shell
./update_formula.sh lavinmq 2.6.9
./update_formula.sh amqpcat 1.0.3
./update_formula.sh sparoid 1.1.13
```

The script downloads the release tarball, computes the SHA256 checksum, and updates the formula file.

## Development

How to test PRs/branches of this repo:

```shell
brew tap cloudamqp/cloudamqp
cd $(brew --repository cloudamqp/cloudamqp)
git checkout <branch name>
brew install lavinmq
```

If you already have it tapped:

```shell
cd $(brew --repository cloudamqp/cloudamqp)
git fetch origin
git checkout <branch name>
brew reinstall lavinmq
```
