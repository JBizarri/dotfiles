return {
  'chrisgrieser/nvim-spider',
  lazy = false,
  config = function()
    require('spider').setup { skipInsignificantPunctuation = false }
  end,
}
