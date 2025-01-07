local lpeg = require("lpeg")

local nonwhitespace = (1 - lpeg.S("\n\r\t ")) ^ 0

local commentstart = lpeg.P([[/-]])

local commentend = lpeg.P([[-/]])

function HandleComment(prefix, raw)
    local flavor = prefix:match("^|(.*)") or "commonmark"
    return table.unpack(pandoc.read(raw, flavor).blocks)
end

function HandleCode(raw)
    if raw:find("^[%s%c]+$") then return nil end
    -- If the block ends with "-/\n" or -/  \n", we strip that whitespace
    --
    -- Whitespace is otherwise preserved
    --
    local stripped = raw:match("^[ \t]*\n(.*)$")
    if stripped then
        return pandoc.CodeBlock(stripped, {class = "lean"})
    else
        return pandoc.CodeBlock(raw, {class = "lean"})
    end
end

local theGrammar = {
    "Pandoc",
    Pandoc = lpeg.Ct((lpeg.V "block" + lpeg.V "comment") ^ 0) / pandoc.Pandoc,
    comment = commentstart * lpeg.C(nonwhitespace) * lpeg.C((1 - commentend) ^ 1) * commentend / HandleComment,
    block = lpeg.C((1 - commentstart) ^ 1) / HandleCode
}

local G = lpeg.P(theGrammar)

function Reader(input)
    return lpeg.match(G, tostring(input))
end
