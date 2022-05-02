let g:airline_powerline_fonts = 1
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
"let NERDTreeShowLineNumbers=1
let g:NERDTreeGitStatusWithFlags = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:NERDTreeGitStatusNodeColorization = 1
let g:NERDTreeColorMapCustom = {
      \ "Staged"    : "#0ee375",  
      \ "Modified"  : "#d9bf91",  
      \ "Renamed"   : "#51C9FC",  
      \ "Untracked" : "#FCE77C",  
      \ "Unmerged"  : "#FC51E6",  
      \ "Dirty"     : "#FFBD61",  
      \ "Clean"     : "#87939A",   
      \ "Ignored"   : "#808080"   
      \ }                         
let g:NERDTreeIgnore = ['^node_modules$', 'vendor']
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
