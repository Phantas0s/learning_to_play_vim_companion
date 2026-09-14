function ParseTree(tree, branch) abort
    let level = ''
    for i in range(1, a:branch)
        " A branch is displayed on two columns
        let level .= '| '
    endfor

    for node in a:tree
        " Display the branch if there is one
        if has_key(node, "alt")
            " Display a branching connection
            echom printf('%s|\', level)
            " The branch needs to be displayed one more column
            " on the right
            let branch = a:branch + 1
            " We recurse on the branch
            call ParseTree(node.alt, branch)
        endif

        " Determine the character to display for the node
        let charnode = "o"
        if node.seq == changenr()
            let charnode = "@"
        endif
        echom printf('%s%s %d', level, charnode, node.seq)

        " If the node is a leaf, the next portion of the tree should shrink by 2 columns
        let leaf = len(a:tree) == index(a:tree, node) + 1
        if leaf == v:true
            let level = strcharpart(level, 0, len(level) - 2)
        endif

        " If the node is not the last one, display a connection
        " according to the level we're at
        let lastLeaf = leaf && a:branch == 0
        if !lastLeaf
            echom printf('%s|', level)
        endif
    endfor
endfunc

function DrawTree() abort
    let tree = undotree()
    call ParseTree(tree.entries, 0)
endfunc
