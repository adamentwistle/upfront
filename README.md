# Upfront

A [Claude Code output style](https://code.claude.com/docs/en/output-styles) that puts the answer at the top.

Every reply opens with where your task stands and closes with what, if anything, you need to do. What sits in between has to earn its place.

## What changes

| | Default | Upfront |
| --- | --- | --- |
| First line | What Claude is about to do, or your question restated | `Done.` / `Partly done.` / `Blocked.` / `Not started.` plus the result |
| Last line | A summary of what was just said | What you need to do, or that nothing is needed |
| The middle | Every step taken, in order | Only what changes a decision, cost real time or money, surprised you, or needs action |
| Abbreviations | Freely used | Spelled out on first use; plain words preferred |
| Sentences | Multi-clause | One idea each |

Code, commands, file paths, error messages, and numbers are reproduced exactly. Conditions never widen and numbers never round.

## Before and after

A real status report, 3,176 characters as sent:

> **Patch 0005 is proven in production.** This is the thing three sessions could not get, and it arrived on the third fire, at 22:39:14 UTC.
>
> **What happened.** The sales desk ran this in the cron fire: [...] It meant that as a presence check, and it isn't one. `${VAR:+yes}` gives `yes`, but `${VAR:-no}` returns **the variable's value** when set [...]
>
> *(four more sections follow: the raw output, four numbered proofs, two carry-forwards, and a closing question)*

The same message under Upfront:

> **Done. The credential masker works.** It caught a real access token in live output at 22:39 and stored none of it.
>
> One thing worth knowing: the check for "is this variable set" is written wrong, and it prints the whole token every time it runs. The masker hides it, so nothing leaked, but the check should be fixed.
>
> Nothing needed from you. Say go and I'll close this out.

## Install

```sh
git clone https://github.com/adamentwistle/upfront.git
cd upfront
./install.sh
```

Then run `/config`, choose **Output style**, and pick **Upfront**. It takes effect after `/clear` or the next session.

For one project only, copy `output-styles/upfront.md` into that project's `.claude/output-styles/`.

## What it doesn't do

**Ask for depth and brevity switches off.** "Explain it properly", "walk me through it", "why did that happen" - those get everything: each decision, number, threshold, condition, and risk, in the same plain words. Being brief there is the failure.

**A requested artefact ships bare.** Ask for a commit message and you get the commit message. Nothing above it, nothing below it.

**Warnings come first and in full.** Anything destructive, irreversible, security-relevant, or expensive gets plain complete sentences before the status line.

## Known limits

Claude Code re-reminds itself of its built-in output styles every turn, but not custom ones, so a custom style can fade in a long session. [smixs/awesome-claude-output-styles](https://github.com/smixs/awesome-claude-output-styles) ships a `UserPromptSubmit` hook that closes the gap if you need it.

Output styles apply to the main conversation only. Subagents run their own system prompt.

## Prior art

Written after four writing-style skills failed to fix the problem. All of them improved sentences without changing what went into the message: [nbj-write-clearly](https://github.com/daniel-p-green/nbj-write-clearly), [gdoc](https://github.com/molly-mint-choco/google-developer-documentation-style-skill), [communicate-clearly](https://github.com/Dowwie/communicate-clearly), and [unslop](https://github.com/Vuk97/unslop).

The structure owes a debt to Barbara Minto's Pyramid Principle and to Axios Smart Brevity, both packaged as styles in [smixs/awesome-claude-output-styles](https://github.com/smixs/awesome-claude-output-styles). The plain-words rules draw on ASD-STE100 Simplified Technical English.

MIT licensed.
