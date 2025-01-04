local lpeg = require("lpeg")

local nonwhitespace = (1 - lpeg.S("\n\r\t ")) ^ 0

local commentstart = lpeg.P([[/-]])

local commentend = lpeg.P([[-/]])

local ignorePrefix = {
    ["!"] = true,
    ["-"] = true,
    [""] = true
}

function HandleComment(prefix, raw)
    if ignorePrefix[prefix] then prefix = "commonmark" end
    return table.unpack(pandoc.read(raw, prefix).blocks)
end

function HandleCode(raw)
    if raw:find("^[%s%c]+$") then return nil end
    return pandoc.CodeBlock(raw)
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
