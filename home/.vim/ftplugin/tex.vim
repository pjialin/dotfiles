source ~/.vim/ftplugin/plaintex.vim

" Add \item automatically
" set formatoptions=tcroqln
" set comments+=b:\\item

set spell
set spelllang=en,pt

nnoremap <localleader>doc /begin{document}<cr>v/end{document}<cr>

" \ldots
if has("gui_running")
    inoremap <m-;> \ldots
else
    inoremap ; \ldots
endif
iabbrev ... <bs>\ldots
inoremap ... \ldots

nnoremap <leader>em viw<esc>a}<esc>bi\emph{<esc>
vnoremap <leader>em <esc>`>a}<esc>`<i\emph{<esc>%

function! InstallPackages()
    let winview = winsaveview()
    call inputsave()
    let cmd = ['sudo -S tlmgr install']
    %call add(cmd, matchstr(getline('.'), '\\usepackage\(\[.*\]\)\?{\zs.*\ze\}'))
    echomsg join(cmd)
    let pass = inputsecret('Enter sudo password:') . "\n"
    echo system(join(cmd), pass)
    call inputrestore()
    call winrestview(winview)
endfunction

command! InstallPackages call InstallPackages()

