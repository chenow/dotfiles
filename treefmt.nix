{pkgs, ...}: {
  # Used to find the project root
  projectRootFile = "flake.nix";
  programs = {
    alejandra.enable = true;
    yamlfmt.enable = true;
    stylua.enable = true;
    mdformat.enable = true;
  };
}
