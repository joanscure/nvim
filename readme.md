# Neovim Configuration

![Logo](img/logo.png)

## Dependencies:

[Vim-Plug]:(https://github.com/junegunn/vim-plug)

```bash
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
```

[Fzf]:(https://github.com/junegunn/fzf.vim)

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

[Ag]:(https://github.com/ggreer/the_silver_searcher)

```bash
choco install ag
```

[Ripgrep]:(https://github.com/BurntSushi/ripgrep)

```bash
choco install ripgrep
```

Install Typescript, Eslint and Prettier

```bash
npm install -g typescript typescript-language-server eslint prettier
```

## Install Plugins

use in vim

```bash
:PlugInstall
```

## EXTRA

If you use Windows Terminal in its settings.json it have ‘Actions’ key, you should changes to ‘Actions’ which is in the file `./conf/actions.json` , to avoid problems with the hootkey that’s defined 

![Example](img/doc-actions-json.png)
