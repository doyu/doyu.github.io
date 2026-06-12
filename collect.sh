#!/usr/bin/env bash
# collect.sh — sources.txt に列挙した markdown を posts/collected/ へ取得する
set -euo pipefail
cd "$(dirname "$0")"
dest=posts/collected
rm -rf "$dest"
mkdir -p "$dest"
while read -r repo path; do
    case "${repo:-}" in ''|\#*) continue ;; esac
    out="$dest/$(basename "$repo")-$(basename "$path")"
    curl -fsSL "https://raw.githubusercontent.com/$repo/HEAD/$path" -o "$out"
    echo "fetched $repo/$path -> $out" >&2
done < sources.txt
