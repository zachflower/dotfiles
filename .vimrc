" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Install vim-plug if it isn't installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-projectionist'
Plug 'troydm/pb.vim'
Plug 'vim-syntastic/syntastic'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'kshenoy/vim-signature'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'Raimondi/delimitMate'
Plug 'joshdick/onedark.vim'
Plug 'jwalton512/vim-blade'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-endwise'
Plug 'StanAngeloff/php.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'ciaranm/securemodelines'

call plug#end()

" ================ Syntax Highlighting ====================
syntax on

" ================ General Config ====================
set title								" Update terminal window title
set visualbell					" Turn off sounds
set showmatch           " Cursor shows matching closing brackets
set showmode						" Show the current mode
set ruler               " Show the cursor position all the time"
set showcmd							" Show incomplete commands
set autoread						" Reload files changed outside of vim
set ttyfast							" Use a fast terminal connection
set showtabline=2				" Always Show Tab Line
set relativenumber      " Show Relative Line Numbers
set number							" Show Line Numbers
let mapleader=","				" Map leader from \ to ,
set undodir=$TMPDIR     " Use temp directory as undo directory
set undofile            " Enable persistent undo"
set splitright          " Split vertical windows right to the current windows
set splitbelow          " Split horizontal windows below to the current windows
set encoding=utf-8      " Set default encoding to UTF-8
set cmdheight=2         " Better display for messages
set updatetime=300      " Improve experience for diagnostic messages
set signcolumn=yes      " Always show signcolumns

" Speed up syntax highlighting
set nocursorcolumn
set nocursorline

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

" ================ Indentation =======================
set shiftwidth=2
set tabstop=2
set softtabstop=2
set wrap								" Wrap lines
set textwidth=79				" Width of text strings
set showbreak=↪
set expandtab
set list
set listchars=tab:\ \ ,trail:·,nbsp:•,eol:¬
set autoindent

" ================ Completion ========================
set wildmode=list:longest
set wildignore=*.o,*.obj,*~			" stuff to ignore when tab completing
set wildignore+=*DS_Store*
set wildignore+=*.png,*.jpg,*.gif,*.pdf,*.psd

" ================ Searching =========================
set incsearch           " Shows the match while typing
set ignorecase					" Ignore case when searching
set smartcase						" Don't ignore case if search contains upper-case characters
set gdefault						" Substitude command (:s) always does global search
set hlsearch						" Highlight searches by default

" ================ Folding ===========================
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent   " fold based on indent level

" tab opens/closes folds
nnoremap <tab> za

" ================ Mouse =============================
set mouse=a             " enable mouse use in all modes

" Set this to the name of your terminal that supports mouse codes.
" Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
set ttymouse=xterm2

" ================ Colors ============================
" Draw a distinction between 256 color terminals and 16 color terminals
if &t_Co == 256
  if !has("gui_running")
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " No `bg` setting
  end

  colorscheme onedark 
  let g:airline_theme='onedark'

  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235
else
  colorscheme peachpuff

  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey
endif

autocmd BufEnter * IndentGuidesEnable
let g:indent_guides_auto_colors = 0

"highlight Pmenu ctermfg=lightgrey ctermbg=234
"highlight PmenuSel ctermfg=white ctermbg=darkgrey
highlight clear SpellBad

" ================ Plugins ===========================

" airline
let g:airline_powerline_fonts = 0

" delimitMate
au FileType php let delimitMate_matchpairs = "(:),[:],{:}"

" CloseTag
autocmd FileType html,htmldjango,jinjahtml,eruby,ruby,mako let b:closetag_html_style=1

" CTags
if !executable('ctags')
  let g:tagbar_ctags_bin='/usr/local/bin/ctags'
endif

let g:tagbar_width = 40


autocmd VimEnter * nested :call tagbar#autoopen(1)
autocmd BufEnter * nested :call tagbar#autoopen(0)

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_check_on_open=1
let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=0
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['php', 'ruby'], 'passive_filetypes': ['c','h','cpp'] }
let g:syntastic_php_checkers = ["php", "phpmd"]

" Remember Last Position
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" ================ Remapping =========================
" Navigate rows rather than lines
nnoremap <down> gj
nnoremap <up> gk

" Write/quit fixes
:command! WQ wq
:command! Wq wq
:command! W w
:command! Q q

" Fix keycodes
imap  <Home>
imap  <End>

" Tabs
map } gt
map { gT

" Split Windows
map <leader>, <C-w>w

" Reselect visual block after indenting
vmap > > gv
vmap < < gv

" Center the screen
nnoremap <space> zz

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Do not show stupid q: window
map q: :q

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" ================== Ctrl+P Settings =================
let g:ctrlp_map = '<c-t>'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'et'  " jump to a file if it's open already"
let g:ctrlp_mruf_max = 450        " number of recently opened files
let g:ctrlp_max_files = 0         " do not limit the number of searchable files
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_open_new_file = 't'
let g:ctrlp_custom_ignore = {
  \   'dir': '\v[\/](node_modules|bower_components|\.cache|\.git|\.hg|\.svn|\.min\.css|\.min\.js)$',
  \   'file': '\v\.(exe|so|dll|swp)$'
  \ }

if executable('ag')
  " use Ag over grep if available
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in Ctrl+P for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

" =================== NERDTree ==================
nnoremap <leader>/ :NERDTreeToggle<CR>

let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.vim$', '\~$', '\.git$', '.DS_Store']

" =================== Startify ==================
let g:startify_files_number = 5 
let g:startify_change_to_vcs_root = 0

function! s:list_commits()
  let git = 'git -C ' . getcwd()
  let commits = systemlist(git .' log --oneline')

  " only list commits if in a git directory 
  if v:shell_error != 0
    return []  
  endif

  return map(commits[0:5], '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
endfunction

autocmd VimEnter * let t:startify_new_tab = 1
autocmd BufEnter *
  \ if !exists('t:startify_new_tab') && empty(expand('%')) |
  \   let t:startify_new_tab = 1 |
  \   Startify |
  \ endif

let g:startify_lists = [
  \   { 'header': ['   Recently Opened'],                    'type': 'files' },
  \   { 'header': ['   Recently Opened in '. getcwd()],      'type': 'dir' },
  \   { 'header': ['   Recent Commits'],                     'type': function('s:list_commits') }
  \ ]

" =================== Custom ==================
function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf 
endfunction

nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>

" set 160 character line limit (we have widescreens now)
if exists('+colorcolumn')
  set colorcolumn=160
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>160v.\+', -1)
endif

