-- Search using ripgrep in one or multiple files, and create a new quickfix list
function GrepWithCol(pattern, ...)
    if select("#", ...) == 0 then
        error("At least one file must be specified")
    end

    local files = { ... }
    local cmd = {
        "rg", "--column", "--line-number", "--no-heading", "--vimgrep",
        pattern, unpack(files)
    }

    -- Call the shell command and return a Vimscript list
    local result = vim.fn.systemlist(cmd)

    -- return early if the shell command returns an error
    if vim.v.shell_error ~= 0 then
        return
    end

    local qflist = {}
    for _, line in ipairs(result) do
        local parts = vim.split(line, ":")
        -- Reconstruct the message if it contains some colons
        local message = table.concat(parts, ":", 4)
        if #parts >= 4 then
            table.insert(qflist, {
                filename = parts[1],
                lnum = tonumber(parts[2]),
                col = tonumber(parts[3]),
                text = message
            })
        end
    end

    vim.fn.setqflist(qflist)
end
