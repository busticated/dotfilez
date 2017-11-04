" Vundle configs --------------------------------------------------------------
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle itself
Plugin 'gmarik/Vundle.vim'

" Bundles
Plugin 'ervandew/supertab'
Plugin 'altercation/vim-colors-solarized'
Plugin 'chriskempson/base16-vim'
Plugin 'tpope/vim-markdown'
Plugin 'pangloss/vim-javascript'
Plugin 'elzr/vim-json'
Plugin 'vim-scripts/taglist.vim'
Plugin 'godlygeek/tabular'
Plugin 'Raimondi/delimitMate'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/ZoomWin'
Plugin 'tpope/vim-liquid'
Plugin 'w0rp/ale'
Plugin 'scrooloose/nerdtree'
Plugin 'millermedeiros/vim-statline'
Plugin 'othree/html5.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'sickill/vim-pasta'
Plugin 'groenewege/vim-less'
Plugin 'tomtom/tcomment_vim'
Plugin 'wesQ3/vim-windowswap'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'derekwyatt/vim-scala'
Plugin 'hrj/vim-DrawIt'
Plugin 'yssl/QFEnter'

call vundle#end()
filetype plugin indent on " load plugin & indent settings for detected filetype
" End Vundle configs ----------------------------------------------------------

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
map <Leader>n :NERDTreeToggle<CR>

" Command-T plugin configuration
" let g:CommandTMaxHeight=20

" ZoomWin configuration
map <Leader><Leader> :ZoomWin<CR>

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>

" Snippets
let g:snippets_dir="~/.vim/bundle/snipmate.vim/snippets/,~/.dotfiles/vim/snippets/"

"if has("mac")
"    call ExtractSnipsFile("~/.dotfiles/snippets/", "javascript")


" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" make uses real tabs
au FileType make set noexpandtab

" bash
au BufRead,BufNewFile *bash* set filetype=sh

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set filetype=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} call s:setupMarkup()

" treat text files as markdown
au BufRead,BufNewFile *.txt    set filetype=markdown
" au BufRead,BufNewFile *.txt call s:setupWrapping()

" add json syntax highlighting
au BufNewFile,BufRead *.{js} set filetype=javascript

" recognize Jakefile files
au BufNewFile,BufRead {Jakefile} set filetype=javascript

" recognize {LESS} files
au BufNewFile,BufRead *.less set filetype=less

" sh tabbing
au FileType sh set softtabstop=2 tabstop=2 shiftwidth=2 expandtab

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

" php tabbing
au FileType php set softtabstop=4 tabstop=4 shiftwidth=4 noexpandtab

" html filetype settings
au FileType html set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=0 expandtab

" css filetype settings
au FileType css set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=0 expandtab

" less tabbing
au FileType less set softtabstop=4 tabstop=4 shiftwidth=4 expandtab

" js tabbing
au FileType javascript set softtabstop=4 tabstop=4 shiftwidth=4 expandtab

" scala tabbing
au FileType scala set softtabstop=2 tabstop=2 shiftwidth=2 expandtab

" chz projects tabbing
au BufRead,BufEnter ~/Sites/chzbrgr/icanhaz/* set softtabstop=4 tabstop=4 shiftwidth=4 noexpandtab
au BufRead,BufEnter ~/Sites/chzbrgr/OnOProtos* set softtabstop=4 tabstop=4 shiftwidth=4 noexpandtab

" liquid template tabbing
au FileType liquid set softtabstop=2 tabstop=2 shiftwidth=2 expandtab

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

" disable 'concealing' for vim-json JSON syntax plugin
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
set directory=~/.vim/backup

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

" syntax debugging
function! SynStack()
    if !exists('*synstack')
        return
    endif
    echo map(synstack(line('.'), col('.')), "synIDattr(v:val, 'name')")
endfunc

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" macros
let @j='''<,''>s/"\(.*\)":/\1:/g''<,''>s/''/\''/ge''<,''>s/"/''/ge"nohlsearch'
