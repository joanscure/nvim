" PYTHON PATH
let g:python3_host_prog='C:\python310\python.exe'

" Yggdroot/indentLine
let g:indentLine_enabled = 1
let g:indentLine_char = '¦'
let g:indentLine_faster = 1
let g:indentLine_fileTypeExclude=["nerdtree"]


"alvan/vim-closetag
let g:closetag_filenames = '*.html,*blade.php,*.phtml, *.jsx'

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
"let g:tokyonight_style='night' " available: night, storm
"let g:tokyonight_current_word='bold'
"let g:tokyonight_enable_italic = 1
"let g:gruvbox_contrast_dark='hard'
"let g:gruvbox_contrast_light='hard'
"let g:gruvbox_color_column='bg0'
"let g:gruvbox_sign_column='bg0'
colorscheme gruvbox
"let g:github_function_style = "italic"
let g:github_sidebars = ["qf", "vista_kind", "terminal", "packer"]

"" Change the "hint" color to the "orange" color, and make the "error" color bright red
let g:github_colors = {
  \ 'hint': 'orange',
  \ 'error': '#ff0000'
\ }

"" Load the colorscheme
colorscheme github_dark_default
highlight Normal ctermbg=NONE
