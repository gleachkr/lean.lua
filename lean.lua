local nonwhitespace = (1 - lpeg.S("\n\r\t "))^0

local commentstart = lpeg.P([[/-]])

local commentend = lpeg.P([[-/]])

function HandleComment(prefix,raw)
    local dialect = "commonmark"
    if prefix ~= nil then dialect = prefix end
    return table.unpack(pandoc.read(raw,dialect).blocks)
end

local G = lpeg.P{
    "Pandoc";
    Pandoc = lpeg.Ct((lpeg.V"block" + lpeg.V"comment")^0) / pandoc.Pandoc,
    comment = commentstart * lpeg.C(nonwhitespace) * lpeg.C((1 - commentend)^1) * commentend / HandleComment,
    block = lpeg.C((1 - commentstart)^1) / pandoc.CodeBlock
}

function Reader(input)
    return lpeg.match(G,tostring(input))
end
