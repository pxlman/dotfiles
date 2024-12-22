
#
# Please note not all available settings / options are set here.
# For a full list, see the wiki
#


# See https://wiki.hyprland.org/Configuring/Monitors/
monitor=,preferred,auto,auto


# See https://wiki.hyprland.org/Configuring/Keywords/ for more

# Execute your favorite apps at launch
exec-once = waybar
exec-once = swaybg -i ~/Pictures/Wallpapers/
exec-once = hyprpaper
exec-once = swaync --config ~/.config/hypr/swaync/config.json

# Source a file (multi-file configs)
# source = ~/.config/hypr/myColors.conf

# Set programs that you use
$terminal = alacritty
$fileManager = nemo
$menu = rofi

# Some default env vars.
env = XCURSOR_SIZE,11
env = QT_QPA_PLATFORMTHEME,qt5ct # change to qt6ct if you have that

# For all categories, see https://wiki.hyprland.org/Configuring/Variables/
input {
    kb_layout = us,ara
    #kb_variant =
    #kb_model =
    kb_options = grp:alt_space_toggle
    #kb_rules =

    follow_mouse = 0

    touchpad {
        natural_scroll = yes
    }

    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
}

general {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    gaps_in = 3
    gaps_out = 10
    border_size = 2
    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    col.inactive_border = rgba(595959aa)

    layout = dwindle

    # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
    allow_tearing = false
}

decoration {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    rounding = 10
    
    blur {
        enabled = true
        size = 4
        passes = 1
    }
    # ???
    # drop_shadow = yes 
    # shadow_range = 4
    # shadow_render_power = 3
    # col.shadow = rgba(1a1a1aee)
}

animations {
    enabled = yes

    # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

    bezier = myBezier, 0.05, 0.9, 0.1, 1.05

    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 2, default
    animation = workspaces, 1, 6, default
}

dwindle {
    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = yes # you probably want this
}

master {
    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    # new_is_master = true ???
}

gestures {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more
    workspace_swipe = on
}

misc {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more
    force_default_wallpaper = -1 # Set to 0 or 1 to disable the anime mascot wallpapers
}

# Example per-device config
# See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
device:epic-mouse-v1 {
    # sensitivity = -0.5 ???
}

# Example windowrule v1
# windowrule = float, ^(kitty)$
# Example windowrule v2
# windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
#########################
#			
#	Window Rules    
#			
#########################
# windowrulev2 = nomaximizerequest, class:.* # You'll probably like this. ???

#########################
#			
#	Workspace Rules   
#			
#########################
workspace = 3, rounding:false, decorate:false
workspace = name:coding, rounding:false, decorate:false, gapsin:0, gapsout:0, border:false, decorate:false, monitor:DP-1
workspace = 8,bordersize:8
workspace = name:Hello, monitor:DP-1, default:true
workspace = name:gaming, monitor:desc:Chimei Innolux Corporation 0x150C, default:true
workspace = 2, on-created-empty:[float] firefox
workspace = special:scratchpad, on-created-empty:foot

$ws1 = 
$ws2 = 
$ws3 = 
$ws4 = 
$ws5 = 5 
$ws6 = 6
$ws7 = 7
$ws8 = 8
$ws9 = 
$ws10 = 


#########################
#			
#	Bindings   
#			
#########################

# See https://wiki.hyprland.org/Configuring/Keywords/ for more
$mainMod = SUPER

# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
bind = $mainMod, RETURN, exec, $terminal
bind = , PRINT, exec, grimblast copysave area ~/Pictures/Screenshots/
bind = SHIFT, PRINT, exec, grimblast copysave screen ~/Pictures/Screenshots/
bind = $mainMod, F2, exec, firefox
bind = $mainMod, F1, exec, $fileManager
bind = $mainMod, Q, killactive, 
bind = SUPER_ALT, Q, exit, 
bind = $mainMod, R, togglefloating, 
bind = $mainMod, D, exec, $menu -show drun
bind = $mainMod, P, pseudo, # dwindle
bind = $mainMod, M, togglesplit, # dwindle
bind = , XF86AudioLowerVolume, exec, pamixer --decrease 10 --allow-boost
bind = , XF86AudioRaiseVolume, exec, pamixer --increase 10 --allow-boost --set-limit 200
bind = , XF86AudioMute, exec, pamixer --toggle-mute
bind = , XF86Explorer, exec, brightnessctl set 5%-
bind = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
bind = , XF86Search, exec, brightnessctl set +5%
bind = , XF86MonBrightnessUp, exec, brightnessctl set +5%

# Move focus with mainMod + arrow keys
bind = $mainMod, h, movefocus, l
bind = $mainMod, l, movefocus, r
bind = $mainMod, k, movefocus, u
bind = $mainMod, j, movefocus, d

# Switch workspaces with mainMod + [0-9]
bind = $mainMod, 1, workspace, name:$ws1
bind = $mainMod, 2, workspace, name:$ws2
bind = $mainMod, 3, workspace, name:$ws3
bind = $mainMod, 4, workspace, name:$ws4
bind = $mainMod, 5, workspace, name:$ws5
bind = $mainMod, 6, workspace, name:$ws6
bind = $mainMod, 7, workspace, name:$ws7
bind = $mainMod, 8, workspace, name:$ws8
bind = $mainMod, 9, workspace, name:$ws9
bind = $mainMod, 0, workspace, name:$ws10

# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspace, name:$ws1
bind = $mainMod SHIFT, 2, movetoworkspace, name:$ws2
bind = $mainMod SHIFT, 3, movetoworkspace, name:$ws3
bind = $mainMod SHIFT, 4, movetoworkspace, name:$ws4
bind = $mainMod SHIFT, 5, movetoworkspace, name:$ws5
bind = $mainMod SHIFT, 6, movetoworkspace, name:$ws6
bind = $mainMod SHIFT, 7, movetoworkspace, name:$ws7
bind = $mainMod SHIFT, 8, movetoworkspace, name:$ws8
bind = $mainMod SHIFT, 9, movetoworkspace, name:$ws9
bind = $mainMod SHIFT, 0, movetoworkspace, name:$ws10

# Example special workspace (scratchpad)
bind = $mainMod, S, togglespecialworkspace, magic
bind = $mainMod SHIFT, S, movetoworkspace, special:magic

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow
