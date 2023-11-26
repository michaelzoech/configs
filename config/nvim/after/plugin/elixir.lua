local get_cursor_position = function()
  local rowcol = vim.api.nvim_win_get_cursor(0)
  local row = rowcol[1] - 1
  local col = rowcol[2]

  return row, col
end

local nil_buf_id = 999999
local term_buf_id = nil_buf_id

local function my_test(command)
  local row, _col = get_cursor_position()
  --local args = command.arguments[1]

  -- delete the current buffer if it's still open
  if vim.api.nvim_buf_is_valid(term_buf_id) then
    vim.api.nvim_buf_delete(term_buf_id, { force = true })
    term_buf_id = nil_buf_id
  end

  vim.cmd("botright new | lua vim.api.nvim_win_set_height(0, 15)")
  term_buf_id = vim.api.nvim_get_current_buf()
  vim.opt_local.number = false
  vim.opt_local.cursorline = false

  --local cmd = "mix test " .. args.filePath
  local cmd = "mix test " .. vim.api.nvim_buf_get_name(0)

  -- add the line number if it's for a specific describe/test block
  --if args.describe or args.testName then
  --  cmd = cmd .. ":" .. (row + 1)
  --end

  vim.fn.termopen(cmd, {
    on_exit = function(_jobid, exit_code, _event)
      if exit_code == 0 then
        vim.api.nvim_buf_delete(term_buf_id, { force = true })
        term_buf_id = nil_buf_id
        vim.notify("Success: " .. cmd, vim.log.levels.INFO)
      else
        vim.notify("Fail: " .. cmd, vim.log.levels.ERROR)
      end
    end,
  })

  vim.cmd([[wincmd p]])
end

vim.keymap.set("n", "<leader>et", my_test)

