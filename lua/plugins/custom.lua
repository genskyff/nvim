if vim.fn.has "win32" == 1 then
  local shell_env = vim.env.SHELL
  local shell = (shell_env and vim.fn.executable(shell_env) == 1) and shell_env
    or (vim.fn.executable "nu" == 1) and "nu"
    or (vim.fn.executable "pwsh" == 1) and "pwsh"
    or "powershell"

  vim.opt.shell = shell

  if shell:find "nu" then
    vim.opt.shellcmdflag = "-c"
    vim.opt.shellredir = "| save --force %s"
    vim.opt.shellpipe = "| complete | save --force %s"
    vim.opt.shellquote = ""
    vim.opt.shellxquote = ""
  elseif shell:find "pwsh" or shell:find "powershell" then
    vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
    vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
    vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
    vim.opt.shellquote = ""
    vim.opt.shellxquote = ""
  end
end

---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      options = {
        opt = {
          wrap = true,
          tabstop = 4,
          shiftwidth = 4,
          softtabstop = 4,
          expandtab = true,
        },
      },
      mappings = {
        i = {
          ["jk"] = { "<Esc>", desc = "Exit insert mode" },
          ["kj"] = { "<Esc>", desc = "Exit insert mode" },
        },
      },
    },
  },
  {
    "NMAC427/guess-indent.nvim",
    opts = {},
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          never_show = {
            ".git",
            ".DS_Store",
            ".idea",
          },
        },
      },
    },
  },
}
