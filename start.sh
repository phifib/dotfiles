#!/bin/bash

cwd=$(pwd)

#############################################
# 依赖检测与安装（.zshrc/.zshenv 所需）
#############################################

# Rust/Cargo（.zshenv 会 source ~/.cargo/env）
if [ ! -f "$HOME/.cargo/env" ]; then
  echo "未检测到 Rust/Cargo，正在安装 rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  [ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
  echo "Rust 安装完成."
else
  echo "已存在 Rust/Cargo，跳过."
fi

# Oh My Zsh（.zshrc 会 source oh-my-zsh.sh）
if [ ! -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
  echo "未检测到 Oh My Zsh，正在安装..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  echo "Oh My Zsh 安装完成."
else
  echo "已存在 Oh My Zsh，跳过."
fi

# Oh My Zsh 自定义插件（.zshrc 的 plugins 里用到了）
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
for repo in zsh-syntax-highlighting zsh-autosuggestions; do
  plugdir="$ZSH_CUSTOM/plugins/$repo"
  if [ ! -d "$plugdir" ]; then
    echo "正在安装 Oh My Zsh 插件: $repo ..."
    git clone "https://github.com/zsh-users/$repo.git" "$plugdir" 2>/dev/null || true
  fi
done

#############################################
# 创建配置符号链接
#############################################

# bash
ln -sf "$cwd/bash/.bashrc" ~/.bashrc

# zsh
ln -sf "$cwd/zsh/.zshrc" ~/.zshrc
ln -sf "$cwd/zsh/.zshenv" ~/.zshenv
ln -sf "$cwd/zsh/.zprofile" ~/.zprofile

# vim
ln -sf "$cwd/vim/.vimrc" ~/.vimrc
ln -sf "$cwd/vim/.vimrc" ~/.ideavimrc

# neovim and coc
mkdir -p "$HOME/.config/nvim"
[ -f "$cwd/nvim/init.vim" ] && ln -sf "$cwd/nvim/init.vim" "$HOME/.config/nvim/init.vim"

# vscode
ln -sf "$cwd/vscode/settings.json" ~/Library/Application\ Support/Code/User/settings.json

# git
ln -sf "$cwd/git/.gitconfig" ~/.gitconfig
ln -sf "$cwd/git/.gitconfig-self" ~/.gitconfig-self
ln -sf "$cwd/git/.gitconfig-work" ~/.gitconfig-work
ln -sf "$cwd/git/.gitignore" ~/.gitignore
ln -sf "$cwd/git/.gitattributes" ~/.gitattributes

#tmux
# ln -sf "$cmd/tmux/.tmux.conf" ~/.tmux.conf
# ln -sf "$cmd/tmux/.tmux.conf.local" ~/.tmux.conf.local


 #git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
 #git clone git://github.com/zsh-users/zsh-completions.git ~/.oh-my-zsh/custom/plugins/zsh-completions
