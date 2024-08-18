vim.g.vimtex_enabled = 1

vim.g.vimtex_view_method = "general"
vim.g.vimtex_view_general_viewer = "evince"


vim.g.vimtex_format_enabled = 1
vim.g.vimtex_format_indent_automatic = 1
vim.g.vimtex_format_indent_comments = 1

vim.g.vimtex_indent_enabled = 1
vim.g.vimtex_indent_script = 'latexindent'



vim.g.vimtex_view_use_temp_files = 1
vim.g.vimtex_compiler_latexmk = {
    out_dir = "build",
    --options = {"-pdf", "-interaction=nonstopmode", "-synctex=1"}
}


-- Function to move PDF files
local function move_pdfs()
  local build_dir = "build"
  local output_dir = "output"

  -- Check if the build directory exists
  local build_exists = vim.fn.isdirectory(build_dir) == 1
  if not build_exists then
    print("Build directory does not exist: " .. build_dir)
    return
  end

  -- Create the output directory if it doesn't exist
  vim.fn.mkdir(output_dir, "p")

  -- Move all .pdf files from build to output
  local pdf_files = vim.fn.glob(build_dir .. "/*.pdf", false, true)
  for _, pdf_file in ipairs(pdf_files) do
    local output_file = output_dir .. "/" .. vim.fn.fnamemodify(pdf_file, ":t")
    os.rename(pdf_file, output_file)
  end

  -- Confirm the action
  print("All .pdf files moved from " .. build_dir .. " to " .. output_dir)
end

-- Create a Vim command to call the move_pdfs function
vim.api.nvim_create_user_command('MovePdfs', move_pdfs, {})

-- Key mapping to run the move_pdfs function
vim.api.nvim_set_keymap('n', '<leader>mp', '<cmd>MovePdfs<CR>', { noremap = true, silent = true })
