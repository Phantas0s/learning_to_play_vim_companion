local function PlugAdd(opts)
    vim.env.MYVIMDIR = vim.fn.fnamemodify(vim.fn.expand("$MYVIMRC"), ":p:h")

    local name = opts.args
    local plugin = name:match("^[^/]+")
    local path = vim.fn.expand("$MYVIMDIR") .. "/pack/external/start/" .. plugin

    if vim.fn.isdirectory(path) == 1 then
        vim.notify("Plugin already installed: " .. name)
        return
    end

    local result = vim.system({ "git", "clone", "https://github.com/" .. name, path }):wait()

    if result.code ~= 0 then
        vim.notify("Failed to install plugin: " .. (result.stderr or ""), vim.log.levels.ERROR)
    else
        vim.notify("Plugin installed successfully: " .. name)
    end
end

vim.api.nvim_create_user_command("PlugAdd", PlugAdd, { nargs = 1 })
