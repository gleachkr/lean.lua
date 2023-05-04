This is a WIP pandoc reader for [lean](https://leanprover.github.io/).

To install, copy `lean.lua` to `$DATADIR/readers` (for information about
pandoc's data directory, see [the manual](https://pandoc.org/MANUAL.html#option--data-dir)

To use, intone: `pandoc -f lean.lua $TARGET`
