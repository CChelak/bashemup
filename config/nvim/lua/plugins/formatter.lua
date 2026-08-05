return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters = {
      prettier = {
        -- Force prettier's own default (preserve existing line breaks) so a
        -- global ~/.prettierrc (proseWrap: always, printWidth: 120) can't
        -- hard-wrap markdown prose in repos that don't opt into that.
        args = { "--stdin-filepath", "$FILENAME", "--prose-wrap", "preserve" },
      },
      ["clang-format"] = {
        condition = function(_, ctx)
          return vim.fs.find(".clang-format", { path = ctx.dirname, upward = true })[1] ~= nil
        end,
      },
      ["markdown-toc"] = {
        condition = function(_, ctx)
          for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
            if line:find("<!%-%- toc %-%->") then
              return true
            end
          end
        end,
      },
      ["markdownlint-cli2"] = {
        condition = function(_, ctx)
          local diag = vim.tbl_filter(function(d)
            return d.source == "markdownlint"
          end, vim.diagnostic.get(ctx.buf))
          return #diag > 0
        end,
        --         args = { "--config", os.getenv("HOME") .. "/.config/markdownlint/.markdownlint.yaml" },
        cwd = require("conform.util").root_file({
          ".markdownlint.yaml",
          ".markdownlint.yml",
          ".markdownlint.json",
          ".markdownlint.jsonc",
          ".markdownlint-cli2.jsonc",
          ".markdownlint-cli2.yaml",
          ".git",
        }),
        require_cwd = false, -- fall back to buffer dir if no root marker found
      },
    },
    formatters_by_ft = {
      ["markdown"] = { "markdownlint-cli2", "markdown-toc" },
      ["markdown.mdx"] = { "markdownlint-cli2", "markdown-toc" },
      ["c"] = { "clang-format" },
      ["cpp"] = { "clang-format" },
    },
  },
}
