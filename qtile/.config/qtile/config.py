from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = guess_terminal()

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "j", lazy.layout.next(), desc="Move window focus to other window"),
    Key([mod], "k", lazy.layout.previous(), desc="Move window focus to previous window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "shift"], "y", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "shift"], "o", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "shift"], "u", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "shift"], "i", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "f", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    # Key( [mod], "f", lazy.window.toggle_fullscreen(),
    #     desc="Toggle fullscreen on the focused window",
    # ),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    Key([mod], "r", lazy.spawn("dmenu_run"), desc="Spawn a command using dmenu"),
    Key([mod], "y", lazy.spawn("firefox"), desc="Launch the browser"),
    Key([mod], "g", lazy.spawn("flameshot gui"), desc="Take a screenshot"),
    Key([mod], "u", lazy.window.bring_to_front(), desc="Bring a window to the front"),

    Key(["mod1"], "Shift_L", lazy.widget["keyboardlayout"].next_keyboard(), desc="Change keyboard layout"),
    Key(["shift"], "Alt_L", lazy.widget["keyboardlayout"].next_keyboard(), desc="Change keyboard layout"),
]

groups = [Group(i) for i in "1234"]

for i in groups:
    keys.extend(
        [
            # mod1 + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + group number = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
        ]
    )

layouts = [
    layout.Columns(
        border_focus="#11a8cd",
        border_normal="#3f3f3f",
        border_on_single=True,
    ),
    layout.Max(
        border_focus="#11a8cd",
        border_normal="#3f3f3f",
        border_width=2,
    ),
]

widget_defaults = dict(
    font="Cascadia Code PL",
    fontsize=14,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                # keyb, volume, power, memusage, cpuusage, temp, net inout
                widget.GroupBox(
                    highlight_method="block",
                    rounded=False,
                    this_current_screen_border="#11a8cd",
                    this_screen_border="#2472c8",
                    inactive="#717171",
                    background="#1a1a1a"
                ),
                widget.WindowTabs(
                    selected=("<b><i>", "</i></b>"),
                    foreground="#11a8cd",
                    background="#1a1a1a"
                ),

                widget.Notify(),
                widget.Systray(background="#1a1a1a"),
                widget.KeyboardLayout(
                    configured_keyboards=["us", "ru"], background="#313131"
                ),
                widget.Volume(fmt="󰕾 {}", background="#1a1a1a"),
                widget.Backlight(
                    backlight_name="intel_backlight",
                    step=5,
                    fmt="󰃠 {}",
                    background="#313131"
                ),
                widget.BatteryIcon(update_interval=1, background="#313131"),
                widget.Battery(
                    format="{percent:2.0%}",
                    update_interval=1,
                    background="#313131"
                ),
                widget.Memory(
                    format="󱉟 {MemUsed:.0f}{mm}/{MemTotal:.0f}{mm}",
                    background="#1a1a1a"
                ),
                widget.CPU(format=" {load_percent}%", background="#313131"),
                widget.ThermalSensor(
                    format=" {temp:.1f}{unit}",
                    tag_sensor="Core 0",
                    background="#1a1a1a"
                ),
                widget.Net(
                    format="↓{down:6.2f}{down_suffix:<2}",
                    foreground="#2472c8",
                    background="#313131"
                ),
                widget.Net(
                    format="↑{up:6.2f}{up_suffix:<2}",
                    foreground="#11a8cd",
                    background="#313131"
                ),
                widget.Clock(format="%a %d/%m %H:%M", background="#1a1a1a"),
                widget.CurrentLayoutIcon(background="#313131"),
            ],
            20,
            border_width=[0, 0, 0, 0],  # Draw top and bottom borders
        ),
        wallpaper="~/downloads/pics/dragon.jpg",
        wallpaper_mode="fill",
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    # Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = True
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
    ],
    border_focus="#11a8cd",
    border_normal="#3f3f3f",
    border_width=2
)
auto_fullscreen = True
focus_on_window_activation = "focus"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = False

wmname = "LG3D"
