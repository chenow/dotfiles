## osConfig Variable

The `osConfig` variable is a special parameter available in home-manager modules that provides access to the outer system configuration (nix-darwin configuration in this case).

#### How it works:

- **Automatic provision**: When home-manager runs as a nix-darwin module, it automatically provides `osConfig` to all home-manager modules
- **System-level access**: Contains the entire nix-darwin configuration, allowing home-manager modules to read system-level options
- **No manual setup**: Unlike other special arguments passed via `extraSpecialArgs`, `osConfig` is automatically available

#### Exampl

```nix
{ osConfig, ... }:

{
    home.file.".zshrc".text = ''
        # Set the default editor to the system-wide value
        export EDITOR="${osConfig.environment.variables.EDITOR or "vim"}"
    '';
}
```
