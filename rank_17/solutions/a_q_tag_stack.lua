local function TagStackToQuickfix()
    local tagStack = vim.fn.gettagstack()
    local entries = {}
    local seen = {}

    if vim.tbl_isempty(tagStack.items) then
        vim.notify("The tag stack is empty.")
        return
    end

    for _, tag in ipairs(tagStack.items) do
        if not seen[tag.tagname] then
            seen[tag.tagname] = true
            table.insert(entries, {
                filename = vim.api.nvim_buf_get_name(tag.bufnr),
                lnum     = tag.from[2],
                col      = tag.from[3],
                text     = tag.tagname,
                valid    = true,
            })
        end
    end

    vim.fn.setqflist(entries)
    vim.cmd("copen")
end

vim.api.nvim_create_user_command("QTagStack", TagStackToQuickfix, {})
