-- Add the cursor position to the current quickfix list
function AddPosToQuickfix()
    -- vim.api.nvim_win_get_cursor() is also possible here
    local line = vim.fn.getpos('.')[2] -- array indexing starts at 1, not 0 like in Vimscript
    local col = vim.fn.getpos('.')[3]
    local bufnr = vim.api.nvim_get_current_buf()
    local text = vim.api.nvim_buf_get_lines(bufnr, line - 1, line, false)[1]
    local expr = string.format([[%s:%d:%d:%s]], vim.api.nvim_buf_get_name(bufnr), line, col, text)
    vim.cmd("caddexpr " .. expr)
end

-- Alternate version using `setqflist()` (more idiomatic)
function AddPosToQuickfix()
    local line = vim.fn.getpos('.')[2]
    local col = vim.fn.getpos('.')[3]
    local bufnr = vim.api.nvim_get_current_buf()
    local text = vim.api.nvim_buf_get_lines(bufnr, line - 1, line, false)[1]
    vim.fn.setqflist({
        {
            filename = vim.api.nvim_buf_get_name(bufnr),
            lnum = line,
            col = col,
            text = text
        }
    }, 'a')
end
