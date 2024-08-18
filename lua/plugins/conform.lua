local conform = require("conform")

conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        javascript = { { "prettierd", "prettier", stop_after_first = true } },
        typescript = { { "prettierd", "prettier", stop_after_first = true } },
        javascriptreact = { { "prettierd", "prettier", stop_after_first = true } },
        typescriptreact = { { "prettierd", "prettier", stop_after_first = true } },
        json = { { "prettierd", "prettier", stop_after_first = true } },
        markdown = { { "prettierd", "prettier", stop_after_first = true } },
        html = { "htmlbeautifier" },
        bash = { "beautysh" },
        proto = { "buf" },
        yaml = { "yamlfix" },
        toml = { "taplo" },
        css = { { "prettierd", "prettier", stop_after_first = true } },
        scss = { { "prettierd", "prettier", stop_after_first = true } },
        sh = { "shellcheck" },
        go = { "gofmt" },
    },
})

vim.keymap.set({ "n", "v" }, "<leader>wf", function()
    conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
    })
end, { desc = "Format file or range (in visual mode)" })
