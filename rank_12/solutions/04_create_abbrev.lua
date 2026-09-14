local function promptExpandAbbr(abbr, exp, mode)
    if mode ~= "i" and mode ~= "c" and mode ~= vim.fn.getcmdtype() then
        return abbr
    end

    local p = vim.fn.confirm(string.format('Expand %s to %s ?', abbr, exp), "&Yes\n&No")

    if p == 1 then return exp else return abbr end
end

local function createAbbrev(abbr, exp, mode)
    local m = "i"
    if mode ~= "i" then m = "c" end
    vim.keymap.set(m .. 'a', abbr, function() return promptExpandAbbr(abbr, exp, mode) end, { expr = true })
end

createAbbrev('@@', 'mail@mail.com', 'i')
createAbbrev('@@', 'mail@mail.com', ':')
