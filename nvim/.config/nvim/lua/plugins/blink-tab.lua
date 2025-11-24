return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "default",

        ["<Tab>"] = {
          "accept", -- confirm the selected item
          "fallback", -- insert a tab if nothing is selected
        },

        ["<S-Tab>"] = {
          "select_next",
          "fallback",
        },
      },
    },
  },
}
