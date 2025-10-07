local local_plugins = {
	--{
	--    "vim-guys",
	--    dir = "~/personal/vim-guys",
	--    config = function()
	--    end,
	--},
	--{
	--    "cockpit",
	--    dir = "~/personal/cockpit",
	--    config = function()
	--        require("cockpit")
	--        vim.keymap.set("n", "<leader>ct", "<cmd>CockpitTest<CR>")
	--        vim.keymap.set("n", "<leader>cr", "<cmd>CockpitRefresh<CR>")
	--    end,
	--},

	-- Comment out ThePrimeagen's personal plugins that don't exist locally
	--{
	--	"the-stru",
	--	dir = "~/personal/the-stru",
	--},
	--{
	--	"streamer",
	--	dir = "~/personal/eleven-streamer",
	--	config = function()
	--		vim.keymap.set("n", "<leader>er", function()
	--			require("streamer").reload()
	--		end)
	--		vim.keymap.set("n", "<leader>es", function()
	--			require("streamer").twitch_dashboard()
	--		end)
	--		vim.keymap.set("n", "<leader>en", function()
	--			require("streamer").twitch_dashboard():stop()
	--		end)
	--	end,
	--},

	--{
	--	"caleb",
	--	dir = "~/personal/caleb",
	--	config = function() end,
	--},

	-- Replace with the real Harpoon plugin from GitHub
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")

			harpoon:setup()

			vim.keymap.set("n", "<leader>A", function()
				harpoon:list():prepend()
			end)
			vim.keymap.set("n", "<leader>a", function()
				harpoon:list():add()
			end)
			vim.keymap.set("n", "<C-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)

			-- Select files 1-9
			vim.keymap.set("n", "<leader>h1", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set("n", "<leader>h2", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set("n", "<leader>h3", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set("n", "<leader>h4", function()
				harpoon:list():select(4)
			end)
			vim.keymap.set("n", "<leader>h5", function()
				harpoon:list():select(5)
			end)
			vim.keymap.set("n", "<leader>h6", function()
				harpoon:list():select(6)
			end)
			vim.keymap.set("n", "<leader>h7", function()
				harpoon:list():select(7)
			end)
			vim.keymap.set("n", "<leader>h8", function()
				harpoon:list():select(8)
			end)
			vim.keymap.set("n", "<leader>h9", function()
				harpoon:list():select(9)
			end)

			-- Replace files at positions 1-9
			vim.keymap.set("n", "<leader>r1", function()
				harpoon:list():replace_at(1)
			end)
			vim.keymap.set("n", "<leader>r2", function()
				harpoon:list():replace_at(2)
			end)
			vim.keymap.set("n", "<leader>r3", function()
				harpoon:list():replace_at(3)
			end)
			vim.keymap.set("n", "<leader>r4", function()
				harpoon:list():replace_at(4)
			end)
			vim.keymap.set("n", "<leader>r5", function()
				harpoon:list():replace_at(5)
			end)
			vim.keymap.set("n", "<leader>r6", function()
				harpoon:list():replace_at(6)
			end)
			vim.keymap.set("n", "<leader>r7", function()
				harpoon:list():replace_at(7)
			end)
			vim.keymap.set("n", "<leader>r8", function()
				harpoon:list():replace_at(8)
			end)
			vim.keymap.set("n", "<leader>r9", function()
				harpoon:list():replace_at(9)
			end)
		end,
	},

	--{
	--	"vim-apm",
	--	dir = "~/personal/vim_apm",
	--	config = function()
	--	end,
	--},

	--{
	--	"vim-with-me",
	--	dir = "~/personal/vim-with-me",
	--	config = function() end,
	--},

}

return local_plugins

