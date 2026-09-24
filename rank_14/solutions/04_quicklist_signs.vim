function QuicklistSigns() abort
    let errorTypes = ['e','w', 'i', 'n']
    " We delete every quickfix sign created previously
    call sign_unplace('quickfixEntry')
    for item in getqflist()
        " We need our quickfix entry valid
        if item.valid
            let signName = 'q-' .. item.type
            let sign = '->'
            " If the error type is part of our recognized error types,
            " we display this error type instead of "->"
            if index(errorTypes, tolower(item.type)) >= 0
                let sign = toupper(item.type)
            endif
            call sign_define(signName,{'text': sign,'texthl':'NONE','linehl':'NONE'})
            call sign_place(item.lnum, 'quickfixEntry', signName, item.bufnr, {'lnum': item.lnum})
        endif
    endfor
endfunction

augroup quickfix
    autocmd!
augroup END

autocmd quickfix QuickFixCmdPost * call QuicklistSigns()
