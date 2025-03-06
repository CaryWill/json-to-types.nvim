---@class CustomModule
local M = {}

local filetype_map = {
  cjson = { extension = "c", filetype = "c" },
  ["c++"] = { extension = "cpp", filetype = "cpp" },
  cr = { extension = "cr", filetype = "crystal" },
  cs = { extension = "cs", filetype = "cs" },
  dart = { extension = "dart", filetype = "dart" },
  elixir = { extension = "ex", filetype = "elixir" },
  elm = { extension = "elm", filetype = "elm" },
  flow = { extension = "js", filetype = "javascript" },
  go = { extension = "go", filetype = "go" },
  haskell = { extension = "hs", filetype = "haskell" },
  java = { extension = "java", filetype = "java" },
  ["javascript-prop-types"] = { extension = "js", filetype = "javascript" },
  kotlin = { extension = "kt", filetype = "kotlin" },
  objc = { extension = "m", filetype = "objc" },
  php = { extension = "php", filetype = "php" },
  pike = { extension = "pike", filetype = "pike" },
  py = { extension = "py", filetype = "python" },
  rs = { extension = "rs", filetype = "rust" },
  scala3 = { extension = "scala", filetype = "scala" },
  Smithy = { extension = "smithy", filetype = "smithy" },
  swift = { extension = "swift", filetype = "swift" },
  typescript = { extension = "ts", filetype = "typescript" },
  ["typescript-zod"] = { extension = "ts", filetype = "typescript" },
  ["typescript-effect-schema"] = { extension = "ts", filetype = "typescript" },
  javascript = { extension = "js", filetype = "javascript" },
  cpp = { extension = "cpp", filetype = "cpp" },
  csharp = { extension = "cs", filetype = "cs" },
  rust = { extension = "rs", filetype = "rust" },
  python = { extension = "py", filetype = "python" },
  ruby = { extension = "rb", filetype = "ruby" },
}

local function get_file_info(language)
  return filetype_map[language] or { extension = "txt", filetype = "text" }
end

M.execute_node_command = function(file_name, target_language)
  local base_name = vim.fn.fnamemodify(file_name, ":t:r")
  local file_info = get_file_info(target_language)
  local types_output_file = vim.fn.expand("%:h") .. "/" .. "Types-" .. base_name .. "." .. file_info.extension

  -- local types_command = "node "
  --   .. home
  --   .. "/Code/Neovim/json-to-types.nvim/quicktype.js "
  --   .. target_language
  --   .. " "
  --   .. file_name
  --   .. " > "
  --   .. types_output_file
  local types_command = "node --no-warnings "
    .. vim.fn.stdpath("data")
    .. "/plugged/json-to-types.nvim/quicktype.js "
    .. target_language
    .. " "
    .. file_name
    .. " > "
    .. types_output_file
  os.execute(types_command)
  return types_output_file, file_info.filetype
end

M.buffer_to_string = function(filetype)
  if filetype == "json" then
    local content = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
    return table.concat(content, "\n")
  else
    vim.notify("Filetype is not JSON", vim.log.levels.ERROR)
    return
  end
end

M.language_map = {
  "cjson",
  "c++",
  "cr",
  "cs",
  "dart",
  "elixir",
  "elm",
  "flow",
  "go",
  "haskell",
  "java",
  "javascript-prop-types",
  "kotlin",
  "objc",
  "php",
  "pike",
  "py",
  "rs",
  "scala3",
  "Smithy",
  "swift",
  "typescript",
  "typescript-zod",
  "typescript-effect-schema",
  "javascript",
  "cpp",
  "csharp",
  "rust",
  "python",
  "ruby",
}

function format_selected_to_json()
    -- Get the selected text
    local start_pos = vim.fn.getpos("'<")  -- Start position of visual selection
    local end_pos = vim.fn.getpos("'>")    -- End position of visual selection

    -- Get lines from the visual selection
    local lines = vim.fn.getline(start_pos[2], end_pos[2])

    -- Initialize a table to hold the key-value pairs
    local tbl = {}

    -- Process selected lines to extract key-value pairs
    for _, line in ipairs(lines) do
        local key, value = line:match("([^:]+):%s*(.*)")
        if key and value then
            -- Trim whitespace around key and value
            key = key:match("^%s*(.-)%s*$")
            value = value:match("^%s*(.-)%s*$")
            tbl[key] = value
        end
    end

    -- Convert the table to JSON
    local json_text = vim.fn.json_encode(tbl)
  return json_text
end

M.format_selected_to_json = format_selected_to_json

return M
