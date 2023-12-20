vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "exit insert mode" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "clean search highlights" })

-- windows
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "split window horizontally" })

-- windows move
keymap.set("", "<C-h>", "<C-w>h", { desc = "left windows move" })
keymap.set("", "<C-j>", "<C-w>j", { desc = "down windows move" })
keymap.set("", "<C-k>", "<C-w>k", { desc = "up windows move" })
keymap.set("", "<C-l>", "<C-w>l", { desc = "right windows move" })

-- buffer move
keymap.set({ "n", "t" }, "<leader>m", ":bprevious<CR>", { desc = "pre buffer move" })
keymap.set({ "n", "t" }, "<leader>n", ":bnext<CR>", { desc = "next buffer move" })

-- all select
keymap.set("n", "<C-a>", "ggVG", { desc = "select all" })
