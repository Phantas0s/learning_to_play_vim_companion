function ParseTree(tree, branch)
    local level = ' '
    for _ = 1, branch do
        -- A branch is displayed on two columns
        level = level .. '| '
    end

    for key, node in ipairs(tree) do
        -- Display the branch if there is one
        if node.alt then
            -- Display a branching connection
            print(level .. [[|\]])
            -- The branch needs to be displayed one more column
            -- on the right
            ParseTree(node.alt, branch + 1)
        end

        -- Determine the character to display for the node
        local charnode = "o"
        if node.seq == vim.fn.changenr() then
            charnode = "@"
        end
        print(string.format('%s%s %d', level, charnode, node.seq))

        -- If the node is a leaf, the next portion of the tree should shrink by 2 columns
        local leaf = #tree == key
        if leaf == true then
            level = string.sub(level, 1, -3)
        end

        -- If the node is not the last one, display a connection
        -- according to the level we're at
        local lastLeaf = leaf and branch == 0
        if lastLeaf == false then
            print(string.format('%s|', level))
        end
    end
end

function DrawTree()
    local tree = vim.fn.undotree()
    ParseTree(tree.entries, 0)
end
