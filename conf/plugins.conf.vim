" PYTHON PATH
let g:python3_host_prog='C:\Users\joans\AppData\Local\Programs\Python\Python310\python.exe'

" Yggdroot/indentLine
let g:indentLine_enabled = 1
let g:indentLine_char = '¦'
let g:indentLine_faster = 1
let g:indentLine_fileTypeExclude=["nerdtree"]


"alvan/vim-closetag
let g:closetag_filenames = '*.html,*blade.php,*.phtml, *.jsx'

" Create default mappings
let g:NERDCreateDefaultMappings = 0

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1
autocmd FileType scss setl iskeyword+=@-@

" EMMET 
let g:user_emmet_settings = {
  \  'php' : {
  \    'extends' : 'html',
  \    'filters' : 'c',
  \  },
  \  'xml' : {
  \    'extends' : 'html',
  \  },
  \  'haml' : {
  \    'extends' : 'html',
  \  },
  \ }


" THEME TOKYONIGHT
let g:tokyonight_style='night' " available: night, storm
"let g:tokyonight_current_word='bold'
"let g:tokyonight_enable_italic = 1
"let g:gruvbox_contrast_dark='hard'
"let g:gruvbox_contrast_light='hard'
"let g:gruvbox_color_column='bg0'
"let g:gruvbox_sign_column='bg0'
"colorscheme gruvbox
"let g:github_function_style = "italic"
let g:github_sidebars = ["qf", "vista_kind", "terminal", "packer"]

"" Change the "hint" color to the "orange" color, and make the "error" color bright red
let g:github_colors = {
  \ 'hint': 'orange',
  \ 'error': '#ff0000'
\ }

"" Load the colorscheme
"colorscheme github_dark_default
highlight Normal ctermbg=NONE
lua << EOF
require("github-theme").setup({
	theme_style = "dark_default",
	comment_style = "italic",
	keyword_style = "italic",
	function_style = "italic",
	variable_style = "NONE",
	dark_sidebar = true,
	colors = {hint = "orange", error = "#ff0000"},
	sidebars = {"qf", "vista_kind", "terminal", "packer"},
})
EOF
