# git-cleanremote

Clean remote allows you clean up your remote branches

## Installation

Install the gem:

    $ gem install git-cleanremote

## Usage

cleanremote is used in the command line as a git extension. Once installed you can follow the instructions below.

```sh
Usage:
  git cleanremote [BRANCH_NAME]

Options:
  [--dryrun]
  [--version]
  [--ask]            # Default: true, will ask to delete the branches
  [--local]          # Default: false, deletes the local copy as well
  [--remote=REMOTE]  # Default: origin
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
