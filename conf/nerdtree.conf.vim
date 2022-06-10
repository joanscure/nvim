Plug 'scrooloose/nerdtree'

"nmap <leader>nd :NERDTreeToggle<CR>
"nmap <c-f> :NERDTreeFind<CR>
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
let g:NERDTreeIgnore = ['^node_modules$', 'vendor', '.git']
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
