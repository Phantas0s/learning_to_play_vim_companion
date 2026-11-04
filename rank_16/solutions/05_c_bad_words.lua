local function CBadWords()
    local originPos = vim.api.nvim_win_get_cursor(0)
    local originSpell = vim.opt.spell

    local badWordList = {}
    local buf = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

    for lineNum, line in ipairs(lines) do
        for _, result in ipairs(vim.spell.check(line)) do
            local word, type, col = result[1], result[2], result[3]
            if type == "bad" then
                table.insert(badWordList, {
                    bufnr = buf,
                    lnum = lineNum,
                    col = col + 1,
                    text = word,
                })
            end
        end
    end

    vim.opt.spell = originSpell
    vim.api.nvim_win_set_cursor(0, originPos)

    vim.fn.setqflist({}, 'r', { title = 'Bad Spelled Words', items = badWordList })
    vim.cmd('copen')
end

vim.api.nvim_create_user_command('CBadWords', CBadWords, {})
