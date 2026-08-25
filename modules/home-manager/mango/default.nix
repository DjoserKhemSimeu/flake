{ inputs, pkgs, ... }:

{
  imports = [ inputs.mango.hmModules.mango ];

  home.packages = with pkgs; [
    brightnessctl
    grim
    playerctl
    slurp
    inputs.mangomon.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  wayland.windowManager.mango = {
    enable = true;

    systemd.enable = pkgs.stdenv.hostPlatform.isLinux;

    settings = {
      # input
      xkb_rules_layout = "fr";
      sloppyfocus = 1;
      warpcursor = 0;

      # look
      borderpx = 2;
      border_radius = 10;
      gappih = 4;
      gappiv = 4;
      gappoh = 4;
      gappov = 4;
      # Catppuccin Mocha hardcoded (no stylix)
      focuscolor  = "0xffcba6f7"; # mauve – active border
      bordercolor = "0xff313244"; # surface0 – inactive border
      rootcolor   = "0xff11111b"; # crust
      urgentcolor = "0xffcba6f7";

      # layout
      tagrule = [ "id:*,layout_name:fair" ];

      bind = [
        # terminal
        "ALT,RETURN,spawn,ghostty"

        # file manager
        "ALT,e,spawn,dolphin"

        # launcher — noctalia v4 IPC: noctalia-shell ipc call <cmd>
        "ALT,d,spawn,noctalia-shell ipc call launcher toggle"
        "SUPER,SUPER_L,spawn,noctalia-shell ipc call launcher toggle"

        # lock screen
        "ALT,l,spawn,noctalia-shell ipc call lockScreen lock"

        # window management
        "ALT,a,killclient"
        "ALT,f,togglefullscreen"
        "ALT,v,togglefloating"

        # layout switching
        "ALT,s,setlayout,scroller"   # scroller (scrolling)
        "ALT,w,setlayout,fair"       # fair (grid)
        "ALT,m,setlayout,monocle"    # monocle (fullscreen one window)
        "ALT,t,setlayout,tile"       # tile (master-stack)

        # focus (arrow keys – like hyprland)
        "ALT,left,focusdir,left"
        "ALT,right,focusdir,right"
        "ALT,up,focusdir,up"
        "ALT,down,focusdir,down"

        # move window (arrow keys)
        "ALT+SHIFT,left,exchange_client,left"
        "ALT+SHIFT,right,exchange_client,right"
        "ALT+SHIFT,up,exchange_client,up"
        "ALT+SHIFT,down,exchange_client,down"

        # tags – French AZERTY layout (same keys as hyprland workspaces)
        "ALT,ampersand,view,1"
        "ALT,eacute,view,2"
        "ALT,quotedbl,view,3"
        "ALT,apostrophe,view,4"
        "ALT,parenleft,view,5"
        "ALT,minus,view,6"
        "ALT,egrave,view,7"
        "ALT,underscore,view,8"
        "ALT,ccedilla,view,9"
        "ALT,agrave,view,10"

        "ALT+SHIFT,ampersand,tag,1"
        "ALT+SHIFT,eacute,tag,2"
        "ALT+SHIFT,quotedbl,tag,3"
        "ALT+SHIFT,apostrophe,tag,4"
        "ALT+SHIFT,parenleft,tag,5"
        "ALT+SHIFT,minus,tag,6"
        "ALT+SHIFT,egrave,tag,7"
        "ALT+SHIFT,underscore,tag,8"
        "ALT+SHIFT,ccedilla,tag,9"
        "ALT+SHIFT,agrave,tag,10"

        # screenshots (mirrors hyprland binds)
        "NONE,Print,spawn_shell,grim -g \"$(slurp)\" - | wl-copy"
        "SHIFT,Print,spawn_shell,grim -g \"$(slurp)\" - | swappy -f -"
        "CTRL,Print,spawn_shell,grim ~/Pictures/$(date +'%Y-%m-%d_%Hh%Mm%Ss_screenshot.png')"

        # media & brightness – direct commands (noctalia v4 has no volume/brightness IPC)
        "NONE,XF86AudioRaiseVolume,spawn,wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        "NONE,XF86AudioLowerVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        "NONE,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        "NONE,XF86AudioMicMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        "NONE,XF86MonBrightnessUp,spawn,brightnessctl -e4 -n2 set 5%+"
        "NONE,XF86MonBrightnessDown,spawn,brightnessctl -e4 -n2 set 5%-"
        "NONE,XF86AudioNext,spawn,playerctl next"
        "NONE,XF86AudioPause,spawn,playerctl play-pause"
        "NONE,XF86AudioPlay,spawn,playerctl play-pause"
        "NONE,XF86AudioPrev,spawn,playerctl previous"
      ];

      # drag to move/resize floating windows
      mousebind = [
        "ALT,btn_left,moveresize,curmove"
        "ALT,btn_right,moveresize,curresize"
      ];
    };

    # mirrors hyprland autostart
    autostart_sh = ''
      noctalia-shell &
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    '';
  };
}