from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
alt = "mod1"
terminal = "alacritty"
filemanager = "nemo"
browser = "firefox"
# Screenshots with flameshot
# Audio with pamixer
# Brightness with brightnessctl
# Menu with Dmenu
# Autostart apps
rtile.cmd_spawn('xsetroot -cursor_name left_ptr')
#lazy.spawn("pkill polybar")
#lazy.spawn("polybar &")

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "grave", lazy.group.next_window(), desc="Move window focus to next window"),
    Key([mod,"shift"], "grave", lazy.group.prev_window(), desc="Move window focus to prev window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # My Custom bindings {{{
    Key([mod], "F1", lazy.spawn(filemanager), desc="Launch File Manager"),
    Key([mod], "F2", lazy.spawn(browser), desc="Launch Browser"),
    # Screenshots
    Key([], "print", lazy.spawn("flameshot gui --clipboard --path ~/Pictures/Screenshots/"), desc="Flameshot area mode"),
    Key(["shift"], "print", lazy.spawn("flameshot full --clipboard --path ~/Pictures/Screenshots/"), desc="Flameshot full screen"),
    # Volume inc/dec
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pamixer --increase 10"), desc="Raise Volume"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pamixer --decrease 10"), desc="Lower Volume"),
    Key([], "XF86AudioMute", lazy.spawn("pamixer --toggle-mute"), desc="Mute Volume"),
    # Brightness Down
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 5%-"), desc="Decrease Brightness"),
    Key([], "XF86Explorer", lazy.spawn("brightnessctl set 5%-"), desc="Decrease Brightness"),
    # Brightness UP
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set 5%+"), desc="Increase Brightness"),
    Key([], "XF86Search", lazy.spawn("brightnessctl set 5%+"), desc="Increase Brightness"),
    # }}}
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod], "escape", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "mod1"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "d", lazy.spawn("dmenu_run"), desc="Spawn a command using a prompt widget"),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


groups = []
group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9",]

group_labels = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX",]
#group_labels = ["", "", "", "", "", "", "", "", "",]

group_layouts = ["columns", "max", "max", "max", "max", "max", "max", "max", "max"]
group_spawns = ["","","","","","","","",""]
group_matches = [
	[Match(wm_class="Alacritty")],
	[Match(wm_class="firefox"),Match(wm_class="Nemo")],
	[Match(wm_class="discord"),Match(wm_class="TelegramDesktop")],
	[],
	[],
	[],
	[],
	[],
	[],
]
group_init=[True,True,True,True,True,True,True,True,True]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
	    spawn=group_spawns[i],
	    position=i,
	    matches=group_matches[i],
	    exclusive=False,
	    init=group_init[i]
            ))

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=False),
                desc="Move focused window to group {}".format(i.name),
            ),
        ]
    )


foreground_color = "#660099"
foreground_depth = "#bb00ff"
barFore = "#D9E8E6"
barPrim = "#032B43"
barPrim2 = "#395b6c"
barBack = "#93abb2"
barPrimDepth = ""
barSec = ""
layouts = [
    # For tiling
    layout.Columns(
        border_focus=[barBack, barPrim2],
        border_width=5,
        margin=4,
        insert_position=1,
        split=True
        ),
    # For Max windows
    layout.Max(),
    # For Stacking
    layout.Columns(
        border_focus=[barBack, barPrim2],
        border_width=5,
        margin=4,
        insert_position=1,
        split=False
        ),
    #layout.Stack(num_stacks=2,border_width=5,border_focus=foreground_color,margin=1),
    #layout.Zoomy(),
]


widget_defaults = dict(
    font="Hack",
    fontsize=14,
    foreground = barFore,
    background = barBack,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
     Screen(
         top=bar.Bar(
             [
 		widget.Sep(
 			padding=5,
 			linewidth=1,
 			background=barPrim
 			),
                 widget.GroupBox(
 			foreground = barFore,
 			background = barPrim,
 			disable_drag = True,
 			highlight_method = 'block',
 			this_current_screen_border = barPrim2,
                     ),
                 widget.TextBox(
                     text="",
                     padding=0,
                     fontsize=70,
                     foreground=barPrim,
                     background= barPrim2,
                     ),
                 widget.TextBox(
                     text=" ",
                     padding=0,
                     fontsize=70,
                     foreground=barPrim2,
                     background= barBack,
                     ),
                 widget.WindowName(
                     max_chars=30,
                     foreground = barPrim,
                     background = barBack,
                     ),
                 widget.Chord(
                     chords_colors={
                         "launch": ("#ff0000", "#ffffff"),
                     },
                     name_transform=lambda name: name.upper(),
                 ),
                 widget.TextBox(
                     text="",
                     padding=0,
                     fontsize=70,
                     foreground=barPrim2,
                     background= barBack,
                     ),
                 widget.TextBox(
                     text="",
                     padding=0,
                     fontsize=68,
                     foreground=barPrim,
                     background= barPrim2,
                     ),
                 widget.Systray(
                     #foreground = barPrim,
                     background = barPrim,
                     ),
                 widget.Clock(
                     format=" | 󰻙 %Y-%m-%d  %I:%M %p | ",
                     foreground = barFore,
                     background = barPrim,
                     ),
                 widget.QuickExit(
                     foreground = barFore,
                     background = barPrim,
                     ),
             ],
             24,
             # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
             # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
         ),
         # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
         # By default we handle these events delayed to already improve performance, however your system might still be struggling
         # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
         # x11_drag_polling_rate = 60,
     ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
