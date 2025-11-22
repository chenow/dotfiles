# LaTeX Agent and Resources

This document provides information about the LaTeX agent configuration.

## Context7 Libraries

Before making any code changes, use these Context7 library IDs for LaTeX documentation and best practices:

- `/latex3/latex3.github.io` - Official LaTeX3 documentation
- `/dspinellis/latex-advice` - Best practices for maintainable LaTeX code

## Commands

After making any changes related to LaTeX documents, always run the following commands to ensure code quality:

- `make` - Compile LaTeX documents. Fix any compilation warnings or errors that arise.
- `nix fmt` - Format Nix files involved in the LaTeX build process
