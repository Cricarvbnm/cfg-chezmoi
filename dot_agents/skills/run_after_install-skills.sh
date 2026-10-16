#!/usr/bin/env bash
# Run after `chezmoi apply` to keep user-selected skills installed via `npx skills`.
# Edit the `skills` array below to change which skills are synced across devices.
#
# Each entry is `pkg:skill`: the upstream `owner/repo` and the specific sub-skill
# to install from it. The package source-of-truth comes from
# `npx skills ls -g --json`; local-only skills (those with no `source`) are not
# listed here — they live elsewhere on the filesystem.

# Program name used as a prefix on every log line so output is identifiable
# even when this script's stderr is interleaved with `chezmoi apply`'s.
PROG='run_after_install-skills.sh'

# log LEVEL MESSAGE — write "<PROG>: <LEVEL>: <MESSAGE>" to stderr.
# All log lines should go through here; do not call `echo` directly.
log() {
  local level="$1"
  shift
  printf '%s: %s: %s\n' "$PROG" "$level" "$*" >&2
}

# Skip the script gracefully if npx itself is unavailable (e.g., on machines
# without node/npm). A missing npx should never break the rest of `chezmoi apply`.
# Still log at WARN — no npx is a real problem worth noticing.
if ! command -v npx >/dev/null 2>&1; then
  log WARN "npx not found; skipping skill bootstrap"
  exit 0
fi

# Curated skill list. Each entry is `pkg:sub-skill`. Re-run `npx skills ls -g --json`
# to refresh the list when the user's installed set changes.
skills=(
  xenitV1/Antigravity-Workflows:bash-linux
  anthropics/knowledge-work-plugins:documentation
  anthropics/skills:docx
  anthropics/skills:pdf
  anthropics/skills:skill-creator
  addyosmani/agent-skills:git-workflow-and-versioning
  mattpocock/skills:grill-with-docs
  Raw1mage/ytlite_i6plus:skill-finder
  useai-pro/openclaw-skills-security:skill-guard
  daymade/claude-code-skills:skill-reviewer
  softaworks/agent-toolkit:humanizer
  op7418/humanizer-zh:humanizer-zh
)

# Target agents. Edit this list to limit which agents receive skills.
# Each entry must be the kebab-case identifier the `skills` CLI expects
# (run `npx skills ls -g --json` to see what is currently detected).
# Using '*' would install to every detected agent and create symlinks in
# many places — keep this list tight to avoid filesystem pollution.
#
# Note: `npx skills` auto-detects *any* agent on the machine (e.g.
# github-copilot surfaces because of ~/.config/Code/.../github.copilot-chat
# even when you never actually use it). Listing only 'opencode' here means
# installs go to ~/.agents/skills/<skill>/ as the canonical copy and
# ~/.config/opencode/skills/<skill>/ as the agent-side link, with no
# accidental pollution of unrelated agent directories.
agents=(
  opencode
)

# Build the `-a` flag sequence as separate argv entries. We can't rely on
# `npx skills` to accept concatenated flags (it doesn't), so we build
# `(-a opencode)` etc. as discrete arguments below.
agent_args=()
for a in "${agents[@]}"; do
  agent_args+=( -a "$a" )
done

# Failures here are logged but non-fatal: a single broken skill should not stop
# `chezmoi apply`. The user can re-run the bootstrap after fixing the cause.
#
# Idempotency: `npx skills add` does not check whether the skill is already
# installed — it will happily re-clone, re-extract, and re-link on every
# invocation, which is wasteful on every `chezmoi apply`. So before each
# call we ask the filesystem: does the canonical sub-skill directory
# already exist under the global install root? If yes, skip the network
# round-trip entirely. (`npx skills install -g` always materializes the
# canonical at ~/.agents/skills/<sub>/, so its presence is the right
# signal.)
#
# Quiet-by-default: when nothing had to happen (every listed skill is
# already present and no failures occurred), the script emits no log lines
# at all — applying chezmoi on a machine that's already up-to-date should
# look silent. Per-skill skip lines are also silent; the loop only logs
# on failure (which skill was at fault) and the summary at the end only
# logs when at least one install or one failure actually happened.
installed_count=0
fail_count=0
for entry in "${skills[@]}"; do
  pkg="${entry%%:*}"
  sub="${entry#*:}"
  if [ -d "$HOME/.agents/skills/$sub" ]; then
    continue  # silently skipped
  fi
  # Flags:
  #   --skill <sub>     pin to the specific sub-skill of a multi-skill repo
  #   -g                install globally to ~/.agents/skills/ (instead of project)
  #   -y                skip the confirmation prompts (CI-/apply-safe)
  #   -a <agent>        one flag per entry in ${agents[@]}; never use '-afoo'
  #                     shorthand — npx skills only accepts '-a foo'.
  if ! npx skills add "$pkg" --skill "$sub" -g -y "${agent_args[@]}"; then
    log WARN "npx skills add '$pkg/$sub' failed"
    fail_count=$((fail_count + 1))
    continue
  fi
  installed_count=$((installed_count + 1))
done

# Summary only when something actually happened. "0 installed, 0 failed"
# means every listed skill was already present locally — keep quiet.
# Install successes and failures are independent signals, so each gets its
# own single-condition check rather than being folded into a 4-arm table.
if [ "$installed_count" -ne 0 ] || [ "$fail_count" -ne 0 ]; then
  if [ "$installed_count" -gt 0 ]; then
    log INFO "installed $installed_count skill(s)"
  fi
  if [ "$fail_count" -gt 0 ]; then
    log WARN "$fail_count skill install(s) failed; re-run chezmoi apply once the cause is fixed"
  fi
fi
