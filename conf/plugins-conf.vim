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

" THEME TOKYONIGHT
let g:tokyonight_style='night' " available: night, storm
let g:tokyonight_current_word='bold'
let g:tokyonight_enable_italic = 1
colorscheme tokyonight
highlight Normal ctermbg=NONE

