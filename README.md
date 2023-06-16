# Introduction
My setup on a linux machine or something with a bash terminal.

Copy the files into the home directory of the terminal. Or append them to
existing files.

# Setting up plugins for Vim

Get a plugin manager for Vim. I used [Vim Plug](https://github.com/junegunn/vim-plug).
Follow their install instructions. From there, the configuration found in this
repo's `.vimrc` will load the plugins.

Afterwards, run `:PlugInstall` in vim.

# Setting up tags for Vim

## Exuberant Ctags

This is probably the most common tagging solution for Vim. You can install it
through apt

```bash
sudo apt install exuberant-ctags
```

It will install a ctags command which many others use (for example, `etags`).
Make sure you don't have competing ctags commands.

Run it recursively on your project: `ctags -R .`.

You could get a Vim plugin, such as [Vim-Tags](https://github.com/szw/vim-tags).

## RTags

Use the RTags repo to index. They seem to have an apt repo for it, but it will
install emacs with it. I personally am not ready to make that leap.
Alternatively, you can

```bash
git clone --recursive https://github.com/Andersbakken/rtags.git
cd rtags
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .
make
sudo make install
```

Start the RTags daemon: `rdm&`. You could probably add that to your `.bashrc`

Index your projects (from the project directory): `rc -J .`

Run cmake on the project. Make sure the `CMAKE_EXPORT_COMPILE_COMMANDS=true`
flag is used. You could add this alias to `.bashrc` so that you don't forget:

```bash
alias cmake="cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=true"
```