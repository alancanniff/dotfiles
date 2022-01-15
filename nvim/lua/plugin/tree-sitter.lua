local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

parser_config.vhdl = {
    install_info = {
        url = "~/source/tree-sitter-vhdl", -- local path or git repo
        files = {"src/parser.c"}
    },
    filetype = "vhd", -- if filetype does not agrees with parser name
    used_by = {"vhdl", "vho"} -- additional filetypes that use this parser
}

-- require'nvim-treesitter.configs'.setup {
--     ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
--     highlight = { enable = true },
--     indent = { enable = true },
-- }

require'nvim-treesitter.configs'.setup {
    -- Modules and its options go here
    highlight = { 
        enable = true,
        disable = {"vhdl"}
    },
    incremental_selection = { 
        enable = true,
        disable = {"vhdl"}
    },
    textobjects = { 
        enable = true,
        disable = {"vhdl"}
    },
    indent = { 
        enable = true,
    },
}

require "nvim-treesitter.configs".setup {
    vhdl = {
        enable = true,
    }

}

require "nvim-treesitter.configs".setup {
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
        },
    }
}
