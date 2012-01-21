set nocompatible
filetype on   " required for Vundle!
filetype off  " required for Vundle!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Vundle
Bundle 'gmarik/vundle'

" Bundles
"Bundle 'wycats/nerdtree'
Bundle 'ervandew/supertab'
Bundle 'altercation/vim-colors-solarized'
Bundle 'wavded/vim-stylus'
Bundle 'digitaltoad/vim-jade'
"Bundle 'hallettj/jslint.vim'
Bundle 'vim-scripts/jshint.vim'
Bundle 'tpope/vim-markdown'
Bundle 'robgleeson/hammer.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'vim-scripts/taglist.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'godlygeek/tabular'
Bundle 'Raimondi/delimitMate'
Bundle 'tpope/vim-unimpaired'
Bundle 'vim-scripts/searchfold.vim'
Bundle 'tpope/vim-git'
Bundle 'mattn/gist-vim'
Bundle 'mileszs/ack.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'ddollar/nerdcommenter'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/ZoomWin'
Bundle 'kchmck/vim-coffee-script'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'millermedeiros/vim-statline'
Bundle 'othree/html5.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'sickill/vim-pasta'

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
set expandtab
set list listchars=tab:\ \ ,trail:·

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

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
let NERDTreeMouseMode=2
let NERDTreeAutoCenter=0
let NERDChristmasTree=1
let NERDTreeChDirMode=2
let NERDTreeDirArrows=1
map <Leader>n :NERDTreeToggle<CR>

" Command-T plugin configuration
" let g:CommandTMaxHeight=20

" ZoomWin configuration
map <Leader><Leader> :ZoomWin<CR>

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>

" Snippets
let g:snippets_dir="~/.dotfiles/snippets/"

"if has("mac")
"    call ExtractSnipsFile("~/.dotfiles/snippets/", "javascript")


" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function! s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=72
endfunction

function! s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Hammer<CR>
endfunction

" make uses real tabs
au FileType make set noexpandtab

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} call s:setupMarkup()

" treat text files as markdown
au BufRead,BufNewFile *.txt    set filetype=markdown
" au BufRead,BufNewFile *.txt call s:setupWrapping()

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

" php tabbing
au FileType php set softtabstop=4 tabstop=4 shiftwidth=4 noexpandtab

" html filetype settings
au FileType html set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=0 noexpandtab

" css filetype settings
au FileType css set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=0 noexpandtab

" js tabbing
au FileType javascript set softtabstop=4 tabstop=4 shiftwidth=4 expandtab

" chz ut project tabbing
au BufRead,BufEnter ~/Sites/chzbrgr/icanhaz/* set softtabstop=4 tabstop=4 shiftwidth=4 noexpandtab

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on " required for Vundle!

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

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1

" gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" Use modeline overrides
set modeline
set modelines=10

" Default color scheme
color solarized
syntax enable
set background=dark

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Turn off jslint errors by default
" let g:JSLintHighlightErrorLine = 0

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

" Fancy version of :find - enables results list in quickfix pane
" Find file in current directory and edit it.
function! Find(...)
  let path="."
  if a:0==2
    let path=a:2
  endif
  let l:list=system("find ".path." -name '".a:1."' | grep -v .svn ")
  let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))
  if l:num < 1
    echo "'".a:1."' not found"
    return
  endif
  if l:num == 1
    exe "open " . substitute(l:list, "\n", "", "g")
  else
    let tmpfile = tempname()
    exe "redir! > " . tmpfile
    silent echon l:list
    redir END
    let old_efm = &efm
    set efm=%f

    if exists(":cgetfile")
        execute "silent! cgetfile " . tmpfile
    else
        execute "silent! cfile " . tmpfile
    endif

    let &efm = old_efm

    " Open the quickfix window below the current window
    botright copen

    call delete(tmpfile)
  endif
endfunction
command! -nargs=* Find :call Find(<f-args>)

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
