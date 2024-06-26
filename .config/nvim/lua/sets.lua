-- sets
--

local global_options = vim.opt

global_options.backup = false
global_options.writebackup = false

-- command line height
global_options.cmdheight = 1

-- Set listchars
global_options.showbreak = "↪"
global_options.listchars="tab:. ,eol:↩,nbsp:␣,trail:·"
global_options.list = true


--  Having longer updatetime (default is 4000 ms = 4 s leads to noticeable) delays and poor user experience.
--global_options.updatetime = 50

global_options.spelllang = "en"

global_options.tabstop = 4
global_options.softtabstop = 4
global_options.shiftwidth = 4
global_options.scrolloff = 12
global_options.number = true
global_options.ignorecase = true
global_options.smartcase = true
global_options.swapfile = false
global_options.incsearch = true
global_options.expandtab = false
global_options.errorbells = false
global_options.signcolumn = "yes"

-- sets statusline to be global
-- and sets border to be thin
global_options.laststatus = 3
