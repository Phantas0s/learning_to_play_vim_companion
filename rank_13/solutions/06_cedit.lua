local function CeditComplete()
    -- -p adds a final slash to the name of a directory.
    -- grep -v '/' excludes all files with a slash (so all directories)
    local handle = io.popen(string.format('ls -p %s | grep -v /', vim.fn.shellescape(vim.fn.expand('%:h'))))
    if handle == nil then
        return
    end

    local result = handle:read("*a")
    handle:close()
    return vim.fn.split(result, '\n')
end

vim.api.nvim_create_user_command('Cedit', 'edit %:h/<args>', { nargs = 1, complete = CeditComplete })
