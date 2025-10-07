
return {
    "mbbill/undotree",

    config = function() 
        -- Define undotree sign variables to prevent errors
        vim.g.undotree_SignAdded = "+"
        vim.g.undotree_SignChanged = "~"
        vim.g.undotree_SignDeleted = "-"
        vim.g.undotree_SignDeletedEnd = "_"
        
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
}

