---
description: Automates browser interactions for web testing, form filling, screenshots, and data extraction
allowed-tools: Bash
---

# playwright-cli

Browser automation CLI tool.

## Quick Start

```bash
playwright-cli open https://example.com/
playwright-cli snapshot
playwright-cli click e3
```

## Core Workflow

1. `open` to navigate to a page
2. `snapshot` to get element refs
3. `click`, `fill`, `type` to interact

## Commands

### Core

```bash
playwright-cli open <url>              # open url
playwright-cli close                   # close the page
playwright-cli click <ref>             # perform click
playwright-cli fill <ref> <text>       # fill text
playwright-cli type <text>             # type text
playwright-cli snapshot                # capture page snapshot
playwright-cli screenshot [ref]        # take screenshot
```

### Sessions

```bash
playwright-cli --session=<name> open <url>  # open with named session
playwright-cli session-stop-all             # stop all sessions
```

### DevTools

```bash
playwright-cli tracing-start           # start trace recording
playwright-cli tracing-stop            # stop trace recording
playwright-cli console [min-level]     # list console messages
```
