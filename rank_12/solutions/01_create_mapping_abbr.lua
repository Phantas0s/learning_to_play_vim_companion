function CreateMappingAbbr()
    local modes = {'n','i','c','x', 'o'}
    for _, mode in ipairs(modes) do
        vim.keymap.set('ia', mode .. 'n_', mode .. 'noremap')
    end
end
