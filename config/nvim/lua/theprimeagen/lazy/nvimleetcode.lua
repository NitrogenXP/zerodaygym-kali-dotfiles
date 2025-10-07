return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html", -- ensure html Treesitter parser is installed
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim", -- required
    "MunifTanjim/nui.nvim",
  },
  opts = {
    -- optional configuration
    lang = "c", -- default language (cpp, python3, java, etc.)
  },
}

