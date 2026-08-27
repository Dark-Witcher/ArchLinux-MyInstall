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

-- Window frame
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

-----------------------------------------------------------
-- TABS
-----------------------------------------------------------

config.use_fancy_tab_bar = true
config.show_tabs_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = true

config.colors = {
    tab_bar = {
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
    },
}

-----------------------------------------------------------
-- TAB TITLE
--
-- Idle:
--     ubuntu-server-toolkit
--
-- Running command:
--     git status
--
-- The shell's own terminal title is ignored.
-----------------------------------------------------------

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
local pane = tab.active_pane

if not pane then
    return {}
    end

    -------------------------------------------------------
    -- Current working directory
    -------------------------------------------------------

    local cwd = pane.current_working_dir

    if cwd then
        cwd = tostring(cwd)

        -- Remove file:// prefix
        cwd = cwd:gsub('^file://[^/]*', '')

        -- Decode spaces
        cwd = cwd:gsub('%%20', ' ')
        else
            cwd = ''
end

-- Get directory name only
local folder = cwd:match('([^/]+)/?$') or cwd

-------------------------------------------------------
-- Currently executing command
-------------------------------------------------------

local command = ''

if pane.user_vars then
    command = pane.user_vars.WEZTERM_PROG or ''
end

-------------------------------------------------------
-- Decide title
-------------------------------------------------------

local title

if command ~= '' then
    title = command
    else
        title = folder
        end

        -------------------------------------------------------
        -- Fallback
        -------------------------------------------------------

        if title == '' then
            title = 'terminal'
end

-------------------------------------------------------
-- Tab title
-------------------------------------------------------

return {
    { Text = ' ' .. title .. ' ' },
}
end)

return config


-----------------------------------------------------------
-- SYSTEM CONFIGURATION NOTE
--
-- WezTerm tab titles are controlled by this configuration.
-- The default Bash configuration on this system also sets
-- the terminal title via /etc/bash.bashrc, which overrides
-- the tab title behavior above.
--
-- If tabs show:
--     username@hostname:path
--
-- edit:
--     /etc/bash.bashrc
--
-- and comment out these two lines:
--
--     PROMPT_COMMAND+=('printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"')
--     PROMPT_COMMAND+=('printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"')
--
-- Then start a new terminal session.
--
-- These lines are intentionally disabled because they cause
-- Bash to overwrite the WezTerm tab title.
-----------------------------------------------------------
