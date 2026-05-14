# NixOS Config

Configuração NixOS multi-host com GNOME principal em Wayland, Cinnamon/X11 disponível e trilha de compatibilidade para kernel 6.1 + hardware FL2000 em X11.

## Arquitetura

```
nixos-config/
├── flake.nix              # Flake (NixOS + Home Manager)
├── shell.nix              # DevShell: nix develop
├── pkgs/                  # Packages locais vendorizados no repo
├── modules/
│   ├── system/base.nix    # Configurações compartilhadas do sistema
│   └── home/base.nix      # Configurações compartilhadas do usuário
└── hosts/
    ├── nixos/             # Máquina com hardware FL2000 (hostname: nixos)
    │   ├── default.nix
    │   └── hardware-configuration.nix
    └── wayland/           # Máquina sem hardware legado (hostname: wayland)
        ├── default.nix
        └── hardware-configuration.nix
```

## Máquinas disponíveis

- `.#nixos` — máquina com hardware FL2000, GDM + GNOME em X11, kernel 6.1 disponível via specialisation
- `.#wayland` — máquina sem hardware legado, GDM + GNOME em Wayland

## O que está incluído

- **Zsh:** oh-my-zsh, tema fishy, plugins (zsh-autosuggestions, zsh-syntax-highlighting, docker, docker-compose, kubectl)
- **Mise:** substitui asdf (node, go, rust, python, java)
- **SSH:** configuração GitHub pronta para usar chaves provisionadas fora do repo
- **Desktop:** GNOME + GDM por padrão, Cinnamon disponível via specialisation LightDM
- **Boot:** Plymouth splash (bgrt) + menu GRUB com entrada de compatibilidade Linux 6.1
- **Packages:** vscode, mpv, kubectl, helm, mise, btop, ollama, gh, dbeaver-bin e CLIs de IA/dev

## Instalação

```bash
# Clone e execute (uma linha)
git clone https://github.com/passoz/nixos-config.git "$HOME/dev/nixos-config"
cd "$HOME/dev/nixos-config"
sudo nixos-rebuild switch --flake .#nixos   # ou .#wayland
```

## Entradas de boot

- **Padrão (nixos):** kernel atual + GDM + GNOME em X11
- **Padrão (wayland):** kernel atual + GDM + GNOME em Wayland
- **Specialisation `linux-6_1-compat`:** disponível apenas em `.#nixos`: kernel 6.1 com módulos locais `fl2000`/`it66121` e GDM em X11
- **Specialisation `lightdm-cinnamon`:** ambas as máquinas: LightDM com greeter GTK temado (Adwaita-dark) e Cinnamon

## Personalizar

- `modules/system/base.nix` — serviços, boot, fontes, usuário
- `modules/home/base.nix` — packages do usuário, shell, git, mise
- `hosts/<nome>/default.nix` — configurações específicas da máquina (hostname, hardware, kernel)
- `hosts/<nome>/hardware-configuration.nix` — filesystem da máquina

## SSH e segredos

As chaves SSH não são gerenciadas por este repo. Cada máquina deve ter sua própria chave em `~/.ssh/id_ed25519`.

## Tooling extra fora do nixpkgs

Os seguintes são instalados via `home.activation` (npm install -g) como best-effort:
- `@gitlawb/openclaude`
- `oh-my-opencode`
- `@anthropic-ai/claude-code`

### Items que precisam instalação manual

- **Antigravity** — não está no nixpkgs; instale separadamente
- **Codex CLI** — instale manualmente
- **Gemini CLI** — instale manualmente
- **Warp Terminal** — instale manualmente
- **Dropbox** — instale manualmente
- **JetBrains EAP** — use JetBrains Toolbox
