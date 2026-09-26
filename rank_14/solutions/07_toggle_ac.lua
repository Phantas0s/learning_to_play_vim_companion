local ac_enabled = false

function ToggleAC()
    local chars = { '.' }
    for i = 97, 122 do chars[#chars + 1] = string.char(i) end

    if ac_enabled then
        for _, char in ipairs(chars) do
            vim.keymap.del('i', char)
        end
        ac_enabled = false
    else
        for _, char in ipairs(chars) do
            vim.keymap.set('i', char, char .. '<c-n>')
        end
        ac_enabled = true
    end
end

vim.api.nvim_create_user_command('ToggleAC', ToggleAC, {})
