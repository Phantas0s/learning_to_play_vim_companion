function InsertTag(outer, inner) range
    execute printf(
      \ '%d,%ds#\v\<%s\>\zs(.{-})\ze\</%s\>#<%s>\1</%s>#g',
      \ a:firstline,
      \ a:lastline,
      \ a:outer,
      \ a:outer,
      \ a:inner,
      \ a:inner)
endfunction

command! -range=% -nargs=* InsertTag <line1>,<line2>call InsertTag(<f-args>)
