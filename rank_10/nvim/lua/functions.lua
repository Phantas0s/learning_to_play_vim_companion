local function deleteTrailingWS()
    vim.cmd([[
        normal mz
        %s/\v\s+$//ge
        normal `z
    ]])
end

return {
    DeleteTrailingWS = deleteTrailingWS
}
