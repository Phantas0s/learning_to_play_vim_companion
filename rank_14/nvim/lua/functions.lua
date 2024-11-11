local function deleteTrailingWS()
    vim.cmd([[
        normal mz
        %s/\v\s+$//ge
        normal `z
    ]])
end

local function removeDirectories(table)
    for _, arg in ipairs(table.fargs) do
        local choice = vim.fn.confirm("Remove directory '" .. arg .. "'?", "&Yes\n&No")
        if choice == 1 then
            vim.fn.delete(arg, 'rf')
        end
    end
end

return {
    DeleteTrailingWS = deleteTrailingWS,
    RemoveDirectories = removeDirectories,
}
