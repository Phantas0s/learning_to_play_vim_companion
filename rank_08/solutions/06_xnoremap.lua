
-- Create mapping for a specific visual mode type.
-- For the argument 'model', use one of the strings: 'charwise', 'linewise', 'blockwise'; default is 'charwise'
function Xnoremap(mode, mapping, keystroke)
    local m = "v"

    if mode == "linewise" then
        m = "V"
    elseif mode == "blockwise" then
        -- Escape sequence representing CTRL-v
        m = "\22"
    end

    vim.keymap.set(
        "v",
        mapping,
        function () return vim.fn.visualmode() == m and keystroke end,
        { expr = true }
    )
end
