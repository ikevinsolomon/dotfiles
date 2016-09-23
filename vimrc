" ---------------------------------------------
" Init vimrc
" ---------------------------------------------
    set nocompatible                           " be iMproved, required
    filetype on                                " required
    filetype plugin on                         " required
    syntax enable                              " required
    set backspace=indent,eol,start             " Make backspace behave like every other editor.
    let mapleader = ','                        " The default is \, but a comma is much better.
    set number                                 " Let's activate line numbers.
    set noerrorbells visualbell t_vb=          " No damn bells!
    set autowriteall                           " Automatically write the file when switching buffers.
    set complete=.,w,b,u                       " Set our desired autocompletion matching.
    set tabstop=8
    set expandtab
    set softtabstop=4
    set shiftwidth=4
    set mouse=a
    set paste


" ---------------------------------------------
" Vundle plugin manager
" ---------------------------------------------
" set the runtime path to include Vundle and initialize

    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    " Set path for my vim plugins
    " let Vundle manage Vundle and set the required dependencies
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'MarcWeber/vim-addon-mw-utils'
    Plugin 'tomtom/tlib_vim'

    " Setup bundle groups
    if !exists('g:vim_bundle_groups')
        let g:vim_bundle_groups = ['plugins',]
    endif

    if count(g:vim_bundle_groups, 'plugins')
        
        Plugin 'tpope/vim-vinegar'
        Plugin 'scrooloose/nerdtree'
        Plugin 'scrooloose/nerdcommenter'
        Plugin 'ctrlpvim/ctrlp.vim'
        Plugin 'rking/ag.vim'
        Plugin 'skwp/greplace.vim'
        Plugin 'garbas/vim-snipmate'
        Plugin 'tpope/vim-surround'
        Plugin 'StanAngeloff/php.vim'
        Plugin 'arnaud-lb/vim-php-namespace'
        Plugin 'ervandew/supertab'
        Plugin 'stephpy/vim-php-cs-fixer'
        Plugin 'tobyS/vmustache'
        Plugin 'tobyS/pdv'
        Plugin 'SirVer/ultisnips'
        Plugin 'spf13/vim-autoclose'
        Plugin 'mbbill/undotree'
        Plugin 'tpope/vim-fugitive'

        if executable('ctags')
            Plugin 'majutsushi/tagbar'
        endif

        Plugin 'bling/vim-airline'
        Plugin 'vim-airline/vim-airline-themes'
        Plugin 'flazz/vim-colorschemes'
        Plugin 'terryma/vim-multiple-cursors'
        Plugin 'pangloss/vim-javascript'

    endif
    call vundle#end()

" ---------------------------------------------
" Vim UI
" ---------------------------------------------
    
    colorscheme atom-dark
    set t_CO=256                                " Use 256 colors. This is useful for Terminal Vim.
    set guifont=Fira\ Code:h17                  " Set the default font family and size.
    set guioptions-=e                           " We don't want Gui tabs.
    set linespace=16                            " Macvim-specific line-height.
    set lines=999

    set guioptions-=l                           " Disable Gui scrollbars.
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R


" ---------------------------------------------
" Remaps
" ---------------------------------------------

    " Make it easy to edit the Vimrc file.
    nmap <Leader>ev :tabedit $MYVIMRC<cr>
    nmap <Leader>es :e ~/.vim/snippets/

    " Add simple highlight removal.
    nmap <Leader><space> :nohlsearch<cr>

    " Quickly browse to any tag/symbol in the project.
    " Tip: run ctags -R to regenerated the index.
    nmap <Leader>f :tag<space>

    " Sort PHP use statements
    " http://stackoverflow.com/questions/11531073/how-do-you-sort-a-range-of-lines-by-length
    vmap <Leader>su ! awk '{ print length(), $0 \| "sort -n \| cut -d\\  -f2-" }'<cr>


    " Super tabs ! Fuck yeah!
    map <S-H> gT
    map <S-L> gt

    " Find merge conflict markers
    map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

    " Shift keys :/
    command! -bang -nargs=* -complete=file E e<bang> <args>
    command! -bang -nargs=* -complete=file W w<bang> <args>
    command! -bang -nargs=* -complete=file Wq wq<bang> <args>
    command! -bang -nargs=* -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>

    " visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " White space clean up
    autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call StripTrailingWhitespace()

    " Fast saves
    nmap <leader>w :w!<cr>

    "sane searches
    noremap / /\v
    vnoremap / /\v

    " Down is really the next line
    nnoremap j gj
    nnoremap k gk

    "Easy escaping to normal model
    imap jj <esc>

    "Auto change directory to match current file ,cd
    nnoremap ,cd :cd %:p:h<CR>:pwd<CR>


    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

    " Keep search matches in the middle of the window.
    nnoremap n nzzzv
    nnoremap N Nzzzv

    " Same when jumping around
    nnoremap g; g;zz
    nnoremap g, g,zz
    nnoremap <c-o> <c-o>zz

    " Allow using the repeat operator with a visual selection (!)
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>


    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Some helpers to edit mode
    " http://vimcasts.org/e/14
    cnoremap %% <C-R>=expand('%:h').'/'<cr>
    map <leader>ew :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%

    
    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Map <Leader>ff to display all lines with keyword under cursor
    " and ask which one to jump to
    nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>


    " Repaint the screen
    nnoremap U :syntax sync fromstart<cr>:redraw!<cr>

    " Map g* keys in Normal, Operator-pending, and Visual+select
    noremap $ :call WrapRelativeMotion("$")<CR>
    noremap <End> :call WrapRelativeMotion("$")<CR>
    noremap 0 :call WrapRelativeMotion("0")<CR>
    noremap <Home> :call WrapRelativeMotion("0")<CR>
    noremap ^ :call WrapRelativeMotion("^")<CR>
    " Overwrite the operator pending $/<End> mappings from above
    " to force inclusive motion with :execute normal!
    onoremap $ v:call WrapRelativeMotion("$")<CR>
    onoremap <End> v:call WrapRelativeMotion("$")<CR>
    " Overwrite the Visual+select mode mappings from above
    " to ensure the correct vis_sel flag is passed to function
    vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
    vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
    vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
    vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
    vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>
    
    set splitbelow                                 " Make splits default to below...
    set splitright                                 " And to the right. This feels more natural. 

   "Easy Window toggle
    map <C-J> <C-W>j<C-W>_
    map <C-K> <C-W>k<C-W>_
    map <C-L> <C-W>l<C-W>_
    map <C-H> <C-W>h<C-W>_ 

    " Automatically source the Vimrc file on save.
    augroup autosourcing
        autocmd!
        autocmd BufWritePost .vimrc source %
    augroup END

    " Laravel-Specific"
    nmap <Leader>lr :e app/Http/routes.php<cr>
    nmap <Leader>lm :!php artisan make:
    nmap <Leader><Leader>c :e app/Http/Controllers/<cr>
    nmap <Leader><Leader>m :CtrlP<cr>app/
    nmap <Leader><Leader>v :e resources/views/<cr>

" ---------------------------------------------
" Plugin settings
" ---------------------------------------------

    
    " ---------------------------------------------
    " CtrlP settings
    " ---------------------------------------------
    " CtrlP {
    if isdirectory(expand("~/.vim/bundle/ctrlp/"))
        let g:ctrlp_custom_ignore = 'node_modules\DS_Store\|git'
        let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30,results:30'

        nmap <D-p> :CtrlP<cr>
        nmap <D-r> :CtrlPBufTag<cr>
        nmap <D-e> :CtrlPMRUFiles<cr>

    endif
    "}


    " ---------------------------------------------
    " Greplace settings
    " ---------------------------------------------
    " Greplace {
    if isdirectory(expand("~/.vim/bundle/greplace/"))
        set grepprg=ag                              "We want to use Ag for the search.
        let g:grep_cmd_opts = '--line-numbers --noheading'
    endif
    "}


    " ---------------------------------------------
    " vim-php-cs-fixer settings
    " ---------------------------------------------
    " vim-php-cs-fixer {
    if isdirectory(expand("~/.vim/bundle/vim-php-cs-fixer/"))
        let g:php_cs_fixer_level = "psr2"  
        nnoremap <silent><leader>pf :call PhpCsFixerFixFile()<CR>
    endif
    "}


    " ---------------------------------------------
    " pdv settings
    " ---------------------------------------------
    " pdv {
    if isdirectory(expand("~/.vim/bundle/pdv/"))
        let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
        nnoremap <leader>d :call pdv#DocumentWithSnip()<CR>
    endif
    "}


    " ---------------------------------------------
    " Ultisnips settings
    " ---------------------------------------------
    " ultisnips {
    if isdirectory(expand("~/.vim/bundle/ultisnips/"))
        let g:UltiSnipsExpandTrigger="<tab>"
        let g:UltiSnipsJumpForwardTrigger="<tab>"
        let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
    endif
    "}


    " ---------------------------------------------
    " NerdTree settings
    " ---------------------------------------------
    " CtrlP {
    if isdirectory(expand("~/.vim/bundle/nerdtree/"))
        let NERDTreeHijackNetrw = 0
        nmap <D-1> :NERDTreeToggle<cr>
    endif
    "}

    " ---------------------------------------------
    " TagBar settings
    " ---------------------------------------------
    " TagBar {
    if isdirectory(expand("~/.vim/bundle/tagbar/"))
        nnoremap <silent> <leader>tt :TagbarToggle<CR>

        " If using go please install the gotags program using the following
        " go install github.com/jstemmer/gotags
        " And make sure gotags is in your path
        let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds'     : [  'p:package', 'i:imports:1', 'c:constants', 'v:variables',
        \ 't:types',  'n:interfaces', 'w:fields', 'e:embedded', 'm:methods',
        \ 'r:constructor', 'f:functions' ],
        \ 'sro' : '.',
        \ 'kind2scope' : { 't' : 'ctype', 'n' : 'ntype' },
        \ 'scope2kind' : { 'ctype' : 't', 'ntype' : 'n' },
        \ 'ctagsbin'  : 'gotags',
        \ 'ctagsargs' : '-sort -silent'
        \ }
    endif
    "}

    " ---------------------------------------------
    " Fugitive settings
    " ---------------------------------------------
    " Fugitive {
    if isdirectory(expand("~/.vim/bundle/vim-fugitive/"))
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
        nnoremap <silent> <leader>gr :Gread<CR>
        nnoremap <silent> <leader>gw :Gwrite<CR>
        nnoremap <silent> <leader>ge :Gedit<CR>
        " Mnemonic _i_nteractive
        nnoremap <silent> <leader>gi :Git add -p %<CR>
        nnoremap <silent> <leader>gg :SignifyToggle<CR>
    endif
    " }

    " ---------------------------------------------
    " indent_guides settings
    " ---------------------------------------------
    "indent_guides {
    if isdirectory(expand("~/.vim/bundle/vim-indent-guides/"))
        let g:indent_guides_start_level = 2
        let g:indent_guides_guide_size = 1
        let g:indent_guides_enable_on_vim_startup = 0
    endif
    " }

    " ---------------------------------------------
    " airline settings
    " ---------------------------------------------
    " airline {
    if isdirectory(expand("~/.vim/bundle/vim-airline/"))

        " Enable Airline always
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=%{fugitive#statusline()} " Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info

        if !exists('g:airline_theme')
            let g:airline_powerline_fonts = 1
            let g:airline_theme = 'solarized'
        endif

        if !exists('g:airline_powerline_fonts')
            " Use the default set of separators with a few customizations
            let g:airline_left_sep='›'  " Slightly fancier than '>'
            let g:airline_right_sep='‹' " Slightly fancier than '<'
        endif
    endif
    " }


    " ---------------------------------------------
    " PHPQA settings
    " ---------------------------------------------
    " PHPQA {
        " Don't run messdetector on save (default = 1)
        let g:phpqa_messdetector_autorun = 0

        " Don't run codesniffer on save (default = 1)
        let g:phpqa_codesniffer_autorun = 0

        " Show code coverage on load (default = 0)
        let g:phpqa_codecoverage_autorun = 1"

    " }


" ---------------------------------------------
" Utility function settings
" ---------------------------------------------

" strip whitespace {
function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
" }

" WrapRelativeMotion {
function! WrapRelativeMotion(key, ...)
    let vis_sel=""
    if a:0
    let vis_sel="gv"
    endif
    if &wrap
    execute "normal!" vis_sel . "g" . a:key
    else
    execute "normal!" vis_sel . a:key
    endif
endfunction
" }

" Javascript folding {
function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
    return substitute(getline(v:foldstart), '{.*', '{...}', '''}')
    endfunction
    setl foldtext=FoldText()
endfunction
" }

au FileType javascript call JavaScriptFold()
au FileType javascript setl fen

" Renaming files {
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
    endif
endfunction
" }
map <leader>rn :call RenameFile()<cr>

" Toggle Folding {
function! ToggleFolding()
    let curr_fold=&foldmethod
    let en='off'

    if curr_fold == 'syntax'
        :setlocal foldmethod=manual
        else
        let en='on'
        :setlocal foldmethod=syntax
    endif

    echo "Toggled folding ".en
endfunction
" }
map <Leader>tf :call ToggleFolding()<CR>

" Insert USE namespace {
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>n <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>n :call PhpInsertUse()<CR>
" }


" Expand Class {
function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction
autocmd FileType php inoremap <Leader>nf <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>nf :call PhpExpandClass()<CR>
" }

