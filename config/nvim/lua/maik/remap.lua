vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- vim.keymap.set("n", "j", "gj")
-- vim.keymap.set("n", "k", "gk")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

vim.keymap.set("i", "uu", "<Esc>")

vim.keymap.set("n", "<leader>h", ":bprevious<CR>")
vim.keymap.set("n", "<leader>l", ":bnext<CR>")
vim.keymap.set("n", "<leader>q", ":bdelete<CR>")

function InsertMarkdownURL()
  local url = vim.fn.expand "<cWORD>"
  if url == "" then return end
  local cmd = "curl -L " .. vim.fn.shellescape(url) .. " 2>/dev/null"
  local handle = io.popen(cmd)
  if not handle then return end
  local html = handle:read "*a"
  handle:close()
  local title = ""
  local pattern = "<title>(.-)</title>"
  local m = string.match(html, pattern)
  if m then title = m end
  if title ~= "" then
    local markdownLink = "[" .. title .. "](" .. url .. ")"
    vim.api.nvim_command("call append(line('.'), '" .. markdownLink .. "')")
  else
    print("Title not found for link")
  end
end

vim.api.nvim_set_keymap("n", "<leader>mdp", ":lua InsertMarkdownURL()<CR>", { silent = true, noremap = true })
