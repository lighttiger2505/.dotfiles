#!/usr/bin/env python3
"""3エージェントハーネスの Evaluator が出力した critique.json を読み、
verdict が NEEDS_REVISION / GENERATOR_FAILED のとき FAILURES.md に1ブロック追記する。
元記事の「Evaluator skill 末尾の post 処理」に相当する。

Evaluator skill の末尾でこう呼ぶ:
    python3 ${CLAUDE_SKILL_DIR}/scripts/log_from_critique.py <critique.jsonのパス>

オプション:
    --failures <path>   FAILURES.md のパス（既定 .claude/workspace/FAILURES.md）
    --kind <kind>       chunk_id から導けないときの kind 明示指定
    --branch <name>     ヘッダに載せるブランチ/feature 名
"""
import argparse
import json
import os
import subprocess
import sys
from datetime import datetime, timezone

LOG_VERDICTS = {"NEEDS_REVISION", "GENERATOR_FAILED"}

# chunk_id 接尾辞 -> kind。プロジェクトの chunk 命名に合わせて編集する。
SUFFIX_KIND = {
    "handler": "handler", "controller": "handler",
    "usecase": "usecase", "service": "usecase",
    "domain": "domain", "model": "domain", "entity": "domain",
    "infra": "infra", "repository": "infra", "repo": "infra",
    "migration": "migration",
    "test": "test", "gotest": "test", "rspec": "test", "spec": "test",
    "frontend": "frontend", "front": "frontend",
}


def derive_kind(chunk_id):
    if not chunk_id:
        return "general"
    suffix = chunk_id.rsplit("_", 1)[-1].lower()
    return SUFFIX_KIND.get(suffix, suffix if suffix.isalpha() else "general")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("critique")
    ap.add_argument("--failures", default=".claude/workspace/FAILURES.md")
    ap.add_argument("--kind", default=None)
    ap.add_argument("--branch", default=None)
    args = ap.parse_args()

    with open(args.critique, encoding="utf-8") as f:
        c = json.load(f)

    verdict = c.get("verdict", "UNKNOWN")
    if verdict not in LOG_VERDICTS:
        print(f"verdict={verdict} は記録対象外。スキップした。")
        return 0

    chunk_id = c.get("chunk_id", "")
    kind = args.kind or derive_kind(chunk_id)
    failed = [chk.get("type", "?") for chk in c.get("checks", [])
              if chk.get("result") in ("fail", "error")]
    fixes = c.get("required_fixes", []) or []
    details = [chk.get("detail", "") for chk in c.get("checks", [])
               if chk.get("result") in ("fail", "error") and chk.get("detail")]

    branch = args.branch
    if not branch:
        try:
            branch = subprocess.check_output(
                ["git", "branch", "--show-current"], text=True).strip() or "no-branch"
        except Exception:
            branch = "no-branch"

    ts = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M UTC")
    summary = details[0] if details else (fixes[0] if fixes else "（詳細なし）")
    fix = " / ".join(fixes) if fixes else "（required_fixes なし）"

    block = (
        f"\n## {ts} — {branch} / {chunk_id or 'unknown-chunk'}\n"
        f"- kind: {kind}\n"
        f"- verdict: {verdict}\n"
        f"- checks: {', '.join(failed) if failed else '(none)'}\n"
        f"- summary: {summary}\n"
        f"- fix: {fix}\n"
    )

    os.makedirs(os.path.dirname(args.failures) or ".", exist_ok=True)
    with open(args.failures, "a", encoding="utf-8") as f:
        f.write(block)

    print(f"FAILURES.md に追記した: [{kind}] {verdict} checks={failed}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
