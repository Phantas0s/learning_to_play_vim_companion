local function TestComplete()
    -- -p adds a final slash to directories' names
    -- grep -v '/' exclude all files with a slash (so all directories)
    local handle = io.popen(string.format('ls -p %s | grep -v / | grep -v %s', vim.fn.shellescape(vim.fn.expand('%:h')), vim.fn.shellescape(vim.fn.expand('%:t'))))
    if handle == nil then
        return
    end

    local result = handle:read("*a")
    handle:close()
    return vim.fn.split(result, '\n')
end

local function CreateTestFile(userCmd)
    -- see https://www.lua.org/pil/20.2.html for Lua patterns
    local IsTestFile = function(filename) return string.match(filename, '_test%.go$') end

    local filepath= ""
    if #userCmd.fargs == 1 then
        local baseFile = userCmd.fargs[1]
        local testFile = ""
        if IsTestFile(baseFile) then
            testFile = baseFile
        else
            testFile = string.gsub(baseFile, '%.go$', '_test.go')
        end

        filepath = vim.fn.expand('%:h') .. "/" .. testFile
    else
        local baseFile = vim.fn.expand('%')
        if IsTestFile(baseFile) then
            return
        end

        filepath = vim.fn.expand('%:r') .. "_test.go"
    end

    filepath = vim.fn.fnameescape(filepath)

    vim.cmd(string.format([[
        silent! bdelete! %s
        vsplit filepath %s
    ]], filepath, filepath))
end

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = 'go',
    callback = function()
        vim.api.nvim_buf_create_user_command(0, 'Test', CreateTestFile, { nargs = '?', complete = TestComplete })
    end
})
