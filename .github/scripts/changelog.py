import re
import subprocess
import sys

SECTIONS = {
    "breaking": "Breaking Changes 🛠",
    "feat": "New Features 🏕",
    "fix": "Bugfixes 🐞",
    "perf": "Performance ⚡",
    "refactor": "Refactors 🧹",
    "revert": "Reverts ⏪",
    "docs": "Documentation 📖",
    "other": "Other Changes",
}

OTHER_TYPES = ("style", "test", "build", "ci", "chore")
TYPES = "|".join([key for key in SECTIONS if key not in ("breaking", "other")] + list(OTHER_TYPES))

PATTERN = re.compile(rf"^(?P<type>{TYPES})(?:\((?P<scope>[^()]+)\))?(?P<breaking>!)?: ?(?P<desc>\S.*)$", re.IGNORECASE)
BREAKING_FOOTER = re.compile(r"^BREAKING[ -]CHANGE: ", re.MULTILINE)
IGNORED = re.compile(r"^(prepare release|merge )", re.IGNORECASE)


def main():
    rev_range = sys.argv[1] if len(sys.argv) > 1 else "HEAD"
    commits = subprocess.run(
        ["git", "log", "--format=%h%x1f%s%x1f%b%x1e", rev_range],
        capture_output=True, text=True, check=True,
    ).stdout.split("\x1e")

    entries = {key: [] for key in SECTIONS}
    seen = set()
    for commit in commits:
        if not commit.strip():
            continue
        sha, subject, body = commit.lstrip("\n").split("\x1f", 2)
        match = PATTERN.match(subject.strip())
        if not match or IGNORED.match(match["desc"]):
            continue
        kind = match["type"].lower()
        desc = match["desc"].strip()
        if not re.search(r"\(#\d+\)$", desc):
            desc += f" ({sha})"
        key = re.sub(r"[^a-z0-9]", "", re.sub(r"\s*\((#\d+|[0-9a-f]+)\)$", "", desc).lower())
        if key in seen:
            continue
        seen.add(key)
        if match["breaking"] or BREAKING_FOOTER.search(body):
            section = "breaking"
        else:
            section = "other" if kind in OTHER_TYPES else kind
        scope = f"**{match['scope']}:** " if match["scope"] else ""
        entries[section].append(f"- {scope}{desc[0].upper()}{desc[1:]}")

    for key, title in SECTIONS.items():
        if entries[key]:
            print(f"### {title}\n")
            print("\n".join(entries[key]) + "\n")


if __name__ == "__main__":
    main()
