-- ~/.config/nvim/lua/plugins/diffview.lua
-- Side-by-side git diff viewer. All keymaps live under the <leader>gv (view)
-- group so nothing shadows Snacks' <leader>gd picker or gitsigns' <leader>gh
-- hunk group. <leader>gv is a pure prefix (no command on it) to avoid the
-- which-key timeout hang.
return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = { layout = "diff2_horizontal" }, -- left = old, right = new
      file_history = { layout = "diff2_horizontal" },
      merge_tool = { layout = "diff3_horizontal" },
    },
    file_panel = {
      listing_style = "tree",
      win_config = { position = "top", height = 8 }, -- slim
    },
  },
  keys = {
    { "<leader>gv", "", desc = "+diffview" }, -- group label for which-key
    { "<leader>gvv", "<cmd>DiffviewOpen<cr>", desc = "Open (working tree)" },
    { "<leader>gvb", "<cmd>DiffviewOpen main..HEAD<cr>", desc = "Branch vs main" },
    { "<leader>gvd", "<cmd>DiffviewOpen develop...HEAD<cr>", desc = "Branch vs develop" },
    {
      "<leader>gvB",
      function()
        vim.ui.input({ prompt = "Diff HEAD against branch: ", default = "develop" }, function(branch)
          if branch and branch ~= "" then
            vim.cmd("DiffviewOpen " .. branch .. "...HEAD")
          end
        end)
      end,
      desc = "Branch vs… (prompt)",
    },
    { "<leader>gvh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
    { "<leader>gvH", "<cmd>DiffviewFileHistory<cr>", desc = "Repo history" },
    { "<leader>gvc", "<cmd>DiffviewClose<cr>", desc = "Close" },
  },
}
