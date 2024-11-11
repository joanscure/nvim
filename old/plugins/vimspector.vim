let g:vimspector_enable_mappings = 'HUMAN'

nmap <leader>dd :call vimspector#Launch()<CR>
nmap <leader>dx :VimspectorReset<CR>
nmap <leader>de :VimspectorEval
nmap <leader>dw :VimspectorWatch
"nmap <leader>do :VimspectorShowOutput

"autocmd FileType java nmap <leader>dd :CocComand java.debug.vimspector.start<CR>

let g:vimspector_install_gadgets = ['vscode-cpptools'] "  'debugpy', 'CodeLLDB'  

let g:vimspector_base_dir=expand( '$HOME/.vim/vimspector-config' )
