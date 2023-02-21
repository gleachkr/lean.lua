local nonwhitespace = (1 - lpeg.P(" "))^0

local commentstart = lpeg.P([[/-]]) * nonwhitespace

local commentend = lpeg.P([[-/]])

local G = lpeg.P{
    "Pandoc";
    Pandoc = lpeg.Ct((lpeg.V"block" + lpeg.V"comment")^0) / pandoc.Pandoc,
    comment = commentstart * lpeg.C((1 - commentend)^1) * commentend / pandoc.Para,
    block = lpeg.C((1 - commentstart)^1) / pandoc.CodeBlock
}

function Reader(input)
    return lpeg.match(G,tostring(input))
end
