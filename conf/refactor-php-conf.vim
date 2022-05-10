" Put this function at the very end of your vimrc file.

function! PhpSyntaxOverride()
  " Put snippet overrides in this function.
  hi! link phpDocTags phpDefine
  hi! link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END

syn match phpParentOnly "[()]" contained containedin=phpParent
hi phpParentOnly guifg=#f08080 guibg=NONE gui=NONE
