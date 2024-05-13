{ lib, config, pkgs, username, ... }:

{
    programs = {
        tmux = {
            enable = true;
            mouse = false;
            baseIndex = 1;
            plugins = with pkgs; [
                tmuxPlugins.sensible
                tmuxPlugins.cpu
                {
                    plugin = pkgs.tmuxPlugins.mkTmuxPlugin {
                        pluginName = "nova";
                        version = "unstable-2023-01-06";
                        src = pkgs.fetchFromGitHub {
                            owner = "o0th";
                            repo = "tmux-nova";
                            rev = "1.1.0";
                            sha256 = "1A7pnMMOwp1K7+WAAKbTqrMpm/wcorui6TQDHm8Xzd8=";
                        };
                    };
                    extraConfig = ''
                        set -g @nova-nerdfonts true
                        set -g @nova-nerdfonts-left 
                        set -g @nova-nerdfonts-right 

                        set -g @nova-pane-active-border-style "#44475a"
                        set -g @nova-pane-border-style "#282a36" 
                        set -g @nova-status-style-bg "#16161e"
                        set -g @nova-status-style-fg "#d8dee9"
                        set -g @nova-status-style-active-bg "#3b4261"
                        set -g @nova-status-style-active-fg "#7aa2f7"
                        set -g @nova-status-style-double-bg "#2d3540"

                        set -g @nova-pane "#I#{?pane_in_mode,  #{pane_mode},}  #W"

                        set -g @nova-segment-mode "#{?client_prefix,Ω,ω}"
                        set -g @nova-segment-mode-colors "#7aa2f7 #2e3440"

                        set -g @nova-segment-whoami "#(whoami)@#h"
                        set -g @nova-segment-whoami-colors "#7aa2f7 #2e3440"

                        set -g @nova-rows 0
                        set -g @nova-segments-0-left "mode"
                        set -g @nova-segments-0-right "whoami"

                        set -g status-right '[#(TZ="Europe/Stockholm" date +"%%Y-%%m-%%d %%H:%%M")]'
                    '';
                }
            ];
            extraConfig = ''
                # Smart pane switching with awareness of Vim splits.
                # See: https://github.com/christoomey/vim-tmux-navigator
                
                # decide whether we're in a Vim process
                is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
                    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

                bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
                bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
                bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
                bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'

                bind-key -n M-Left send-keys M-b
                bind-key -n M-Right send-keys M-f

                tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'

                if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
                    "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
                if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
                    "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

                bind-key -n 'C-Space' if-shell "$is_vim" 'send-keys C-Space' 'select-pane -t:.+'

                bind-key -T copy-mode-vi 'C-h' select-pane -L
                bind-key -T copy-mode-vi 'C-j' select-pane -D
                bind-key -T copy-mode-vi 'C-k' select-pane -U
                bind-key -T copy-mode-vi 'C-l' select-pane -R
                bind-key -T copy-mode-vi 'C-\' select-pane -l
                bind-key -T copy-mode-vi 'C-Space' select-pane -t:.+
            '';
        };
        
        starship = {
            enable = true;
            settings = {
                add_newline = false;
                right_format = "$time $battery";

                format = lib.concatStrings [
                    "(\n"
                    "$rust"
                    "[ ](fg:#5294aa bg:#006699)"
                    "$git_branch"
                    "[](fg:#006699)"
                    ")"
                    "$fill$character"
                    "$cmd_duration"
                    "\n"
                    "($directory)[ ](fg:#5294aa)"
                ];

                fill = {
                    symbol = " ";
                };

                character = {
                    success_symbol = "[  ](green)";
                    error_symbol = "[  ](red)";
                };

                git_branch = {
                    style = "fg:#ffffff bg:#006699 bold";
                    format = "[  ](fg:#f34f29  bg:#006699)[$branch ]($style)";
                };

                directory = {
                    style = "fg:#e3e5e5 bg:#5294aa";
                    format = "[ $path ]($style)";
                    truncation_length = 2;
                    truncation_symbol = "󰇘/";
                };

                battery = {
                    full_symbol = "󰁹 ";
                    charging_symbol = "󰢜 ";
                    discharging_symbol = "󰁺 ";
                    format = "[$symbol$percentage]($style)";
                };

                rust = {
                    style = "";
                    symbol = "🦀";
                    version_format = "\${raw}";
                    format = "[ $symbol $version](bg:#006699 bold)";
                };

                cmd_duration = {
                    show_notifications = true;
                    min_time = 2000;
                    format = "took [$duration ]($style)";
                };

                time = {
                    style = "fg:#7F8080";
                    format = "[$time]($style)";
                    disabled = false;
                };
            };
        };

        zsh = {
            enable = true;
            autocd = true;
            history.share = false;
            shellAliases = {
                "."="cd";
                ".."="cd ..";
                "..."="cd ../..";
                "...."="cd ../../..";
                "....."="cd ../../../..";
                "......"="cd ../../../../..";

                c   = "clear";
                sz  = "source ~/.zshrc";
                cwd = "pwd";

                clip = "xsel -b";

                v  = "nvim";
                vi = "nvim init.*";
                vm = "nvim main.*";

                ls = "eza";
                l  = "eza -a";
                ll = "eza -l";
                la = "eza -la";

                g   = "git";
                gs  = "git status";
                gd  = "git diff";
                gl  = "git log";
                glg = "git log --graph --oneline --all";
                ga  = "git add";
                gaa = "git add .";
                gc  = "git commit";
                gcm = "git commit -m";
                gp  = "git push";
                gpl = "git pull";

                ta  = "tmux attach";
                tls = "tmux ls";
                tns = "tmux new";
            };
            sessionVariables = {
                PATH = "$HOME/.cargo/bin:$PATH";
            };

            envExtra = 
                ". \"$HOME/.cargo/env\"
                eval \"$(starship init zsh)\"
                eval \"$(direnv hook zsh)\"";
        };

        git = {
            enable = true;
            extraConfig = {
                user = {
                    name = "Square-face";
                    email = "linus.michelsson@gmail.com";
                };
                core = {
                    editor = "nvim";
                };
                "credential \"https://github.com\"" = {
                    helper = "!/run/current-system/sw/bin/gh auth git-credential";
                };
                "credential \"https://gist.github.com\"" = {
                    helper = "!/run/current-system/sw/bin/gh auth git-credential";
                };
            };
        };

        kitty = {
            enable = true;
            settings = {
                font_family = "Fira Code Nerd Font";
                background_opacity = "0.8";
                background_blur = "10";
                enable_audio_bell = "no";
            };
        };

        ncspot = {
            enable = true;
            settings = {
                use_nerdfont = true;
            };
        };
    };

    wayland.windowManager.hyprland = {
        enable = true;

        settings = {
            monitor = [
                "DP-3,1200x1920,2560x-240,1"
                "HDMI-A-1,2560x1440,0x0,1"
            ];

            exec-once = "shikane-o & waybar & swww init";

            env = [
                "WLR_DRM_NO_ATMOIC,1"
                "XCURSOR_SIZE,24"
                "QT_QPA_PLATFORMTHEME,qt5xt"
            ];

            "$terminal" = "kitty";
            "$fileManager" = "dolphin";
            "$menu" = "wofi --show drun";
            "$mainMod" = "SUPER";

            bind = [
                "$mainMod, SPACE, exec, $menu"
                "$mainMod, T, exec, $terminal"
                "$mainMod+SHIFT, SPACE, exec, 1password --quick-access"
                "$mainMod, Q, killactive"
                "$mainMod, F, fullscreen, 0"
                "$mainMod+SHIFT, F, workspaceopt, allfloat"
                "$mainMod, P, togglefloating"
                "$mainMod, R, togglesplit"
                "$mainMod, XF86AudioRaiseVolume, exec, pamixer -i 7 && pkill -RTMIN+8 waybar"
                "$mainMod, XF86AudioLowerVolume, exec, pamixer -d 7 && pkill -RTMIN+8 waybar"
                ", XF86AudioMute, exec, pamixer -t && pkill -RTMIN+8 waybar"

                "$mainMod, left , movefocus, l"
                "$mainMod, right, movefocus, r"
                "$mainMod, up   , movefocus, u"
                "$mainMod, down , movefocus, d"
                "$mainMod, h, movefocus, l"
                "$mainMod, l, movefocus, r"
                "$mainMod, k, movefocus, u"
                "$mainMod, j, movefocus, d"

                "$mainMod+SHIFT, left , swapwindow, l"
                "$mainMod+SHIFT, right, swapwindow, r"
                "$mainMod+SHIFT, up   , swapwindow, u"
                "$mainMod+SHIFT, down , swapwindow, d"
                "$mainMod+SHIFT, h, swapwindow, l"
                "$mainMod+SHIFT, l, swapwindow, r"
                "$mainMod+SHIFT, k, swapwindow, u"
                "$mainMod+SHIFT, j, swapwindow, d"

                "$mainMod, 1, workspace, 1"
                "$mainMod, 2, workspace, 2"
                "$mainMod, 3, workspace, 3"
                "$mainMod, 4, workspace, 4"
                "$mainMod, 5, workspace, 5"
                "$mainMod, 6, workspace, 6"
                "$mainMod, 7, workspace, 7"
                "$mainMod, 8, workspace, 8"
                "$mainMod, 9, workspace, 9"
                "$mainMod, 0, workspace, 10"
                
                "$mainMod SHIFT, 1, movetoworkspace, 1"
                "$mainMod SHIFT, 2, movetoworkspace, 2"
                "$mainMod SHIFT, 3, movetoworkspace, 3"
                "$mainMod SHIFT, 4, movetoworkspace, 4"
                "$mainMod SHIFT, 5, movetoworkspace, 5"
                "$mainMod SHIFT, 6, movetoworkspace, 6"
                "$mainMod SHIFT, 7, movetoworkspace, 7"
                "$mainMod SHIFT, 8, movetoworkspace, 8"
                "$mainMod SHIFT, 9, movetoworkspace, 9"
                "$mainMod SHIFT, 0, movetoworkspace, 10"

                "$mainMod, S, togglespecialworkspace, magic"
                "$mainMod SHIFT, S, movetoworkspace, special:magic"

                "$mainMod, mouse_down, workspace, e+1"
                "$mainMod, mouse_up, workspace, e-1"
            ];

            bindm = [
                "$mainMod, mouse:272, movewindow"
                "$mainMod, mouse:273, resizewindow"
            ];

            binde = [
                ", XF86AudioRaiseVolume, exec, pamixer -i 1 && pkill -RTMIN+8 waybar"
                ", XF86AudioLowerVolume, exec, pamixer -d 1 && pkill -RTMIN+8 waybar"
                ", XF86MonBrightnessUp, exec, light -A 5 && pkill -RTMIN+8 waybar"
                ", XF86MonBrightnessDown, exec, light -U 5 && pkill -RTMIN+8 waybar"

                "$mainMod, XF86MonBrightnessUp, exec, light -s sysfs/leds/kbd_backlight -A 5 && pkill -RTMIN+8 waybar"
                "$mainMod, XF86MonBrightnessDown, exec, light -s sysfs/leds/kbd_backlight -U 5 && pkill -RTMIN+8 waybar"
            ];

            input = {
                kb_layout = "se";
                kb_variant = "";
                kb_model = "";
                kb_options = "";
                kb_rules = "";

                follow_mouse = "1";

                touchpad = {
                    natural_scroll = "no";
                };

                sensitivity = "0.2";
            };

            general = {
                gaps_in = "15";
                gaps_out = "25";

                border_size = "1";
                resize_on_border = "true";

                allow_tearing = "true";
                layout = "dwindle";

                "col.active_border" = "rgb(9ece6a) rgb(7aa2f7) 45deg";
                "col.inactive_border" = "rgba(7aa2f760)";
            };

            decoration = {
                rounding = "0";

                drop_shadow = "no";

                blur = {
                    enabled = "true";
                    size = "3";
                    passes = "1";
                };
            };

            animations = {
                enabled = "yes";
                bezier = "myBezier, 0.05, 0.9, 0, 1.01";

                animation = [
                    "windows, 0, 10, myBezier"
                    "windowsOut, 0, 3, default, popin 80%"
                    "border, 1, 3, default"
                    "borderangle, 1, 8, default"
                    "fade, 0, 7, default"
                    "workspaces, 1, 6, default"
                ];
            };

            dwindle = {
                pseudotile = "yes";
                preserve_split = "yes";
            };

            master = {
                new_is_master = "true";
            };

            gestures = {
                workspace_swipe = "on";
                workspace_swipe_invert = "no";
                workspace_swipe_min_speed_to_force = "0";
                workspace_swipe_cancel_ratio = "0.1";
                workspace_swipe_create_new = "yes";
                workspace_swipe_direction_lock = "no";
            };
        };
    };


    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages = [
        pkgs.bat
        pkgs.libnotify
        pkgs.dust
        pkgs.dunst

        # # Adds the 'hello' command to your environment. It prints a friendly
        # # "Hello, world!" when run.
        # pkgs.hello

        # # It is sometimes useful to fine-tune packages, for example, by applying
        # # overrides. You can do that directly here, just don't forget the
        # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
        # # fonts?
        # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

        # # You can also create simple shell scripts directly inside your
        # # configuration. For example, this adds a command 'my-hello' to your
        # # environment:
        # (pkgs.writeShellScriptBin "my-hello" ''
        #   echo "Hello, ${config.home.username}!"
        # '')
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
        # # Building this configuration will create a copy of 'dotfiles/screenrc' in
        # # the Nix store. Activating the configuration will then make '~/.screenrc' a
        # # symlink to the Nix store copy.
        # ".screenrc".source = dotfiles/screenrc;

        # # You can also set the file content immediately.
        # ".gradle/gradle.properties".text = ''
        #   org.gradle.console=verbose
        #   org.gradle.daemon.idletimeout=3600000
        # '';
        ".config/shikane/config.toml".text = ''
        [[profile]]
        name = "dual_foo"
        exec = ["notify-send shikane \"Profile $SHIKANE_PROFILE_NAME has been applied\""]
            [[profile.output]]
            match = "HDMI-A-1"
            enable = true
            exec = ["hyprctl dispatch moveworkspacetomonitor 1 HDMI-A-1"]
            mode = { width = 2560, height = 1440, refresh = 60 }
            position = { x = 0, y = 240 }

            [[profile.output]]
            match = "DP-3"
            enable = true
            exec = ["hyprctl dispatch moveworkspacetomonitor 2 DP-3"]
            mode = { width = 1920, height = 1200, refresh = 60 }
            position = { x = 2560, y = 0 }
            transform = "90"
        '';
    };

    home.sessionVariables = {};

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "23.11"; # Please read the comment before changing.
}
