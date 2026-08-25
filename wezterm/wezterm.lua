local wezterm = require 'wezterm'

local config = {}

-- Colors / theme: Nord (Gogh)
config.color_scheme = 'Nord (Gogh)'

-- Font
config.font = wezterm.font_with_fallback {
    {
        family = 'DejaVuSansM Nerd Font',
        weight = 'Regular',
        italic = false,
    },
}
config.font_size = 12
config.line_height = 1.0
config.harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' }

-- Window appearance
config.window_decorations = 'NONE'
config.window_background_opacity = 0.85
config.text_background_opacity = 0.85

-- NOTE: macOS-only blur option removed; on Linux blur is compositor-driven.

-- Dark-themed decorations variant
config.window_frame = {
    active_titlebar_bg = '#2e3440',
    inactive_titlebar_bg = '#2e3440',
    active_titlebar_fg = '#d8dee9',
    inactive_titlebar_fg = '#4c566a',
}

-- Padding
config.window_padding = {
    left = 8,
    right = 8,
    top = 10,
    bottom = 10,
}

-- Scrolling
config.scrollback_lines = 100000

-- Cursor
config.default_cursor_style = 'BlinkingBar'

-- Tabs: keep them, Nord-ish look, compact
config.use_fancy_tab_bar = true
config.show_tabs_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = true

-- Optional: Nord-style tab colors
config.colors = config.colors or {}
config.colors.tab_bar = {
    background = '#2e3440',

    active_tab = {
        bg_color = '#4c566a',
        fg_color = '#eceff4',
        intensity = 'Normal',
        underline = 'None',
        italic = false,
        strikethrough = false,
    },

    inactive_tab = {
        bg_color = '#3b4252',
        fg_color = '#d8dee9',
        intensity = 'Normal',
        underline = 'None',
        italic = false,
        strikethrough = false,
    },

    inactive_tab_hover = {
        bg_color = '#434c5e',
        fg_color = '#eceff4',
        italic = false,
    },

    new_tab = {
        bg_color = '#2e3440',
        fg_color = '#d8dee9',
    },

    new_tab_hover = {
        bg_color = '#434c5e',
        fg_color = '#eceff4',
        italic = false,
    },
}

-- Helper: basename of a path string
local function basename(path)
return path:gsub('(.*[/\\])(.*)', '%2')
end

-- Set tab title to current working directory basename
-- Set tab title to current command, falling back to directory
wezterm.on('format-tab-title', function(tab, tabs, panes, cfg, hover, max_width)
local pane = tab.active_pane

local title = pane and pane.title or ''

if title == '' then
    local cwd = pane and pane.current_working_dir or nil
    local cwd_str = cwd and tostring(cwd) or ''

cwd_str = cwd_str:gsub('^file://', '')
title = basename(cwd_str)
end

if title == '' then
    title = 'shell'
end

return {
    { Text = ' ' .. title .. ' ' },
}
end)

return config
