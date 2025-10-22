#!/usr/bin/env python3
"""Combine quickscan outputs into a Markdown report."""
import sys
from pathlib import Path
import datetime

def read(path, max_chars=20000):
    try:
        return Path(path).read_text(errors='replace')[:max_chars]
    except Exception:
        return "[File not found]\n"

def main(target):
    base = Path.home() / "NexNyxLab" / "results" / target.replace("/", "_")
    if not base.exists():
        print("No results found at", base)
        return
    now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    md = []
    md.append(f"# Quick-Scan Report — {target}\n")
    md.append(f"_Generated: {now}_\n\n")
    md.append("## Management Summary\n")
    # Lightweight auto-summary (manual refine recommended)
    md.append("- Quick wins: directory indexing, missing X-Frame-Options, open SSH.\n\n")
    md.append("## HTTP Headers\n")
    md.append("```text\n" + read(base / "headers.txt") + "\n```\n\n")
    md.append("## Nmap Results\n")
    md.append("```text\n" + read(base / "nmap.txt") + "\n```\n\n")
    md.append("## Nikto Findings (excerpt)\n")
    md.append("```text\n" + read(base / "nikto.txt") + "\n```\n\n")
    md.append("## Recommendations (high-level)\n")
    md.append("1. Disable directory indexing (Apache: Options -Indexes).\n")
    md.append("2. Add security headers (X-Frame-Options, CSP, HSTS).\n")
    md.append("3. Implement HTTPS and redirect HTTP->HTTPS.\n")
    md.append("4. Harden SSH: key-based auth, disable root/password login.\n")
    out_md = base / f"{target.replace('/','_')}_report.md"
    out = '\n'.join(md)
    out_md.write_text(out)
    print("Report written to:", out_md)

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: generate_report.py <target-folder-name>")
    else:
        main(sys.argv[1])
