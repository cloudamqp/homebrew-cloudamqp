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
