#!/usr/bin/env bash
# porto (/workspace) の .claude/worktrees/<name> 配下で、ホスト側 git の
# worktree prune によって admin dir (/workspace/.git/worktrees/<name>) が
# 消えた worktree を機械的に修復する。
#
# 修復方針:
#   1. gitdir/commondir/HEAD を再構築する
#   2. HEAD は "worktree-<name>" ブランチがあればそれを指す
#      (`git worktree add` 時の既定命名規約)
#   3. 無ければ、worktree ディレクトリの mtime に最も近い develop のコミットへ
#      detached HEAD を張る (非破壊: 復元後の `git status` が実差分を教えてくれる)
#   4. openapi submodule の admin dir も同様に再構築する
#   5. `git read-tree HEAD` で index を復元する
#   6. 再発防止のため `git worktree lock` を張る
#
# 何も削除・上書きしない。admin dir が既に揃っている (HEAD が読める) worktree は
# スキップする。ブランチの当て推量が必要だった worktree は最後にまとめて警告する
# ので、内容を見て残すか消すかは別途判断すること。
set -euo pipefail

REPO=/workspace
WORKTREES_DIR="$REPO/.claude/worktrees"
GITDIR="$REPO/.git"

if [ ! -d "$WORKTREES_DIR" ]; then
  echo "no $WORKTREES_DIR, nothing to do" >&2
  exit 0
fi

repaired=()
guessed=()
skipped_ok=()
skipped_missing=()

for wt in "$WORKTREES_DIR"/*/; do
  name=$(basename "$wt")
  wt="${wt%/}"

  if [ ! -f "$wt/.git" ]; then
    skipped_missing+=("$name")
    continue
  fi

  admin="$GITDIR/worktrees/$name"
  if [ -f "$admin/HEAD" ] && [ -f "$admin/gitdir" ]; then
    skipped_ok+=("$name")
    continue
  fi

  echo "== repairing $name =="

  mkdir -p "$admin"
  printf '%s\n' "$wt/.git" > "$admin/gitdir"
  printf '%s\n' '../..' > "$admin/commondir"

  branch="worktree-$name"
  if git -C "$REPO" show-ref --verify --quiet "refs/heads/$branch"; then
    printf 'ref: refs/heads/%s\n' "$branch" > "$admin/HEAD"
    echo "  HEAD -> branch $branch (見つかった規約ブランチ)"
  else
    mtime=$(date -d "@$(stat -c %Y "$wt")" '+%Y-%m-%d %H:%M:%S')
    anchor=$(git -C "$REPO" log develop --before="$mtime +1 hour" -1 --format=%H)
    if [ -z "$anchor" ]; then
      anchor=$(git -C "$REPO" rev-parse develop)
    fi
    printf '%s\n' "$anchor" > "$admin/HEAD"
    echo "  HEAD -> detached $anchor (develop 近傍コミットへの推測。要確認)"
    guessed+=("$name")
  fi

  git -C "$wt" read-tree HEAD

  # openapi submodule の admin dir も消えていたら復元する
  if [ -f "$wt/openapi/.git" ]; then
    sub_admin="$admin/modules/openapi"
    if [ ! -f "$sub_admin/HEAD" ]; then
      resolved_head=$(git -C "$wt" rev-parse HEAD)
      gitlink=$(git -C "$REPO" ls-tree "$resolved_head" openapi 2>/dev/null | awk '{print $3}')
      if [ -n "$gitlink" ] && git --git-dir="$GITDIR/modules/openapi" cat-file -e "$gitlink" 2>/dev/null; then
        mkdir -p "$sub_admin"
        printf '%s\n' "$wt/openapi/.git" > "$sub_admin/gitdir"
        printf '%s\n' '../../../../modules/openapi' > "$sub_admin/commondir"
        printf '%s\n' "$gitlink" > "$sub_admin/HEAD"
        git --git-dir="$sub_admin" --work-tree="$wt/openapi" read-tree HEAD
        echo "  openapi submodule admin dir も復元 ($gitlink)"
      else
        echo "  警告: openapi submodule のコミット ($gitlink) がローカルに無く復元できなかった" >&2
      fi
    fi
  fi

  git -C "$REPO" worktree lock --reason "repaired by repair-porto-worktrees.sh $(date -Iseconds)" "$wt" 2>&1 || true

  repaired+=("$name")
done

echo
echo "=== summary ==="
echo "既に健全: ${#skipped_ok[@]} 件 (${skipped_ok[*]:-なし})"
echo "修復した: ${#repaired[@]} 件 (${repaired[*]:-なし})"
if [ "${#guessed[@]}" -gt 0 ]; then
  echo "ブランチ不明のため develop 近傍コミットへ detached HEAD で復元 (要確認): ${guessed[*]}"
fi
if [ "${#skipped_missing[@]}" -gt 0 ]; then
  echo "作業ディレクトリごと消失 (復元不可): ${skipped_missing[*]}"
fi
