# Coding Agent Context

## Context7 Libraries

Use these library IDs for documentation:

- `/websites/react_dev` - React reference
- `/websites/typescriptlang` - TypeScript
- `/websites/tailwindcss` - Tailwind CSS
- `/websites/tanstack_router` - TanStack Router
- `/websites/tanstack_query` - TanStack Query
- `/colinhacks/zod` - Zod validation
- `/vitejs/vite` - Vite
- `/react-hook-form/documentation` - React Hook Form
- `/axios/axios-docs` - Axios HTTP client
- `/websites/djangoproject_en_6_0` - Django
- `/websites/django-rest-framework` - Django REST Framework
- `/websites/django-filter_readthedocs_io_en_stable` - Django Filter
- `/beda-software/drf-writable-nested` - DRF Writable Nested
- `/astral-sh/uv` - uv package manager

# React

For every code changes of a react codebase, run the following command at the end to check that changes are correct:
`cd <frontend_dir> && bun run ts-check`. You MUST run this exact command.

## Shadcn

For every code change, question, or installation related to Shadcn use the MCP server to get info and validate.

## Stripe

Use the Stripe MCP server for payment-related questions and implementations.

IMPORTANT: Use `search_stripe_documentation` tool instead of Context7
