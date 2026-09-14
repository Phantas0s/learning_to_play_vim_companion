function ExtractDigraphTable(userCmd)
    -- Save the digraph table into a file
    local tmp = "/tmp/digraphs"
    local file = io.open(tmp,"r")
    if file == nil then
        vim.cmd(string.format([[
            help digraph-table
            call search("char")
            .,$-2write! %s
            quit
        ]], tmp))
    else
        io.close(file)
    end

    local digraphs = {}
    local headers = {}
    local firstLine = true

    -- Transform the digraph table into a list of list.
    for line in io.lines(tmp) do
        if firstLine then
            headers = vim.fn.split(line, "\t")
            firstLine = false
            goto continue
        end

        local items = {}
        for _, item in ipairs(vim.fn.split(line, "\t")) do
            table.insert(items, item)
        end
        table.insert(digraphs, items)

        ::continue::
    end

    -- Go through the list to try to match the pattern.
    local match = {}
    for _, digraph in ipairs(digraphs) do
        for _, item in ipairs(digraph) do
            -- Vimscript match() is more powerful than string.match
            if vim.fn.match(item, userCmd.args) ~= -1 then
                table.insert(match, digraph)
            end
        end
    end

    -- Display the result of the search.
    if (#match) == 0 then
        print("No match found")
    else
        vim.notify(table.concat(headers, "\t"))
        for _, m in ipairs(match) do
            vim.notify(table.concat(m, "\t"))
        end
    end
end

vim.api.nvim_create_user_command('Digraphs', ExtractDigraphTable, { nargs = 1 })
