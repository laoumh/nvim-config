# kickstart.nvim

## Instalação

### Install Neovim

Kickstart.nvim targets *only* the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have the latest versions.

Sugestão: instalar com `snap`:

```
sudo snap install nvim --classic
```

### Install External Dependencies

External Requirements:
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
  - Instalar `build-essential`
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
  - Disponível no repositório Debian
- Clipboard tool (xclip/xsel/win32yank or other depending on platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true
- Language Setup:
  - If you want to write Typescript, you need `npm`
  - If you want to write Golang, you will need `go`
  - etc.

### Install Kickstart

Neovim's configurations are located under the following paths, depending on your OS:

| OS | PATH |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |

#### Recommended Step

You likely want to remove `lazy-lock.json` from your fork's `.gitignore` file
too - it's ignored in the kickstart repo to make maintenance easier, but it's
[recommmended to track it in version control](https://lazy.folke.io/usage/lockfile).

#### Clone kickstart.nvim

```sh
git clone git@github.com:laoumh/kickstart.nvim.git "${$HOME/.config}"/nvim
```

### Post Installation

Start Neovim

```sh
nvim
```

That's it! Lazy will install all the plugins you have. Use `:Lazy` to view
current plugin status. Hit `q` to close the window.

Read through the `init.lua` file in your configuration folder for more
information about extending and exploring Neovim. That also includes
examples of adding popularly requested plugins.


### Getting Started

[The Only Video You Need to Get Started with Neovim](https://youtu.be/m8C0Cq9Uv9o)

## Uso remoto

Ao invés de instalar novamente no servidor, possível montar o diretório remoto localmente com `sshfs`:

```sh
# Instala 
sudo apt install sshfs

# Monta diretório remoto
sshfs [usuario@]<servidor_removo>:</diretorio/projeto/alvo> <~/mnt/diretorio/projeto/local>

# Desmonta diretória remoto
fusermount -u <~/mnt/diretorio/projeto/local>
```

### `sshfs` com `snap`

Devido ao funcionamento *sandboxing* dos pacotes `snap`, necessário configuração para acesso do diretório montado (também vale para VSCode, por exemplo):

1 - Habilitar `user_allow_other` em `/etc/fuse.conf`:

```sh
sudoedit /etc/fuse.conf

# Descomentar user_allow_other
```

2 - Montar diretório com opção `allow_root`:

```sh
sshfs -o allow_root [usuario@]<servidor_removo>:</diretorio/projeto/alvo> <~/mnt/diretorio/projeto/local>
```

Ver *issue* [Unable to open visual studio code when inside sshfs mounted drive UBUNTU WSL](https://askubuntu.com/a/1385497).
