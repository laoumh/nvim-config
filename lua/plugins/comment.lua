-- comentário de linha e bloco
-- Ver https://github.com/numToStr/Comment.nvim?tab=readme-ov-file#configuration-optional para configurações
return {
  {
    -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false }
  },
  {
    -- Ver :H comment.config para detalhes sobre
    -- configuração e keymappings
    'numToStr/Comment.nvim',
    config = function ()
      require('Comment').setup()
    end
  },
}
