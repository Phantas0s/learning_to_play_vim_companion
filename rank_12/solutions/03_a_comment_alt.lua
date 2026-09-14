function AComment(inside)
    --[[
    Search forward for the end of the block and move the cursor.
    'c' accepts a match at the cursor position, in case we're on a delimiter.
    'W' doesn't wrap around the end of the file, not deleting the first block if there is no next block in the buffer.
    ]]--
    local endBlock = vim.fn.search('\\V]]--', 'cW')
    if endBlock ~= 0 then
        --[[
        Search for the start of the block.
        'b' search backward.
        'n' doesn't move the cursor.
        'c' accepts a match at the cursor position, in case we're on a delimiter.
        ]]--
        local startBlock = vim.fn.search('\\V--[[', 'bnc')

        if inside then
            startBlock = startBlock + 1
            endBlock = endBlock - 1
        end

        vim.fn.execute(tostring(startBlock))
        vim.cmd('normal! V')
        vim.fn.execute(tostring(endBlock))
    end
end

vim.keymap.set('o', 'ac', function() AComment(false) end)
-- We need to call the function from Vimscript to stop VISUAL mode and delete the range '<,'>.
-- See rank 08 "Function Scopes in Lua".
vim.keymap.set('x', 'ac', ':<c-u>call v:lua.AComment(v:false)<cr>')

vim.keymap.set('o', 'ic', function() AComment(true) end)
vim.keymap.set('x', 'ic', ':<c-u>call v:lua.AComment(v:true)<cr>')
