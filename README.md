# ripgrep.nvim
> Look for stuff in your code, easily.

ripgrep.nvim allows you to use ripgrep from within Neovim to search for a string in your project and display the results in the quickfix list so you can jump between matches.

## Installation

[lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
    "walker84837/ripgrep.nvim",
    config = function()
        require("ripgrep").setup()
    end,
}
```

## Usage

The plugin provides two user commands:

* `:Rg <query>`: Search for the given query using ripgrep, following symlinks.
* `:RgIgnore <query>`: Search for the given query using ripgrep, ignoring symlinks.

Replace `<query>` with the actual search query.

## How it works

When you run one of the user commands, the plugin executes the corresponding ripgrep command and loads the results into the quickfix list. The quickfix list is then opened, displaying the search results.

## Notes

* The plugin assumes you already have `ripgrep` installed on your system. If you don't have ripgrep installed, the plugin will not work.
* ripgrep.nvim is a result of me experimenting with Neovim plugins to move a part of my init.lua to a separate plugin, so expect anything to break at any time.
