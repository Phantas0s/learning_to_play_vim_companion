function CreateUndoNodes()
    local keys = {'.',',','!','?'}
    for _, key in ipairs(keys) do
        vim.keymap.set('i', key, '<c-g>u' .. key)
    end
end
