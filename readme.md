# Telescope: Py Imports

This extension will look in your codebase for import statements, and allow you to put them in the codebase easily.

## Screenshot:
![image](https://github.com/Dotrar/telescope-python-imports/assets/1199335/26f240f4-cd05-40d1-9831-778717a42151)


## How to use

Import normally, ie for vim-plug:

```
Plug 'dotrar/telescope-python-imports'
```
and load extension to your telescope setup 
```lua
telescope.load_extension("python-imports")
```

Then bind to a key:

I prefer to use ctrl-y while in insert mode, and "<leader>fi" for normal mode.

Note if called while in insert mode, it will keep you in insert mode

```lua
local python_imports = require('telescope').extensions['python-imports']

-- example keymaps
vim.keymap.set('i', '<c-y>', python_imports.search)
vim.keymap.set('n', 'gy', python_imports.search,)

```
