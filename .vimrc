set nocompatible

" -----------------------------------------------------------------------------
" VUNDLE

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" TODO: install vim with Python3 support to get this going
" Plugin 'Rip-Rip/clang_complete'
" Plugin 'kien/ctrlp.vim'
" Plugin 'https://github.com/SirVer/ultisnips'
" Plugin 'honza/vim-snippets'

Plugin 'Valloric/YouCompleteMe'             " auto-completion
Plugin 'jeetsukumaran/vim-indentwise'       " moving based on indent levels
Plugin 'bogado/file-line'                   " open files with line number
Plugin 'terryma/vim-multiple-cursors'       " sublime text style mult cursors
Plugin 'vim-airline/vim-airline'            " bottom vim line
Plugin 'vim-airline/vim-airline-themes' 
Plugin 'scrooloose/syntastic'               " syntax checking
Plugin 'easymotion/vim-easymotion'          " moving quickly through file
Plugin 'scrooloose/nerdcommenter'           " commenting
Plugin 'nvie/vim-flake8'                    " style/syntax checking for python
Plugin 'hynek/vim-python-pep8-indent'       " proper python indenting
Plugin 'https://github.com/vim-scripts/vim-auto-save'   " saves when in normal

call vundle#end()

" -----------------------------------------------------------------------------
" SETTINGS

" use space as leader key
map <Space> <Leader>

set noswapfile
" matching by using % or 0:
set matchpairs+=<:>

" searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" line numbers
set number
" set relativenumber
" set iskeyword-=_

" line wrapping
set textwidth=79
set formatoptions+=t

" folding
set foldmethod=indent
set foldlevel=20

" colors
set t_Co=256

hi Visual ctermbg=236
hi Search cterm=NONE ctermfg=black ctermbg=202

highlight ColorColumn ctermbg=233 guibg=#2c2d27
let &colorcolumn=join(range(80,999),",")

hi MatchParen cterm=bold ctermbg=94 ctermfg=16

" Cursor color
if &term =~ "xterm\\|rxvt"
  " use a green cursor in insert mode
  let &t_SI = "\<Esc>]12;Green4\x7"
  " use a blue cursor otherwise
  let &t_EI = "\<Esc>]12;DodgerBlue3\x7"
  silent !echo -ne "\033]12;DodgerBlue3\007"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]112\007"
  " use \003]12;gray\007 for gnome-terminal and rxvt up to version 9.21
endif

set cursorline
hi CursorLine ctermbg=234 cterm=bold
if has('win32') || has('win16')
  hi CursorLine ctermbg=1
else
endif

set laststatus=2
set scrolloff=5
set timeoutlen=400
set backspace=indent,eol,start
set wildmenu

" -----------------------------------------------------------------------------
" REMAPS

" ESC remap
inoremap jk <Esc>
inoremap kj <Esc>

" Window switching
nmap <silent> <C-Left> :wincmd h<CR>
nmap <silent> <C-Right> :wincmd l<CR>
" Window resizing
nmap <silent> <C-Up> :vertical resize +10<CR>
nmap <silent> <C-Down> :vertical resize -10<CR>

" Tab switching
nmap <PageUp> :tabp<CR>
nmap <PageDown> :tabn<CR>

" Compile and run C program
map <F2> :! gcc % && sudo ./a.out <CR>

" Quick buffer switching
:nnoremap <F3> :buffers<CR>:buffer<Space>

" F4 opens file under cursor in vertical split
nnoremap <F4> :e %:p:s,.h$,.X123X,:s,.cc$,.h,:s,.X123X$,.cc,<CR>
":map <F4> :e %<.h
":map <F4> :vertical wincmd f<CR>

" F5 opens vimrc
if has("win32") || has("win16")
  :map <F5> :tabedit $HOME/_vimrc<CR>
else
  :map <F5> :tabedit $HOME/.vimrc<CR>
endif
" F6 reloads vimrc
:map <F6> :so $MYVIMRC<CR>

nnoremap _ O<Esc>j
nnoremap - o<Esc>k

" line wrap annoyance
nnoremap j gj
nnoremap k gk

" CTRL-d duplicates selection in visual
vmap <C-d> y'>p
" jump to beginning (soft) / end of line
nnoremap ( _
vnoremap ( _
nnoremap ) $
vnoremap ) $
" jump to matching bracket etc.
nnoremap 0 %
vnoremap 0 %
" Hard <--
nnoremap ^ 0
vnoremap ^ 0
" jump up/down
nnoremap J }
nnoremap K {
vnoremap J }
vnoremap K {
" jump before word / word
nnoremap H b
nnoremap L w
vnoremap H b
vnoremap L w
" necessary remap
nnoremap Q J
" Y inconsistency (normally copies entire line as opposed to C and D)
nnoremap Y y$

" remove surrounding parens or if defines
nnoremap <Leader>a %x<C-o>x
nnoremap <Leader>A %"_dd<C-o>"_dd

" move lines/blocks down/up
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-Q>', 'n') ==# ''
  nnoremap <silent> <C-Q> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-Q>
endif

" Indenting
"autocmd Filetype python setlocal tabstop=4 shiftwidth=4 softtabstop=4
set autoindent
set tabstop=4 shiftwidth=4 softtabstop=4
set expandtab       " On pressing tab, insert X spaces

" <Space> s does last search
nnoremap <Leader>s /<Up><Up><CR>
nnoremap <Leader>ss /<Up><Up><Up><CR>
nnoremap <Leader>sss /<Up><Up><Up><Up><CR>

" remove all trailing whitespaces (save curr search buffer, remove all trailing
" ws's w/o error if none are found, reset search buffer, turn off hl)
nnoremap <silent> <F8> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

syntax on
colorscheme burnttoast256

" -----------------------------------------------------------------------------
" YOU COMPLETE ME

"map [[ <Plug>(IndentWisePreviousLesserIndent)
"map ]] <Plug>(IndentWiseNextLesserIndent)
"map [= <Plug>(IndentWisePreviousEqualIndent)
"map ]= <Plug>(IndentWiseNextEqualIndent)

" -----------------------------------------------------------------------------
" AIRLINE

"let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='light'
let g:airline_powerline_fonts = 1

" -----------------------------------------------------------------------------
" YOU COMPLETE ME

let g:ycm_autoclose_preview_window_after_completion = 1

" -----------------------------------------------------------------------------
" EASY MOTION

"map <Leader> <Plug>(easymotion-prefix)
nmap <Space><Space> <Plug>(easymotion-bd-w)
nmap <Space>j <Plug>(easymotion-j)
nmap <Space>k <Plug>(easymotion-k)
nmap <Space>h <Plug>(easymotion-b)
nmap <Space>l <Plug>(easymotion-w)
nmap <Space>f <Plug>(easymotion-f)
nmap <Space>b <Plug>(easymotion-b)
nmap <Space>w <Plug>(easymotion-w)


"nmap <Space>j <Plug>(easymotion-bd-w)

" -----------------------------------------------------------------------------
" NERD COMMENTER

map <Leader>c <plug>NERDComToggleComment

filetype plugin indent on

" -----------------------------------------------------------------------------
" AutoSave

let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
"let g:auto_save_postsave_hook = 'TagsGenerate'
