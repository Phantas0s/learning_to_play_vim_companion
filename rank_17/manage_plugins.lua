local function installPlugin(name)
    local plugin = name:split("/")[2]
    local vimDir = vim.fn.fnamemodify(vim.fn.expand('$MYVIMRC'), ':p:h')
    local target = vim.fn.expand(string.format('%s/pack/external/opt/%s', vimDir, plugin))

    if vim.fn.isdirectory(target) == 1 then
        vim.notify('Plugin already installed: ' .. name, vim.log.levels.INFO)
        return
    end

    vim.cmd('cd ' .. vim.env.HOME .. '/dotfiles')
    local result = vim.fn.system(string.format(
        'git submodule add https://github.com/%s %s/pack/external/opt/%s',
        name, vimDir, plugin
    ))

    if vim.v.shell_error ~= 0 then
        vim.notify('Failed to install plugin: ' .. result, vim.log.levels.ERROR)
    else
        vim.notify(string.format('Plugin %s installed successfully', name), vim.log.levels.INFO)
    end
    vim.cmd('cd -')
end

vim.api.nvim_create_user_command('InstallPlugin', function(opts)
    installPlugin(opts.args)
end, { nargs = 1 })

local function updatePlugin()
    vim.cmd('cd ' .. vim.env.HOME .. '/dotfiles')
    vim.cmd('!git submodule update --remote --merge')
    vim.cmd('!git pull --recurse-submodules')
    vim.cmd('cd -')
end

vim.api.nvim_create_user_command('UpdatePlugin', function()
    updatePlugin()
end, {})

local function removePlugin(name)
    vim.cmd('cd ' .. vim.env.DOTFILES)
    local plugin = name:split("/")[2]
    local target = vim.fn.expand('$HOME/dotfiles/nvim/pack/external/opt/' .. plugin)
    local result = vim.fn.system('git rm ' .. target)

    if vim.v.shell_error ~= 0 then
        vim.notify('Failed to remove plugin: ' .. result, vim.log.levels.ERROR)
    else
        vim.notify(string.format('Plugin %s removed successfully', name), vim.log.levels.INFO)
    end
    vim.cmd('cd -')
end

vim.api.nvim_create_user_command('RemovePlugin', function(opts)
    removePlugin(opts.args)
end, { nargs = 1 })
