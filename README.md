#nvim-config

Configuração baseada em [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).

## Instalação

Sugestão: instalar com `snap` para atualização automática:

```sh
sudo snap install nvim --classic
```

### Dependências

- Utilitários: `git`, `make`, `unzip`, compilador C (`gcc`)
  - Instalar `build-essential`
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
  - Disponível no repositório Debian como `ripgrep`
- [fd](https://github.com/sharkdp/fd)
  - Disponível no repositório Debian como `fd-find`
- Clipboard tool (`xclip`/`wl-clipboard`)
- [Nerd Font](https://www.nerdfonts.com/)
  - Se instalado, configurar `vim.g.have_nerd_font`
  em `settings/settings.lua` para `true`

### Clonar repositório

Clonar o arquivo de configuração em `~/.config/nvim`:

```sh
git clone git@github.com:laoumh/nvim-config.git "${$HOME/.config}"/nvim
```

### Pós-instalação

Usar `:Lazy` para administrar plugins.

Usar `:Mason` para administrar dependências (debugger, linter, lsp etc).

## Uso remoto

Ao invés de instalar novamente no servidor,
possível montar o diretório remoto localmente com `sshfs`:

```sh
# Instala 
sudo apt install sshfs

# Monta diretório remoto
sshfs [usuario@]<servidor_removo>:</diretorio/projeto/alvo> <~/mnt/diretorio/projeto/local>

# Desmonta diretória remoto
fusermount -u <~/mnt/diretorio/projeto/local>
```

### `sshfs` com `snap`

Devido ao funcionamento *sandboxing* dos pacotes `snap`,
necessário configuração para acesso do diretório montado
(também vale para VSCode, por exemplo):

1 - Habilitar `user_allow_other` em `/etc/fuse.conf`:

```sh
sudoedit /etc/fuse.conf

# Descomentar user_allow_other
```

2 - Montar diretório com opção `allow_root`:

```sh
sshfs -o allow_root [usuario@]<servidor_removo>:</diretorio/projeto/alvo> <~/mnt/diretorio/projeto/local>
```

Ver *issue* [Unable to open visual studio code
when inside sshfs mounted drive UBUNTU WSL](https://askubuntu.com/a/1385497).

## TODO

- Debugger
 - [ ] Desabilitar diagnósticos por padrão?
 - [ ] Inicializar debugger com painéis abertos ou fechados?
- Plugins
 - [ ] Definir versões para plugins que mantém tags
 - [ ] Possível salvar histórico de navegação na sessão (ctrl+i / ctrl+o)?

