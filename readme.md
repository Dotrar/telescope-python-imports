# Telescope: Py Imports

This extension will look in your codebase for import statements, and allow you to put them in the codebase easily.

## Screenshot:
![image](https://github.com/Dotrar/telescope-python-imports/assets/1199335/26f240f4-cd05-40d1-9831-778717a42151)


## How to use

Import normally, ie for vim-plug:

```
Plug 'dotrar/telescope-python-imports'
```
and load extension to your telescope setup (Note: different name!):
```lua
telescope.load_extension("py_imports")
```

Then bind to a key:

I prefer to use ctrl-y while in insert mode.  Note that after text has been inserted, you will return to insert mode

```
inoremap <c-y> <cmd>:lua require("telescope").extensions.py_imports.search()<CR>
```
