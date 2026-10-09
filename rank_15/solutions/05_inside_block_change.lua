local function changeBlocks()
    local currentBuf = vim.api.nvim_get_current_buf()
    local rightBuf = vim.fn.winbufnr(vim.fn.winnr('l'))
    local leftBuf = vim.fn.winbufnr(vim.fn.winnr('h'))

    local otherBuf
    if rightBuf == currentBuf then
        otherBuf = leftBuf
    elseif leftBuf == currentBuf then
        otherBuf = rightBuf
    else
        error('You need a left or right window to use this text-object')
    end

    local currentLines = table.concat(vim.api.nvim_buf_get_lines(currentBuf, 0, -1, false), '\n')
    local otherLines = table.concat(vim.api.nvim_buf_get_lines(otherBuf, 0, -1, false), '\n')

    local diff = vim.text.diff(currentLines, otherLines, { result_type = 'indices' })

    local ranges = {}
    for _, d in ipairs(diff) do
        local fromIdx = d[1]
        local fromCount = d[2]
        if fromCount ~= 0 then
            table.insert(ranges, { fromIdx, fromIdx + fromCount - 1 })
        end
    end
    return ranges
end

local function currentChangeBlock()
    local blocks = changeBlocks()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    for _, bl in ipairs(blocks) do
        if line >= bl[1] and line <= bl[2] then
            return bl
        end
    end
end

local function selectChangeBlock()
    local block = currentChangeBlock()
    if not block then
        return
    end
    vim.api.nvim_win_set_cursor(0, { block[1], 0 })
    vim.cmd('normal! V')
    vim.api.nvim_win_set_cursor(0, { block[2], 0 })
end

vim.keymap.set('o', 'ibc', function()
    if not vim.wo.diff then
        return 'ibc'
    end
    if not currentChangeBlock() then
        return ''
    end
    selectChangeBlock()
end, { desc = 'Inside block of changes' })
