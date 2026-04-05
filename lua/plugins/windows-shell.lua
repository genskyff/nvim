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

return {}
