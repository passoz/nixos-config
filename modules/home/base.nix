{ config, pkgs, lib, username, homeDirectory, ... }:

{
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    btop jq mc tilix mpd mpc mpv vlc ffmpeg
    gimp inkscape ardour obs-studio transmission_4
    chromium firefox google-chrome brave ollama
    telegram-desktop stremio-linux-shell dbeaver-bin
    postgresql mysql84 sqlite kubectl helm opentofu k3d
    zellij qjackctl jupyter vscode nodejs go gcc gnumake
    pkgconf binutils cargo rustc mise
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "Fernando Passos";
      user.email = "fernandopassoz@gmail.com";
    };
  };

  programs.gh.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "fishy";
      plugins = [
        "git" "docker" "docker-compose" "kubectl" "sudo"
        "z" "pip" "python" "node" "npm" "golang" "rust"
        "common-aliases" "jsontools" "urltools" "extract"
        "command-not-found"
      ];
    };
  };

  programs.mise = {
    enable = true;
    globalConfig.tools = {
      elvish = "latest";
      node = "22.8.0";
      go = "latest";
      rust = "latest";
      python = "3.11";
      java = "openjdk-23.0.1";
      quarkus = "latest";
      vite = "latest";
      nest = "latest";
      uv = "latest";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."github.com" = {
      hostname = "github.com";
      user = "git";
      identityFile = "~/.ssh/id_ed25519";
    };
  };

  home.sessionVariables = {
    EDITOR = "vim";
    VISUAL = "vim";
    XDG_CONFIG_HOME = "$HOME/.config";
  };

  home.sessionPath = [ "$HOME/.local/bin" ];

  home.activation.installDevTools = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export PATH="$HOME/.local/bin:$PATH"
    export NPM_CONFIG_PREFIX="$HOME/.local"

    ${pkgs.coreutils}/bin/mkdir -p "$HOME/.local/bin" "$HOME/.local/lib"

    if ! command -v air &> /dev/null; then
      ${pkgs.go}/bin/go install github.com/air-verse/air@latest
      ${pkgs.go}/bin/go install github.com/go-delve/delve/cmd/dlv@latest
      ${pkgs.go}/bin/go install golang.org/x/tools/gopls@latest
      ${pkgs.go}/bin/go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
      ${pkgs.go}/bin/go install github.com/a-h/templ/cmd/templ@latest
      ${pkgs.go}/bin/go install github.com/melkeydev/go-blueprint@latest
      ${pkgs.go}/bin/go install -tags "postgres,sqlite,mysql" github.com/golang-migrate/migrate/v4/cmd/migrate@latest
      ${pkgs.go}/bin/go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest
    fi
    if ! command -v vite &> /dev/null; then
      ${pkgs.nodejs}/bin/npm install -g vite || true
    fi
    if ! command -v nest &> /dev/null; then
      ${pkgs.nodejs}/bin/npm install -g @nestjs/cli || true
    fi
    if ! command -v openclaude &> /dev/null; then
      ${pkgs.nodejs}/bin/npm install -g @gitlawb/openclaude || true
    fi
    if ! command -v oh-my-opencode &> /dev/null; then
      ${pkgs.nodejs}/bin/npm install -g oh-my-opencode || true
    fi
    if ! command -v claude &> /dev/null; then
      ${pkgs.nodejs}/bin/npm install -g @anthropic-ai/claude-code || true
    fi
  '';
}
