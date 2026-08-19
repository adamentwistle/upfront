# Status First

A [Claude Code output style](https://code.claude.com/docs/en/output-styles) that makes every reply open with where your task stands and close with what, if anything, you need to do.

It exists because agent replies drift toward narrating the work instead of reporting it. You asked for a task; what comes back is the investigation. Status First inverts that: the status is the message, and the detail has to earn its place.

## What it changes

| | Default | Status First |
| --- | --- | --- |
| First line | What Claude is about to do, or a restatement of your question | `Done.` / `Partly done.` / `Blocked.` / `Not started.` plus the result |
| Last line | A summary of what was just said | What you need to do, or that nothing is needed |
| The middle | Every step taken, in order | Only what changes a decision, cost real time or money, surprised you, or needs action |
| Abbreviations | Freely used | Spelled out on first use; plain words preferred throughout |
| Sentences | Multi-clause | One idea each |

Code, commands, file paths, error messages, and numbers are reproduced exactly. Conditions never widen and numbers never round.

## Before and after

A real status report on a credential-masking patch, 3,176 characters as sent:

> **Patch 0005 is proven in production.** This is the thing three sessions could not get, and it arrived on the third fire, at 22:39:14 UTC.
>
> **What happened.** The sales desk ran this in the cron fire: […] It meant that as a presence check, and it isn't one. `${VAR:+yes}` gives `yes`, but `${VAR:-no}` returns **the variable's value** when set […]
>
> *(continues for four more sections: the raw output, four numbered proofs, two carry-forwards, and a closing question)*

The same message under Status First:

> **Done. The credential masker works.** It caught a real Gmail access token in live output at 22:39 and stored none of it.
>
> One thing worth knowing: the sales desk's own check for "is this variable set" is written wrong, and it prints the whole token every time it runs. The masker hides it, so nothing leaked, but the check should be fixed.
>
> Nothing needed from you. Say go and I'll close this out: stop the watch, update the tracker, sync both handover copies, and write the next prompt.

## Install

```sh
git clone https://github.com/adamentwistle/status-first.git
cd status-first
./install.sh
```

Or copy the file yourself:

```sh
mkdir -p ~/.claude/output-styles
cp output-styles/status-first.md ~/.claude/output-styles/
```

Then run `/config`, choose **Output style**, and pick **Status First**. It takes effect after `/clear` or the next session.

To use it in one project only, copy the file into that project's `.claude/output-styles/` instead.

## What it doesn't do

**Brevity is off when you ask for depth.** "Explain it properly", "walk me through it", "why did that happen" — those get the full answer: every decision, number, threshold, condition, and risk, in the same plain words. Being brief there is the failure, not the discipline.

**A requested artefact ships bare.** Ask for a commit message and you get the commit message. No status line above it, no offer to revise it below it.

**Warnings come first and in full.** Anything destructive, irreversible, security-relevant, or expensive gets plain complete sentences before the status line.

## Known limits

Claude Code re-reminds itself of its built-in output styles on every turn, but not custom ones — a custom style is placed in the system prompt once at session start. In long sessions the voice can fade. A `UserPromptSubmit` hook that re-emits the reminder each turn closes that gap; [smixs/awesome-claude-output-styles](https://github.com/smixs/awesome-claude-output-styles) ships one that works with any custom style.

Output styles apply to the main conversation only. Subagents run their own system prompt, so their replies are unaffected.

## Prior art

Status First was written after testing four existing writing-style skills, all of which improved sentences without changing what went into the message:

- [nbj-write-clearly](https://github.com/daniel-p-green/nbj-write-clearly) and [gdoc](https://github.com/molly-mint-choco/google-developer-documentation-style-skill) — the Google developer documentation style guide, aimed at documents
- [communicate-clearly](https://github.com/Dowwie/communicate-clearly) — the same guide adapted to conversation, the closest of the four
- [unslop](https://github.com/Vuk97/unslop) — a linter and hooks that strip chatbot padding

The structural half owes a debt to Barbara Minto's Pyramid Principle and to Axios Smart Brevity, both of which appear as output styles in [smixs/awesome-claude-output-styles](https://github.com/smixs/awesome-claude-output-styles). The plain-words half draws on ASD-STE100 Simplified Technical English.

## Licence

MIT. See [LICENSE](LICENSE).
