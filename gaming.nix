{
  pkgs,
  inputs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  hytale =
    inputs.hytale-launcher.packages.${system}.default.overrideAttrs (old: {
    });
  hytale-launcher-unwrapped =
    inputs.hytale-launcher.packages.${system}.hytale-launcher-unwrapped;
in {
  imports = [
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];

  # Star citizen
  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
    "fs.file-max" = 524288;
  };

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      extraPkgs = pkgs:
        with pkgs; [
          xorg.xkeyboardconfig
          libxkbcommon
          dotnet-sdk
          webkitgtk_4_1
        ];
    };
  };

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    lutris
    mangohud
    protonup-qt
    lutris
    bottles
    heroic
    corectrl
    vulkan-tools
    mesa-demos
    hytale
    hytale-launcher-unwrapped
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # WebKit/GTK stack (for launcher UI)
    webkitgtk_4_1
    gtk3
    glib
    gdk-pixbuf
    libsoup_3
    cairo
    pango
    at-spi2-atk
    harfbuzz

    # Graphics - OpenGL/Vulkan/EGL (for game client via SDL3)
    libGL
    libGLU
    libglvnd
    mesa
    vulkan-loader
    egl-wayland

    # X11 (SDL3 dlopens these)
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libXcursor
    xorg.libXi
    xorg.libxcb
    xorg.libXScrnSaver
    xorg.libXinerama
    xorg.libXxf86vm

    # Wayland (SDL3 can use Wayland backend)
    wayland
    libxkbcommon

    # Audio (for game client via bundled OpenAL)
    alsa-lib
    pipewire
    pulseaudio

    # System libraries
    dbus
    fontconfig
    freetype
    glibc
    nspr
    nss
    systemd
    zlib

    # C++ runtime (needed by libNoesis.so, libopenal.so in game client)
    stdenv.cc.cc.lib

    # .NET runtime dependencies (HytaleClient is a .NET application)
    icu
    openssl
    krb5

    # TLS/SSL support for GLib networking (launcher)
    glib-networking
    cacert
  ];
}
