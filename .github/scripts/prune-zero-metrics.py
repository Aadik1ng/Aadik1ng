#!/usr/bin/env python3
"""Remove zero-value and empty sections from lowlighter metrics SVG output."""

from __future__ import annotations

import re
import sys
from pathlib import Path


def field_text(block: str) -> str:
    text = re.sub(r"<[^>]+>", " ", block)
    return re.sub(r"\s+", " ", text).strip()


def should_remove_field(block: str) -> bool:
    text = field_text(block)
    if not text:
        return True
    if text == "Unexpected error":
        return True
    if text == "No license preference":
        return True
    if re.match(r"^0\b", text):
        return True
    if "Member of 0" in text:
        return True
    if "Sponsoring 0" in text:
        return True
    if re.search(r"\b0 <small>", block):
        return True
    return False


def prune_field_blocks(content: str) -> str:
    pattern = re.compile(r'<div class="field[^"]*">.*?</div>', re.DOTALL)
    return pattern.sub(lambda match: "" if should_remove_field(match.group(0)) else match.group(0), content)


def prune_sections(content: str) -> str:
    patterns = [
        r'<section>\s*<h2 class="field">[\s\S]*?followup-title[\s\S]*?</section>\s*<div class="column largeable">[\s\S]*?</div>\s*</div>',
        r'<section class="habits">[\s\S]*?</section>',
        r'<section>\s*<h2 class="field">[\s\S]*?Starred topics[\s\S]*?</section>',
        r'<section>\s*<h2 class="field">[\s\S]*?Languages[\s\S]*?</section>\s*<section class="column">\s*<h3[^>]*>Most used languages[\s\S]*?</section>',
    ]
    for pattern in patterns:
        content = re.sub(pattern, "", content, flags=re.DOTALL)
    return content


def prune_empty_repository_section(content: str) -> str:
    return re.sub(
        r'<section>\s*<h2 class="field">[\s\S]*?Repository[\s\S]*?</section>',
        "",
        content,
        count=1,
        flags=re.DOTALL,
    )


def main() -> int:
    path = Path(sys.argv[1])
    content = path.read_text(encoding="utf-8")
    content = prune_field_blocks(content)
    content = prune_sections(content)
    content = prune_empty_repository_section(content)
    path.write_text(content, encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
