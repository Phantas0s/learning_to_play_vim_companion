if exists("current_compiler")
  finish
endif
let current_compiler = "luacheck"

execute "CompilerSet errorformat=" .. escape('%f:%l:%c: (%t%n) %m', ' ')

execute "CompilerSet makeprg=" .. escape('luacheck --globals vim --codes --formatter plain --no-color', ' ')
