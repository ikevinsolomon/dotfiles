"-------------VIM init--------------"
set nocompatible              						"We want the latest Vim settings/options.
syntax enable
set backspace=indent,eol,start                      "Make backspace behave like every other editor.
let mapleader = ',' 						    	"The default is \, but a comma is much better.
set number								            "Let's activate line numbers.
set noerrorbells visualbell t_vb=               	"No damn bells!
set autowriteall                                    "Automatically write the file when switching buffers.
set complete=.,w,b,u 							    "Set our desired autocompletion matching.
set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4
set paste

"-------------plugins--------------"
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-vinegar'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'skwp/greplace.vim'
Plugin 'kristijanhusak/vim-hybrid-material'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'StanAngeloff/php.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'pangloss/vim-javascript'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'arnaud-lb/vim-php-namespace'
Plugin 'ervandew/supertab'
Plugin 'stephpy/vim-php-cs-fixer'
Plugin 'tobyS/vmustache'
Plugin 'tobyS/pdv'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


"-------------Visuals--------------"
set background=dark
colorscheme hybrid_material
set t_CO=256								       "Use 256 colors. This is useful for Terminal Vim.
set guifont=Fira\ Code:h17						   "Set the default font family and size.
set guioptions-=e							       "We don't want Gui tabs.

set guioptions-=l                                  "Disable Gui scrollbars.
set guioptions-=L
set guioptions-=r
set guioptions-=R

hi LineNr ctermbg=bg
set foldcolumn=2
hi foldcolumn ctermbg=bg

"Get rid of ugly split borders.
hi vertsplit ctermbg=bg ctermbg=bg

"-------------Set backup dir--------------"
set nobackup
set nowritebackup

"-------------Search--------------"
set hlsearch								      "Highlight all matched terms.
set incsearch								      "Incrementally highlight, as we type.

"-------------Split Management--------------"
set splitbelow 								      "Make splits default to below...
set splitright								      "And to the right. This feels more natural.

nmap <C-J> <C-W><C-J>                             "We'll set simpler mappings to switch between splits.
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

"-------------Shift Keys--------------"
command! -bang -nargs=* -complete=file E e<bang> <args>
command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>

"-------------Sane Search--------------"
noremap / /\v
vnoremap / /\v

"-------------Down is really down--------------"
nnoremap j gj
nnoremap k gk

"-------------Super Tabs--------------"
map <S-H> gT
map <S-L> gt

"-------------Conflict Markers--------------"
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

"-------------Keep search matches in the middle of the window--------------"
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

"-------------Repaint the screen--------------"
nnoremap U :syntax sync fromstart<cr>:redraw!<cr>


"-------------Additonal Mappings--------------"
"Make it easy to edit the Vimrc file.
nmap <Leader>ev :tabedit $MYVIMRC<cr>
nmap <Leader>es :e ~/.vim/snippets/

"Add simple highlight removal.
nmap <Leader><space> :nohlsearch<cr>

"Faster Saves.
nmap <Leader>w :w<cr>

"Faster Saves.
nmap <Leader>q :bd<cr>

"Quickly browse to any tag/symbol in the project.
"Tip: run ctags -R to regenerated the index.
nmap <Leader>f :tag<space>

"Sort PHP use statements
"http://stackoverflow.com/questions/11531073/how-do-you-sort-a-range-of-lines-by-length
vmap <Leader>su ! awk '{ print length(), $0 \| "sort -n \| cut -d\\  -f2-" }'<cr>


"-------------Plugins--------------"

"/
"/ CtrlP
"/
let g:ctrlp_custom_ignore = 'node_modules\DS_Store\|git'
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30,results:30'

nmap <D-p> :CtrlP<cr>
nmap <D-r> :CtrlPBufTag<cr>
nmap <D-e> :CtrlPMRUFiles<cr>
nmap <D-t> <Plug>PeepOpen

"/
"/ NERDTree
"/
let NERDTreeHijackNetrw = 0

nmap <C-b> :NERDTreeToggle<cr>

"/
"/ Greplace.vim
"/
set grepprg=ag								"We want to use Ag for the search.

let g:grep_cmd_opts = '--line-numbers --noheading'

"/
"/ vim-php-cs-fixer.vim
"/
let g:php_cs_fixer_level = "psr2"

nnoremap <silent><leader>pf :call PhpCsFixerFixFile()<CR>

"/
"/ pdv
"/
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"

nnoremap <leader>d :call pdv#DocumentWithSnip()<CR>
"/
"/  Supertab
"/
let g:SuperTabDefaultCompletionType = "<c-n>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : exists("g:loaded_snips") ? "\<C-r>=TriggerSnippet()\<CR>" : "\<Tab>"


"/
"/  Fugitive
"/
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

"/
"/ Airline
"/
set laststatus=2 " Broken down into easily includeable segments
set statusline=%<%f\                                   " Filename
set statusline+=%w%h%m%r                               " Options
set statusline+=%{fugitive#statusline()}               " Git Hotness
set statusline+=\ [%{&ff}/%Y]                          " Filetype
set statusline+=\ [%{getcwd()}]                        " Current dir
set statusline+=%=%-14.(%l,%c%V%)\ %p%%                " Right aligned file nav info

if !exists('g:airline_theme')
    let g:airline_powerline_fonts = 1
    let g:airline_theme = 'solarized'
endif

if !exists('g:airline_powerline_fonts')
    " Use the default set of separators with a few customizations
    let g:airline_left_sep='›'                        " Slightly fancier than '>'
    let g:airline_right_sep='‹'                       " Slightly fancier than '<'
endif


"-------------Laravel-Specific--------------"

nmap <Leader>lr :e app/Http/routes.php<cr>
nmap <Leader>lm :!php artisan make:
nmap <Leader><Leader>c :e app/Http/Controllers/<cr>
nmap <Leader><Leader>m :CtrlP<cr>app/
nmap <Leader><Leader>v :e resources/views/<cr>




"-------------Auto-Commands--------------"
"Automatically source the Vimrc file on save.

augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END



"-------------Functions--------------"
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>n <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>n :call PhpInsertUse()<CR>

function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction
autocmd FileType php inoremap <Leader>nf <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>nf :call PhpExpandClass()<CR>

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
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call StripTrailingWhitespace()

"-------------Tips and Reminders--------------"
" - Press 'zz' to instantly center the line where the cursor is located.
"- (Custom Mapping) Press ',f' to search for tags ( provide method name )
"- Press ':ts' to list tags found from search
"- Press ':tn' to go to next tag, and ':tp' to go the previous tag
"- Press 'Ctrl+]' to jump to where a method was initialized
"- Press 'Ctrl+^' to jump up to where a method is used ( might need to list them as well
"- Press 'Cmd+e' to select file from previous history
"- Press '-' to list current directory ( full screen )
"- Press 'Cmd+1' to open NERDTree
"- Press 'm+a' in NERDTree window to create a directory or file in your current working directory
"- Press ':Gsearch' to do a fast search and replace across specific directories
"- Press ':s' inside of Gsearch to set the parameters for your replacement logic ( e.g. ':s+/ChangeThis/ToThis' )
"- Press ':Ag' to do a quick project search via the_silver_searcher package
"= Press '<Number>+>" to indent a single line of block of elements by a certain number
"- Press 'v+i+t' to highlight everything inside of targeted element
"- Press ']+p' to paste your snippets with respect to present indentations
"= Press 'cs + <what you're changing> + <what you want it to be>' to change surrounding tag, quotes, parenthesis, etc.
"- Press 'cst + <tag you're changing> + <tag you want>' to change surrounding html tags to whatever your choice may be
"- Press 'dst' to remove surrounding tags
"- Press 'ds + <what to remove>' to remove sorrounding symbols/characters
"- Press '<Highlight Something> + <shift>-S + <opening tag>' to wrap the
"highlighted text in a certain html tag of your choice
"- Press 'gg + = + shift + G' to fix the indent for an entire file
"- Press '= + %' on open or close brackets to fix indentation for a specific
"block
