# AstroNvim Template

**NOTE:** This is for AstroNvim v6+

A template for getting started with [AstroNvim](https://github.com/AstroNvim/AstroNvim)

## 🛠️ Installation

#### Make a backup of your current nvim and shared folder

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

#### Create a new user repository from this template

Press the "Use this template" button above to create a new repository to store your user configuration.

You can also just clone this repository directly if you do not want to track your user configuration in GitHub.

#### Clone the repository

```shell
git clone https://github.com/venjiang/astronvim ~/.config/nvim
```

#### Start Neovim

```shell
nvim
```

## 维护与健康检查

在 Neovim 中执行 `:checkhealth`。单独检查插件管理、解析器和语言服务器：

```vim
:checkhealth lazy nvim-treesitter vim.lsp
:AerialInfo
:TSLog
```

macOS 的解析器、Git 界面和图片渲染依赖：

```shell
brew install tree-sitter-cli lazygit ghostscript tectonic
npm install --global @mermaid-js/mermaid-cli@12.0.0
```

Mermaid CLI 12 需要 Node.js 22.13 或更新版本。图片显示需要支持 Kitty Graphics Protocol 的终端，例如 Ghostty；无界面运行无法验证终端图形协议。

Neovim 0.12.5 的 GitHub 版本查询超时可能触发 `vim.health` 的 `result` 空值异常，见 [上游问题 #37922](https://github.com/neovim/neovim/issues/37922)。启用已有网络代理后再执行 `:checkhealth vim.health` 可避开本机已复现的超时路径；编辑器运行时本身未打补丁。

SQL parser 由 AstroCore 的 `treesitter.ensure_installed` 清单维护，安装到 Neovim 的 `site/parser` 目录。Neovim 0.12 内置语言使用自带 parser，旧的插件生成产物不能覆盖它们。

当前插件没有 LuaRocks 构建依赖，因此关闭 Lazy 的 `rocks` 安装通道；以后添加需要 rockspec 构建的插件时再启用。
