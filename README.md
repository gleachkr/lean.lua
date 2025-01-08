# Lean.lua

This is a minimal [pandoc](https://pandoc.org) reader for
[Lean](https://leanprover.github.io/). It lets you use the world's best
document conversion tool to transform your Lean files into markdown, PDF, or
whatever format you like.

To install, copy `lean.lua` to `$DATADIR/readers` (for information about
pandoc's data directory, see [the pandoc
manual](https://pandoc.org/MANUAL.html#option--data-dir)).

To use, intone: `pandoc -f lean.lua $TARGET`. Comment blocks[^1] will be parsed
as [commonmark](https://commonmark.org), and Lean code will be converted to
code blocks. You should be able to use all standard pandoc output formats, so
conversion from here to PDF or other formats ought to be simple.

[^1]: That is, characters between `/-` and `-/` markers. The opening `/-` is
allowed to include extra non-whitespace characters, so `/-!` or `/--` counts as
opening a comment block - the `!` and `-` are not part of the block.

## Other Features

If you want to use an input format other than commonmark—LaTeX, for
example—open your comment block with `/-|latex` (or replace `latex` with your
format of choice). Any input format accepted by pandoc can be used. A complete
list of input formats can be found in the pandoc manual,
[here](https://pandoc.org/MANUAL.html#general-options).

## Templates

The repository includes two templates, `./templates/lean.html` and
`./templates/lean.latex`. These are essentially just the default pandoc
templates for standalone HTML and LaTeX documents respectively. But I've added
support for Lean syntax highlighting, just to give an example of how you can do
this. The HTML syntax highlighting is via
[highlightjs-lean](https://github.com/leanprover-community/highlightjs-lean),
and the LaTeX highlighting is provided by Jeremy Avigad's
[lstlean.tex](https://raw.githubusercontent.com/leanprover/lean4/master/doc/latex/lstlean.tex).

To generate an HTML file with the HTML template:

``` 
$ pandoc -f lean.lua MYFILE.lean --template ./templates/lean.html -o MYFILE.html
```

To generate a PDF with the LaTeX template:

``` 
$ pandoc -f lean.lua MYFILE.lean --template ./templates/lean.latex --listings -o MYFILE.pdf 
```

If your file includes non-ASCII characters, you may also want `--pdf-engine
lualatex`, or something similar.

## Alternatives

Some other approaches to transforming Lean code into documents include:

1. [verso](https://github.com/leanprover/verso)
2. [lean2md](https://github.com/arthurpaulino/lean2md)
3. [leanink](https://github.com/leanprover/LeanInk)
4. [lean-slides](https://github.com/0art0/lean-slides)
