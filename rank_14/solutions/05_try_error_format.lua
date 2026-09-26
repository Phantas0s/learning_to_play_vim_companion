local cmd = ''
local cmdbang = ''

local function setErrorFile(userCmd)
    cmd = "cgetfile " .. userCmd.args
    cmdbang = "cfile " .. userCmd.args .. " | copen"
end

local function tryErrorFormat(userCmd)
    if cmd ~= '' and cmdbang ~= '' then
        vim.o.errorformat = userCmd.args
        if userCmd.bang then
            vim.cmd(cmdbang)
        else
            vim.cmd(cmd)
        end
        return
    end
    vim.api.nvim_echo({{ "You need to run :SetErrorFile {file} first" }}, true, {})
end

vim.api.nvim_create_user_command(
    "SetErrorFile",
    setErrorFile,
    { nargs = 1, complete = "file" }
)

vim.api.nvim_create_user_command(
    "TryErrorFormat",
    tryErrorFormat,
    { nargs = 1, bang = true }
)
