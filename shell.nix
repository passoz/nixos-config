{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    git
    gh
    curl
    wget
    btop
    jq
    mc
    tilix
    mpd
    mpc
    mpv
    vlc
    ffmpeg
    gimp
    inkscape
    ardour
    obs-studio
    chromium
    firefox
    google-chrome
    brave
    ollama
    telegram-desktop
    stremio-linux-shell
    dbeaver-bin
    postgresql
    mysql84
    transmission_4
    kubectl
    helm
    opentofu
    k3d
    terraform
    jupyter
    vscode
    nodejs
    go
    gcc
    gnumake
    pkgconf
    binutils
    cargo
    rustc
    python3
    mise
  ];

  shellHook = ''
    export ZSH="$HOME/.oh-my-zsh"
    export EDITOR=vim
    export VISUAL=vim
  '';
}
