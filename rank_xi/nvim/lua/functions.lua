local function deleteTrailingWS()
    vim.cmd([[
        normal mz
        %s/\v\s+$//ge
        normal `z
    ]])
end

local function removeDirectory(opts)
    local choice = vim.fn.confirm("Remove directory '"..opts.args.."'?", "Yes\nNo")
    if choice == 1 then
        vim.fn.delete(opts.args,"rf")
    end
end


return {
    customDeleteTrailingWS = deleteTrailingWS,
    removeDirectory = removeDirectory,
}
