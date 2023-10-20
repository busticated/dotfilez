set nocompatible

" Vim-plug
call plug#begin('~/.vim/bundle')
Plug 'junegunn/vim-plug'
Plug 'ervandew/supertab'
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/base16-vim'
Plug 'sheerun/vim-polyglot'
Plug 'godlygeek/tabular'
Plug 'Raimondi/delimitMate'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
Plug 'millermedeiros/vim-statline'
Plug 'kien/ctrlp.vim'
Plug 'sickill/vim-pasta'
Plug 'tomtom/tcomment_vim'
Plug 'hrj/vim-DrawIt'
Plug 'yssl/QFEnter'
" Plug 'rust-lang/rust.vim'
call plug#end()

" Basics
set number
set ruler
syntax on

" Set encoding
set encoding=utf-8

" Set region to US English
set spelllang=en_us

" Whitespace stuff
set nowrap
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab
set list listchars=tab:\ \ ,trail:·
set colorcolumn=80

" Folding
set foldopen=all

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Status bar
set laststatus=2

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" History log size
set history=10000

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
let NERDTreeMouseMode=2
let NERDTreeAutoCenter=0
let NERDChristmasTree=1
let NERDTreeChDirMode=2
let NERDTreeDirArrows=1
let NERDTreeIgnore = ['^node_modules$']
map <Leader>n :NERDTreeToggle<CR>

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" make uses real tabs
au FileType make set noexpandtab

" ALE stuff
" set shell=zsh\ -l
set shellcmdflag=-ic
let g:ale_fix_on_save = 0
let g:ale_linters = {'rust': ['analyzer']}
let g:ale_linters_ignore = { 'javascript': ['deno'] }
let g:ale_fixers = { '*': ['trim_whitespace', 'remove_trailing_lines'], 'rust': ['rustfmt'] }
let g:ale_rust_analyzer_config = {
      \  'cargo': {
      \    'features': 'all'
      \  }
      \}

" RustFmt
" let g:rustfmt_options = '--edition=2021' - see: https://github.com/rust-lang/rust.vim/issues/439
let g:rustfmt_autosave = 1
" let g:rustfmt_emit_files = 1
" let g:rustfmt_fail_silently = 0

" bash
au BufRead,BufNewFile *bash* set filetype=sh

" recognize Jakefile files
au BufNewFile,BufRead {Jakefile} set filetype=javascript

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" disable 'concealing' for vim-json JSON syntax (via sheerun/vim-polyglot plugin)
let g:vim_json_syntax_conceal = 0

" Use modeline overrides
set modeline
set modelines=10

" Default color scheme
color solarized
colorscheme solarized
syntax enable
set background=light
let g:solarized_termtrans = 1
let g:solarized_termcolors = 256
"let g:solarized_visibility = "high"
"let g:solarized_contrast = "high"

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/swp//

" CtrlP settings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$',
  \ 'file': '\.exe$\|\.so$\|\.dll$\|\.DS_Store$',
  \ 'link': 'bad_symbolic_link',
  \ }

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

" % to bounce from do to end etc.
runtime! macros/matchit.vim

" Show (partial) command in the status line
set showcmd

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" macros
let @j='''<,''>s/"\(.*\)":/\1:/g''<,''>s/''/\''/ge''<,''>s/"/''/ge"nohlsearch'
