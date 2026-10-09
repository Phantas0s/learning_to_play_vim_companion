local modeMap = {
  n  = "NORMAL",
  v  = "VISUAL",
  V  = "VISUAL LINE",
  ["\x16"] = "VISUAL BLOCK",
  i  = "INSERT",
  c  = "COMMAND-LINE",
  R  = "REPLACE",
  t  = "TERMINAL",
  no = "OPERATOR PENDING",
}

local sep = " "

local function getMode()
  return modeMap[vim.api.nvim_get_mode().mode] or ""
end

local function getBranch()
  return vim.fn.trim(vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null"))
end

local function getChars()
  local wc = vim.fn.wordcount()
  return (wc.visual_chars or wc.chars) .. "chars"
end

function createStatusLine()
  local m = getMode()
  local branch = getBranch()

  return table.concat {
    -- Left
    m ~= "" and ("--" .. m .. "--" .. sep) or "",
    "%f",
    sep,
    vim.bo.modified and "*" or "-",
    vim.bo.readonly and sep or "",
    "%r",
    sep,
    "%y",

    -- Right
    "%=",
    branch ~= "" and (sep .. "[" .. branch .. "]") or "",
    sep,
    getChars(),
    sep,
    "%l/%L",
    sep,
    "%p%%",
  }
end

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*",
  callback = function()
    vim.cmd("redrawstatus")
  end,
})

vim.o.statusline = "%!v:lua.createStatusLine()"
