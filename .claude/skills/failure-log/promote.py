#!/usr/bin/env python3
"""FAILURES.md を解析し、再発パターンを集計してチームルール昇格候補を出力する。
書き込みは一切せず、レポートのみ行う read-only スクリプト。

2種類のエントリ形式を扱う:
  (1) 手動 / 人間観察由来:  kind + tags
  (2) 3エージェントハーネスのEvaluator由来: kind + verdict + checks(失敗したチェック種別)
グルーピング鍵は (kind, verdict, 失敗シグナル集合)。元記事の
「verdict + failed_checks の組み合わせ一致 / 同一kind」に対応する。

使い方:
    python3 promote.py [FAILURES.mdのパス]
    FAILURE_PROMOTE_THRESHOLD=3 python3 promote.py
"""
import os
import re
import sys
from collections import defaultdict

DEFAULT_PATH = ".claude/workspace/FAILURES.md"
THRESHOLD = int(os.environ.get("FAILURE_PROMOTE_THRESHOLD", "3"))

# kind -> 昇格先（プロジェクトに合わせて編集すること）
KIND_DESTINATION = {
    "handler": ".claude/rules/handlers.md",
    "usecase": ".claude/rules/usecases.md",
    "domain": ".claude/rules/domain.md",
    "infra": ".claude/rules/infrastructure.md",
    "repository": ".claude/rules/infrastructure.md",
    "migration": ".claude/rules/migration.md",
    "test": ".claude/rules/test.md",
    "gotest": ".claude/rules/test.md",
    "frontend": ".claude/rules/frontend.md",
    "general": "CLAUDE.md",
}

BLOCK_RE = re.compile(r"^##\s+(.*)$")
FIELD_RE = re.compile(r"^-\s*(kind|verdict|checks|tags|summary|fix)\s*:\s*(.*)$")


def _split_list(val):
    return [t.strip().lower() for t in val.split(",") if t.strip()]


def parse(path):
    with open(path, encoding="utf-8") as f:
        lines = f.read().splitlines()
    entries, cur = [], None
    for line in lines:
        m = BLOCK_RE.match(line)
        if m:
            if cur is not None:
                entries.append(cur)
            cur = {"header": m.group(1).strip(), "kind": "", "verdict": "",
                   "checks": [], "tags": [], "summary": "", "fix": "",
                   "promoted": "[PROMOTED" in m.group(1)}
            continue
        if cur is None:
            continue
        if "[PROMOTED" in line:
            cur["promoted"] = True
        fm = FIELD_RE.match(line.strip())
        if fm:
            key, val = fm.group(1), fm.group(2).strip()
            if key in ("checks", "tags"):
                cur[key] = _split_list(val)
            else:
                cur[key] = val
    if cur is not None:
        entries.append(cur)
    return entries


def signature(e):
    """グルーピング鍵を作る。checks(失敗チェック種別)とtagsを失敗シグナルとして束ねる。"""
    sig = set(e["tags"]) | {f"check:{c}" for c in e["checks"]}
    return (e["kind"], e["verdict"], frozenset(sig))


def header_date(header):
    m = re.match(r"(\d{4}-\d{2}-\d{2})", header)
    return m.group(1) if m else "?"


def label(verdict, sig):
    parts = []
    if verdict:
        parts.append(verdict)
    parts.append(", ".join(sorted(sig)) or "(no-signal)")
    return " / ".join(parts)


def main():
    path = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_PATH
    if not os.path.exists(path):
        print(f"FAILURES.md が見つからない: {path}")
        print("まだ失敗が記録されていない可能性が高い。/failure-log で蓄積してから再実行する。")
        return 0

    entries = [e for e in parse(path) if not e["promoted"] and e["kind"]]
    if not entries:
        print(f"未昇格の有効な失敗エントリが {path} に無い。")
        return 0

    groups = defaultdict(list)
    for e in entries:
        groups[signature(e)].append(e)

    # 補助: kind 内で頻出のシグナル（タグ/チェック種別）。パターンが割れている検知用。
    sig_count = defaultdict(lambda: defaultdict(int))
    for e in entries:
        for s in (set(e["tags"]) | {f"check:{c}" for c in e["checks"]}):
            sig_count[e["kind"]][s] += 1

    candidates = [(k, v) for k, v in groups.items() if len(v) >= THRESHOLD]
    candidates.sort(key=lambda kv: -len(kv[1]))

    print(f"=== 昇格候補（同一 kind + verdict + 失敗シグナルが {THRESHOLD} 件以上） ===\n")
    if not candidates:
        print(f"閾値 {THRESHOLD} 件に達したパターンは無い。\n")
    for i, ((kind, verdict, sig), es) in enumerate(candidates, 1):
        dates = sorted(header_date(e["header"]) for e in es)
        dest = KIND_DESTINATION.get(kind, "CLAUDE.md")
        print(f"### パターン {i}: [{kind}] {label(verdict, sig)}")
        print(f"- 検出回数: {len(es)}")
        print(f"- 最初の発生: {dates[0]} / 最後の発生: {dates[-1]}")
        print("- 代表的な fix:")
        seen = set()
        for e in es:
            f = e["fix"] or e["summary"]
            if f and f not in seen:
                print(f"    - {f}")
                seen.add(f)
        print(f"- 昇格先候補: `{dest}`（既存ルールに追記）")
        print()

    print(f"=== 参考: kind 内で {THRESHOLD} 回以上出現するシグナル（パターンが割れている可能性） ===\n")
    any_hot = False
    for kind, sigs in sorted(sig_count.items()):
        hot = {s: c for s, c in sigs.items() if c >= THRESHOLD}
        if hot:
            any_hot = True
            joined = ", ".join(f"{s}×{c}" for s, c in sorted(hot.items(), key=lambda x: -x[1]))
            print(f"- [{kind}] {joined}")
    if not any_hot:
        print("特になし。")
    return 0


if __name__ == "__main__":
    sys.exit(main())
