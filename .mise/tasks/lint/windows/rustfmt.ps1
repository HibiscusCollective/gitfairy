#!/usr/bin/env pwsh
#MISE description="Check formatting with rustfmt"
#USAGE flag '--all' "Run on all files in the repository"
#USAGE flag '--fix' "Apply formatting changes automatically"

param(
    [switch]$All,
    [switch]$Fix
)

$CMD = "cargo fmt"

if ($All) {
    $CMD += " --all"
} else {
    $CMD = "git diff --name-only HEAD | Select-String '.rs$' | ForEach-Object { $CMD $_ }"
}

if (-not $Fix) {
    $CMD += " -- --check"
}

Invoke-Expression $CMD