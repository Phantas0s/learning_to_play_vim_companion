"execute "CompilerSet makeprg=" .. escape('luacheck --globals vim --formatter plain --no-color', ' ')
"CompilerSet makeprg=luacheck --no-color
"execute "CompilerSet makeprg=" .. escape('luacheck --no-color', ' ')
"execute "CompilerSet makeprg=" .. escape('luacheck --formatter plain --no-color', ' ')
"execute "CompilerSet makeprg=" .. escape('luacheck --globals vim --formatter plain --no-color', ' ')
execute "CompilerSet makeprg=" .. escape('luacheck --globals vim --codes --formatter plain --no-color', ' ')
execute "CompilerSet errorformat=" .. escape('%f:%l:%c: (%t%n) %m', ' ')
