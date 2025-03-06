# 🚬 json-to-types.nvim

A Neovim plugin designed to simplify the process of generating type definitions from JSON. This plugin supports multiple programming languages, making it a versatile tool for developers who want to save time and avoid manually writing type definitions.

## 📋 Requirements

- Neovim >= **0.8.0** (needs to be built with **LuaJIT**)

## Supported Languages

Below is a list of the languages that are currently supported:

- [x] TypeScript
  - [x] TypeScript Zod
  - [x] TypeScript Effect Schema
- [x] JavaScript
  - [x] JavaScript Prop Types
- [x] Python
- [x] C#
- [x] Go
- [x] Rust
- [x] PHP
- [x] Ruby
- [x] Swift
- [x] Kotlin
- [x] C++
- [x] CJSON
- [x] Crystal (cr)
- [x] Dart
- [x] Elixir
- [x] Elm
- [x] Flow
- [x] Haskell
- [x] Java
- [x] Objective-C
- [x] Pike
- [x] Scala3
- [x] Smithy

## 📦 Installation

Install the plugin with your preferred package manager:

[lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
    "Redoxahmii/json-to-types.nvim",
    build = "sh install.sh npm", -- Replace `npm` with your preferred package manager (e.g., yarn, pnpm).
    ft = "json",
    keys = {
      {
        "<leader>cU",
        "<CMD>ConvertJSONtoLang typescript<CR>",
        desc = "Convert JSON to TS",
      },
      {
        "<leader>ct",
        "<CMD>ConvertJSONtoLangBuffer typescript<CR>",
        desc = "Convert JSON to TS Buffer",
      },
    },
  }
```

- Provide your installer in the build command. Instead of `npm`, you can pass whatever you are using such as `yarn`.

## 🚀 Usage

- To create keymaps for the language you want, you can refer to the method provided above or use it directly in command mode as well:

```
:ConvertJSONtoLang typescript
:ConvertJSONtoLang javascript
:ConvertJSONtoLang python
:ConvertJSONtoLang csharp
:ConvertJSONtoLang go
:ConvertJSONtoLang rust
:ConvertJSONtoLang php
:ConvertJSONtoLang ruby
:ConvertJSONtoLang swift
:ConvertJSONtoLang kotlin
:ConvertJSONtoLang cpp
:ConvertJSONtoLang cjson
:ConvertJSONtoLang cr
:ConvertJSONtoLang dart
:ConvertJSONtoLang elixir
:ConvertJSONtoLang elm
:ConvertJSONtoLang flow
:ConvertJSONtoLang haskell
:ConvertJSONtoLang java
:ConvertJSONtoLang javascript-prop-types
:ConvertJSONtoLang objc
:ConvertJSONtoLang pike
:ConvertJSONtoLang scala3
:ConvertJSONtoLang Smithy
:ConvertJSONtoLang typescript-zod
:ConvertJSONtoLang typescript-effect-schema
```

- This will create a new file with the name `types-{filename}.{extension}` in the same directory as the file you are editing with type definitions.
- Similarly, you can use the `ConvertJSONtoLangBuffer` command to create a new buffer with type definitions so you can make your changes immediately.
- Supported languages are listed above for your reference.
- The reason for appending `Types-` before the file name is to avoid overwriting if there is an already existing `.{extension}` file in the same directory with the same name.
- You can also make keybindings for the mentioned commands by referring to the method provided above.

## Using with `kulala.nvim`

You can use this plugin with [kulala.nvim](https://github.com/mistweaverco/kulala.nvim) to get the types automatically when you make a request to an API.

Here's an example of how you can make a keybinding for this:

```lua
      {
        "<leader>Rw",
        function()
          require("kulala.api").on("after_next_request", function(data)
            local filename = "kulala.json"
            local file = io.open(filename, "w")
            if not file then
              print("Error: Failed to open file for writing")
              return
            end
            file:write(data.body)
            file:close()
            vim.cmd("edit " .. filename)
            local buf = vim.api.nvim_get_current_buf()
            vim.cmd("ConvertJSONtoLang typescript")
            vim.api.nvim_buf_delete(buf, { force = true })
            os.remove(filename)
          end)
          require("kulala").run()
        end,
        desc = "Toggle API Callback for JSON to TS Buffer",
      },
```

You can replace `typescript` with the language you want to use and this will acts as a toggle to ensure you can keep using your `kulala.nvim` bindings as you've setup.

After one request, `kulala.nvim` will default to it's own behavior.
