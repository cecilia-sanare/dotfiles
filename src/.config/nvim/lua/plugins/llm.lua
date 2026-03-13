return {
  "huggingface/llm.nvim",
  config = function()
    require("llm").setup({
      backend = "ollama",
      model = "qwen2.5-coder:7b",
      url = "http://localhost:11434",
      tokens_to_clear = { "<|endoftext|>" },
      fim = {
        enabled = true,
        prefix = "<|fim_prefix|>",
        middle = "<|fim_middle|>",
        suffix = "<|fim_suffix|>",
      },
      accept_keymap = "<Tab>",
      dismiss_keymap = "<S-Tab>",
    })
  end
}
