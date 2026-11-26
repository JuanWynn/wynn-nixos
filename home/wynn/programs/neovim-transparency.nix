_:

{
  xdg.configFile."nvim/after/plugin/wynn-transparency.lua".text = ''
    local transparent_groups = {
      "Normal",
      "NormalNC",
      "NormalFloat",
      "FloatBorder",
      "SignColumn",
      "EndOfBuffer",
      "LineNr",
      "CursorLineNr",
      "FoldColumn",
      "WinSeparator",
    }

    local function apply_transparency()
      for _, group in ipairs(transparent_groups) do
        local highlight = vim.api.nvim_get_hl(0, { name = group, link = false })
        highlight.bg = "NONE"
        vim.api.nvim_set_hl(0, group, highlight)
      end
    end

    local group = vim.api.nvim_create_augroup("WynnTransparency", { clear = true })
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = group,
      callback = apply_transparency,
    })

    apply_transparency()
  '';
}
