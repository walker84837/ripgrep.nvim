local M = {}

-- Create an augroup for the plugin
local augroup = vim.api.nvim_create_augroup("Ripgrep", { clear = true })

function ripgrep(query)
  local command = 'rg -L -i --vimgrep ' .. vim.fn.shellescape(query)
  load_into_quickfix(command, query)
end

function ripgrep_ignore_symlinks(query)
  local command = 'rg -i --vimgrep ' .. vim.fn.shellescape(query)
  load_into_quickfix(command, query)
end

function load_into_quickfix(command, query)
  local tempfile = vim.fn.tempname()
  local handle = io.popen(command)
  if not handle then
    vim.notify("Failed to execute command: " .. command, vim.log.levels.ERROR)
    return
  end
  local output = handle:read('*a')
  handle:close()

  -- Check if output is empty
  if output == '' then
    vim.notify("No results found for query: " .. query, vim.log.levels.INFO)
    return
  end

  -- Write output to the temporary file
  local file = io.open(tempfile, 'w')
  if file then
    file:write(output)
    file:close()
  else
    vim.notify("Failed to write to file: " .. tempfile, vim.log.levels.ERROR)
    return
  end

  -- Load the results into the quickfix list
  vim.cmd('silent! cgetfile ' .. tempfile)

  -- Open the quickfix window
  vim.cmd('copen')

  -- Clean up the temporary file
  vim.fn.delete(tempfile)
end

-- Setup function for the plugin
function M.setup()
  -- Register the "Rg" user command
  vim.api.nvim_create_user_command('Rg', function(opts)
    ripgrep(opts.args)
  end, { nargs = 1, desc = "Search with ripgrep (follows symlinks)" })

  vim.api.nvim_create_user_command('RgIgnore', function(opts)
    ripgrep_ignore_symlinks(opts.args)
  end, { nargs = 1, desc = "Search with ripgrep (do not symlinks)" })
end

return M
