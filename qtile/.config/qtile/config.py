from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = guess_terminal()

def switch_to_group(qtile, group_number):
    current_screen = qtile.screens.index(qtile.current_screen)
    name = f'{current_screen}{group_number}'
    qtile.focus_screen(current_screen)
    qtile.groups_map[name].cmd_toscreen()

def send_to_group(qtile, group_number):
    current_screen = qtile.screens.index(qtile.current_screen)
    name = f'{current_screen}{group_number}'
    qtile.focus_screen(current_screen)
    qtile.current_window.cmd_togroup(name, switch_group=True)

def send_to_screen(qtile):
    current_window = qtile.current_window
    current_screen = qtile.screens.index(qtile.current_screen)
    screen_number = 0
    if current_screen == 0:
        screen_number = 1
    qtile.focus_screen(screen_number)
    current_window.cmd_togroup(qtile.current_group.name)

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

    Key([mod, "control"], "j", lazy.next_screen(), desc="Next screen"),
    Key([mod, "control"], "k", lazy.next_screen(), desc="Next screen"),
    Key([mod], "o", lazy.function(send_to_screen), desc="Switch screens"),

    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "f", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "Tab", lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
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

groups_by_screens = [
    ["1", "2", "3", "4"], # screen 0
    ["1", "2", "3", "4"], # screen 1
]

groups = []
for screen, group_labels in enumerate(groups_by_screens):
    for i, label in enumerate(group_labels):
        groups.append(
            Group(name=f"{screen}{i + 1}", screen_affinity=screen, label=label)
        )

for i, group in enumerate(groups):
    keys.extend([
        Key([mod], str(i), lazy.function(switch_to_group, i), desc=f"Switch to group {group.name}"),
        Key([mod, "shift"], str(i), lazy.function(send_to_group, i), desc=f"Send window to group {group.name}"),
    ])

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

notify = widget.Notify()
keyboard = widget.KeyboardLayout(
    configured_keyboards=["us", "ru"], background="#313131"
)
memory = widget.Memory(
    format="󱉟 {MemUsed:.0f}{mm}",
    background="#1a1a1a"
)
cpu = widget.CPU(format=" {load_percent}%", background="#313131")
thermal_sensor = widget.ThermalSensor(
    format=" {temp:.1f}{unit}",
    tag_sensor="Tctl",
    background="#1a1a1a"
)
net_down = widget.Net(
    format="↓{down:6.2f}{down_suffix:<2}",
    foreground="#2472c8",
    background="#313131"
)
net_up = widget.Net(
    format="↑{up:6.2f}{up_suffix:<2}",
    foreground="#11a8cd",
    background="#313131"
)
clock = widget.Clock(format="%a %d/%m %H:%M", background="#1a1a1a")

wp = "~/Downloads/pics/dragon.jpg"
wp_mode = "fill"

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    visible_groups=[f"0{i + 1}" for i in range(4)],
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

                notify,
                widget.Systray(background="#1a1a1a"),
                keyboard,
                memory,
                cpu,
                thermal_sensor,
                net_down,
                net_up,
                clock,
                widget.CurrentLayoutIcon(background="#313131")
            ],
            19,
            border_width=[0, 0, 0, 0],  # Draw top and bottom borders
        ),
        wallpaper=wp,
        wallpaper_mode=wp_mode,
    ),
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    visible_groups=[f"1{i + 1}" for i in range(4)],
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

                notify,
                keyboard,
                memory,
                cpu,
                thermal_sensor,
                net_down,
                net_up,
                clock,
                widget.CurrentLayoutIcon(background="#313131")
            ],
            19,
            border_width=[0, 0, 0, 0],  # Draw top and bottom borders
        ),
        wallpaper=wp,
        wallpaper_mode=wp_mode,
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
