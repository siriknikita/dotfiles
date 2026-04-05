return {
  'github/copilot.vim',
  config = function()
    vim.keymap.set('i', 'A-left', function()
      local suggestion = vim.fn['copilot#Accept']("")
      local bar = vim.fn['copilot#TextQueuedForInsertion']()
      return vim.fn.split(bar,  [[[ .]\zs]])[1]
    end, { expr = true, remap = false })
  end,
}
