local function GetDigraphsList()
    local output = vim.fn.execute('digraphs')
    local list = {}
    local pattern = '\\v(\\S{2})\\s+(\\S{1,2})\\s+(\\d+)'
    local digraphIdx = 0

    while true do
        local match = vim.fn.matchlist(output, pattern, digraphIdx)
        if #match == 0 then
            break
        end
        table.insert(list, { match[2], match[3], match[4] })
        digraphIdx = vim.fn.matchend(output, pattern, digraphIdx)
    end

    return list
end

local function FindDigraph(query)
    local digraphs = GetDigraphsList()
    local matches = {}

    for _, entry in ipairs(digraphs) do
        if vim.fn.match(entry[1], '\\c' .. query) >= 0
            or vim.fn.match(entry[2], '\\c' .. query) >= 0
            or vim.fn.match(entry[3], '\\c' .. query) >= 0 then
            table.insert(matches, string.format('%s %s %s', entry[1], entry[2], entry[3]))
        end
    end

    if #matches == 0 then
        vim.notify('No digraphs found matching: ' .. query)
    else
        for _, match in ipairs(matches) do
            vim.notify(match)
        end
    end
end

vim.api.nvim_create_user_command('FindDigraph', function(opts)
    FindDigraph(opts.args)
end, { nargs = 1 })
