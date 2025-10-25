# Amazon Q CLI Context

For all code changes and questions:

1. Fetch latest documentation using Context7 when available
1. Find examples using GitHub MCP server inside repositories with a significant amount of stars, and with recent code changes/activity
1. Always return a list of links used to generate the response at the end

## Shadcn

For every code change, question, or installation related to Shadcn use the MCP server to get info and validate.

## React

For every code change related to React, once the task is completed run the following command and fix errors to ensure code quality:

```bash
bun run ts-check
```

then run:

```bash
bun run format
```
