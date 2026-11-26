# Development environments

Home Manager enables `direnv` and `nix-direnv` with Bash integration. The root
`.envrc` selects the default development shell. Run `direnv allow` once in the
repository after applying the configuration to trust that file. Install the
local checks with `nix develop --command pre-commit install`.

For another shell, copy its example into the repository root as `.envrc`, then
run `direnv allow` again:

```sh
cp examples/devshells/python/.envrc .envrc
direnv allow
```

The examples under `examples/devshells/` cover the default, JavaScript,
Python, and Unity shells. These files contain only `use flake` selectors and
do not load project secrets.

## Commit and tag signing

Git is configured to sign commits and tags with the public key at
`~/.ssh/id_ed25519.pub`. No key was present when this setting was added, so
create one before relying on automatic signing:

```sh
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519
```

Add the **public** key (`~/.ssh/id_ed25519.pub`) to GitHub under **Settings →
SSH and GPG keys → New SSH key → Signing key**. Keep the private key local and
never commit it. GitHub's guide covers [SSH commit signing](https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key).

After a release is ready, create an annotated signed version tag, for example:

```sh
git tag -s v1.4.0 -m "Wynn NixOS 1.4.0"
git verify-tag v1.4.0
```

Update `CHANGELOG.md` for each release before tagging. Version tags are local
until explicitly pushed.
