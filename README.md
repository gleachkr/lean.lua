# Lean.lua

This is a minimal pandoc reader for [lean](https://leanprover.github.io/).

To install, copy `lean.lua` to `$DATADIR/readers` (for information about
pandoc's data directory, see [the pandoc manual](https://pandoc.org/MANUAL.html#option--data-dir)

To use, intone: `pandoc -f lean.lua $TARGET`. Comment blocks[^1] will be parsed
as [commonmark](https://commonmark.org), and lean code will be converted to
code blocks. You should be able to use all standard pandoc output formats, so
conversion from here to PDF or other formats ought to be simple.

[^1]: That is, characters between `/-` and `-/` markers. The opening `/-` is
allowed to include extra non-whitespace characters, so `/-!` or `/--` counts as
opening a comment block - the `!` and `-` are not part of the block.

## Other Features

If you want to use an input format other than commonmark—latex, for example—
open your comment block with `/-|latex`. Any input format accepted by pandoc
can be used. A complete list of input formats can be found in the pandoc
manual, [here](https://pandoc.org/MANUAL.html#general-options).

## Alternatives

Some other approaches to transforming lean code into documents include:

1. [verso](https://github.com/leanprover/verso)
2. [lean2md](https://github.com/arthurpaulino/lean2md)
3. [leanink](https://github.com/leanprover/LeanInk)
