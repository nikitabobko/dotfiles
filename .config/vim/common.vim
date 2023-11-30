set langmap=ё`йqцwуeкrеtнyгuшiщoзpх[ъ]фaыsвdаfпgрhоjлkдlж\\;э'яzчxсcмvиbтnьmб\\,ю.Ё~№#ЙQЦWУEКRЕTНYГUШIЩOЗPХ{Ъ}ФAЫSВDАFПGРHОJЛKДLЖ:Э\"ЯZЧXСCМVИBТNЬMБ<Ю>
set keymap=russian-jcukenwin " Switch with ctrl-6 while in insert mode
call plug#begin()
  " Plug 'RRethy/vim-hexokinase'| " Colors in the editor. The plugin requires fucking manual `make`
  " Plug 'easymotion/vim-easymotion'
  " Plug 'godlygeek/tabular'| Plug 'preservim/vim-markdown'
  " Plug 'powerman/vim-plugin-ruscmd'
  " Plug 'sheerun/vim-polyglot'
  " Plug 'tomasr/molokai'
  " TODO: autosave
  "Plug 'AndrewRadev/switch.vim'
  " Plug 'preservim/nerdtree'
  " Plug 'Yggdroot/indentLine'| " Indentation vertical line. Disable because it override conceallevel
  Plug 'chrisbra/Recover.vim'| " Prompt to show diff when recovering vim swap file
  Plug 'AndrewRadev/linediff.vim'| " Simple plugin to show diff between marked lines
  Plug 'jeffkreeftmeijer/vim-numbertoggle'| " Use relative numbers only when terminal window is focused & in normal mode
  Plug 'junegunn/fzf.vim'
  Plug 'kana/vim-textobj-user' |
    Plug 'kana/vim-textobj-entire'| " text object = entire document
    Plug 'kana/vim-textobj-line'| " line text object
    Plug 'pianohacker/vim-textobj-indented-paragraph'
    Plug 'saihoooooooo/vim-textobj-space'| " continious whitespaces text object
    Plug 'glts/vim-textobj-comment'| " ic/ac comment text object

  Plug 'AndrewRadev/linediff.vim'| " :Linediff
  Plug 'unblevable/quick-scope'| " Highlight unique letters on the line
  " Plug 'mg979/vim-visual-multi'| " Multi carret
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'morhetz/gruvbox'| " Color theme
  Plug 'psliwka/vim-smoothie'| " Smooth scrolling
  Plug 'tpope/vim-commentary'| " 'gc' to comment
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'| " Extend dot behaviour to repeat custom actions from plugins
  Plug 'tpope/vim-sleuth'| " automatic indent
  Plug 'tpope/vim-surround'
  Plug 'udalov/kotlin-vim'
  Plug 'wellle/targets.vim'| " Additional text objects (arguments inside paired chars like /)
  Plug 'haya14busa/vim-asterisk'| " z start motion + star in visual mode
  Plug 'tpope/vim-unimpaired'| " Pairs of handy bracket mappings ]q, [q (for quick fix list), ]a, [a (for argument list), ]<Space>, [<Space>
  Plug 'neoclide/coc.nvim', {'branch': 'release'}| " The plugin enables autocompletion

  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

  Plug 'MrcJkb/haskell-tools.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/plenary.nvim'
call plug#end()

set termguicolors
colorscheme gruvbox
set bg=dark
let &t_ut=''| " Fix background issue in kitty terminal https://github.com/kovidgoyal/kitty/issues/108

" HACK https://github.com/junegunn/fzf.vim/issues/439
set rtp+=/opt/homebrew/opt/fzf

" dash in completion
autocmd FileType * let b:coc_additional_keywords = ["-"]

let g:indentLine_char = '▏'
"set spell spelllang=en_us
au BufRead,BufNewFile git-revise-todo setfiletype gitrebase
set smartcase
set autoindent| " Auto indent
set wildmenu| " Better tab completion in command mode
set wildmode=longest:full,lastused:full
set wildignorecase| " Ignore case in wildmenu
filetype plugin on

"autocmd FileType gitcommit set textwidth=72
set colorcolumn=+1| " Ruler
set textwidth=130| " automatically insert line breaks at specified length

set expandtab shiftwidth=4| " OVERRIDE SLEUTH DEFAUL: Tn pressing tab, insert 4 spaces
set conceallevel=0| " Never ever hide quotes in json
set hlsearch| " Search highlighting
set ignorecase| " ignore case in search
" set foldmethod=syntax
" set nofoldenable| " Don't fold everything by default
set incsearch| " Show matches while search
set list listchars=space:·,tab:╶─
set mouse=a| " Mouse support
set number relativenumber| " Show line numbers
set tabstop=4| " show existing tab with 4 spaces width
set timeoutlen=1000 ttimeoutlen=0 " Avoid delay on ESC
set hidden| " Don't require to save buffer in order to switch to another buffer
set nofixendofline| " Don't add new lines at the end of every file
set iminsert=0
set imsearch=-1
syntax on| " Enable or disable syntax
set nowrapscan| " Don't cycle search results
set cursorline| " Highlight line where the cursor is

if executable('rg')
  source ~/.v/ripgrep-sensible.vim
endif

set undodir=$HOME/.vim/undo| " directory where the undo files will be stored
set undofile

" Different cursor style (beam/block) in different modes
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

" Paste yanked line without line breaks before/after cursor position
nnoremap gP i<CR><Esc>"+PkJxJx
nnoremap gp a<CR><Esc>"+PkJxJx

""""""""""""""""
""" BINDINGS """
""""""""""""""""
":map   :noremap  :unmap     Normal, Visual, Select, Operator-pending
":nmap  :nnoremap :nunmap    Normal
":vmap  :vnoremap :vunmap    Visual and Select
":smap  :snoremap :sunmap    Select
":xmap  :xnoremap :xunmap    Visual
":omap  :onoremap :ounmap    Operator-pending
":map!  :noremap! :unmap!    Insert and Command-line
":imap  :inoremap :iunmap    Insert
":lmap  :lnoremap :lunmap    Insert, Command-line, Lang-Arg
":cmap  :cnoremap :cunmap    Command-line
":tmap  :tnoremap :tunmap    Terminal-Job
" Insert modes key mappings
imap <C-h> <C-w>|  " ctrl-backspace to drop a word (CLI)
imap <C-BS> <C-w>| " ctrl-backspace to drop a word (GUI)
imap <C-v> <ESC>"+pa
vmap <C-c> "+y
cmap <C-v> <C-r>+
map <Space>b :Buffers!<CR>
map <Space>f :Files!<CR>
map <Space>s :GFiles!?<CR>| " git status files
map <Space>h :History!<CR>
map <Space>r :Rg!<CR>
map <Space>b :G blame<CR>
map <Space>l :G log -p -- %<CR>
"
" https://vi.stackexchange.com/questions/20307/find-and-highlight-current-file-in-netrw
" map <silent> <Space>e :Ex <bar> :sil! /<C-R>=expand("%:t")<CR><CR>
map <Space>e :e <C-R>=expand("%:h")<CR>/

map <Space>Q :cq!<CR>| map <Space>Й :cq!<CR>
map <Space>q :wqa<CR>| map <Space>й :wqa<CR>
map <Space>w :wa<CR>| map <Space>ц :wa<CR>
" Whenever I do line-wise operations (like prepend something with `I`) then
" I want to be able to repeat it with dot in visual mode
xnoremap . :normal .<CR>
xnoremap @ :normal @

" Switch keyboard layout in vim using ctrl+space
" inoremap <C-Space> <C-^>

" Swap ^$ pair with HL because ^$ are used much more often than HL but HL is home-row friendly
noremap H ^| noremap Р ^
noremap L $| noremap Д $
noremap ^ H
noremap $ L

map <Space><ESC> :noh<CR>
" nmap <A-S-k> <C-Up>| " Extend vim-visual-multi functionality
" nmap <A-S-j> <C-Down>| " Extend vim-visual-multi functionality

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Record big relative jumps into jumplist
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

if has('ide')
else
  " haya14busa/vim-asterisk plugin
  map *   <Plug>(asterisk-*)
  map #   <Plug>(asterisk-#)
  map g*  <Plug>(asterisk-g*)
  map g#  <Plug>(asterisk-g#)
  map z*  <Plug>(asterisk-z*)
  map gz* <Plug>(asterisk-gz*)
  map z#  <Plug>(asterisk-z#)
  map gz# <Plug>(asterisk-gz#)
endif

" Clipboard
" set clipboard=unnamedplus| " Use OS system clipboard
noremap Y "+y$| " Make Y consistent with D and C
noremap y "+y
nnoremap yy "+yy
noremap <Space>y y| " Make original y functionality accessible
nnoremap <Space>yy yy| " Make original y functionality accessible
noremap p "+p| noremap <Space>p p
noremap P "+P| noremap <Space>P P
noremap s "+d
nnoremap ss "+dd
noremap S "+D

" Clipboard for Russian layout
noremap Н "+y$| " Make Y consistent with D and C
noremap н "+y
nnoremap нн "+yy
noremap <Space>н y| " Make original y functionality accessible
nnoremap <Space>нн yy| " Make original y functionality accessible
noremap з "+p| noremap <Space>p p
noremap З "+P| noremap <Space>P P
noremap ы "+d
nnoremap ыы "+dd
noremap Ы "+D
" tnoremap <Esc> <C-\><C-n>

" Rarely used keys:
" Q (gQ can be used as a replacement)
" R
" s
" S (remap only not in visual mode (because visual mode is taken by vim-surrond) 
" H
" L
" Tab (in normal mode)
" also see: https://www.reddit.com/r/vim/comments/shtto/what_are_the_main_single_keys_that_you_remap_in/

let g:fzf_preview_window = ['down:50%', 'ctrl-/']| " Usually I have long paths in projects so I move preview to the down to give

" Some magic to automatically create parent directories https://stackoverflow.com/a/4294176/4359679
augroup BWCCreateDir
  autocmd!
  autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p ".shellescape(expand('%:h'), 1) | redraw! | endif
augroup END

" Make it possible to send fzf results into quickfix list https://github.com/junegunn/fzf.vim/issues/185
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Automatically sync plugins on startup https://github.com/junegunn/vim-plug/wiki/extra#automatically-install-missing-plugins-on-startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

