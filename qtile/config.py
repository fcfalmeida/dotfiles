import os
import subprocess

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile import hook
import qtile_progress_widgets as qpw


@hook.subscribe.startup_once
def autostart():
    script = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen([script])


@hook.subscribe.screen_change
def restart_on_randr(_):
    subprocess.call(
        ["feh", "--bg-fill", os.path.expanduser("~/Pictures/Wallpapers/current.jpg")])


mod = "mod4"
terminal = "kitty"

keys = [
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key(
        [mod], "period", lazy.next_screen(),
    ),
    Key(
        [mod], "comma", lazy.prev_screen(),
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawn("rofi -show drun"), desc="Launch rofi"),
    Key([mod], "F9", lazy.spawn(os.path.expanduser(
        "~/.config/i3lock/lock.sh")), desc="Lock screen"),
    Key([mod, "control", "shift"], "p", lazy.spawn("shutdown -h now"), desc="Shutdown system")
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(
                    i.name),
            ),
        ]
    )

layouts = [
    layout.Columns(
        border_normal="#928374",
        border_focus="#ebdbb2",
        border_on_single=True,
        border_width=3,
        margin=0,
        margin_on_single=0),
    layout.Max(),
]

widget_defaults = dict(
    font="Terminess Nerd Font",
    fontsize=14,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    highlight_method="block",
                    this_current_screen_border="#d4be98",
                    this_screen_border="#d4be98",
                    urgent_border="#ea6962"
                ),
                widget.WindowName(),
                qpw.CPU(
                    progress_bar_colors = [
                        ((0, 75), ("#d4be98", "#7c6f64")),
                        ((75, 100), ("#ea6962", "#7c6f64"))
                    ],
                    progress_bar_inner_colors = [
                        ((0, 100), "#7c6f64"),
                    ],
                    icon_colors = [
                        ((0, 100), "ffffff")
                    ],
                    progress_bar_thickness = 3,
                    icon_size = 16,
                    font="sans"
                ),
                qpw.Memory(progress_bar_colors = [
                        ((0, 75), ("#d4be98", "#7c6f64")),
                        ((75, 100), ("#ea6962", "#7c6f64"))
                    ],
                    progress_bar_inner_colors = [
                        ((0, 100), "#7c6f64"),
                    ],
                    icon_colors = [
                        ((0, 100), "ffffff")
                    ],
                    progress_bar_thickness = 3,
                    icon_size = 22,
                    font="sans"
                ),
                qpw.Battery(progress_bar_colors = [
                        ((0, 25), ("#ea6962", "#7c6f64")),
                        ((25, 75), ("#d8a657", "#7c6f64")),
                        ((75, 100), ("#a9b665", "#7c6f64"))
                    ],
                    progress_bar_inner_colors = [
                        ((0, 100), "#7c6f64"),
                    ],
                    icon_colors = [
                        ((0, 100), "ffffff")
                    ],
                    progress_bar_thickness = 3,
                    icon_size = 16,
                    font="sans"
                ),
                widget.Clock(format="%b %d %H:%M")
            ],
            30,
            background="#28282860",
            opacity=0.92,
            margin=[0, 0, 0, 0],
        ),
    ),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
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

# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
