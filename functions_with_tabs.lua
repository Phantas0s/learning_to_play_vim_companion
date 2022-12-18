#!/usr/bin/env lua

local function restorePosition()
	if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
		vim.cmd([[normal! g`"]])
	end
end

--[[
1. Save the current cursor position
2. Delete all the trailing spaces
3. Come back to the saved cursor position
]]--
local function deleteTrailingWS()
	vim.cmd([[
		normal mz
		%s/\v\s+$//ge
		normal `z
	]])
end

return {
	restore_position = restorePosition,
	delete_trailing_ws = deleteTrailingWS
}
