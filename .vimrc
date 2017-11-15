set nocompatible

"source /usr/share/vim/google/google.vim
"Glug g4

" -----------------------------------------------------------------------------
" VUNDLE

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'       " auto-completion
Plugin 'jeetsukumaran/vim-indentwise' " moving based on indent levels
Plugin 'terryma/vim-multiple-cursors' " sublime text style mult cursors
Plugin 'vim-airline/vim-airline'      " bottom vim line
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/syntastic'         " syntax checking
Plugin 'easymotion/vim-easymotion'    " moving quickly through file
Plugin 'scrooloose/nerdcommenter'     " commenting
Plugin 'nvie/vim-flake8'              " style/syntax checking for python
Plugin 'hynek/vim-python-pep8-indent' " proper python indenting
Plugin 'vim-scripts/vim-auto-save'    " saves when in normal
Plugin 'henrik/vim-indexed-search'    " count search matches
Plugin 'evidanary/grepg.vim'
Plugin 'lervag/vimtex'                " Latex stuff
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/vim-easy-align'      " Aligning text
Plugin 'rhysd/clever-f.vim'               " Use f repeatedly (replaces ; and ,)

" Testing area:
Plugin 'tpope/vim-surround'
Plugin 'nightsense/vimspectr'

" Plugin 'https://github.com/SirVer/ultisnips'
" Plugin 'honza/vim-snippets'
" Plugin 'xolox/vim-session'                " session management

" install vim with Python3 support to get this going
" Plugin 'Rip-Rip/clang_complete'

" Deprecated for now:
" Plugin 'scrooloose/nerdtree'
" Plugin 'bogado/file-line'                   " open files with line number

call vundle#end()

" -----------------------------------------------------------------------------
" META STUFF

" Fix ALT key binding problems
for i in range(97,122)
  let c = nr2char(i)
  exec "map \e".c." <M-".c.">"
  exec "map! \e".c." <M-".c.">"
endfor


" -----------------------------------------------------------------------------
" GENERAL SETTINGS MAKING LIFE EASIER

set matchpairs+=<:>            " matching by using % for <> pairs as well.
set number                     " Line numbers
set laststatus=2
set scrolloff=5                " Couple lines after bottom line / before top line with cursor
set timeoutlen=300             " Timeout for key presses, e.g. jk
set backspace=indent,eol,start " BS behaviour
set wildmenu
set synmaxcol=250              " improve performance by only applying syntax highlighting to 250 chars per line


" -----------------------------------------------------------------------------
" LEADER BINDINGS

" abcdefghijklmnopqrstuvwxyz
" ^^ ^      ^^^  ^  ^   ^  ^

" Use space as leader key
map <Space> <Leader>

" Replace word under cursor everywhere.
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>

" Paste from register holding most recent yank (instead of possibly last delete)
nnoremap <Leader>p "0p
nnoremap <Leader>P "0P

" Delete line contents but don't delete the line
nnoremap <Leader>d ^D

" Duplicate line
nnoremap <Leader>m "9yyp
vnoremap <Leader>m "9yp

" Easy Motion movements
"let g:EasyMotion_do_mapping = 0 " not working
nnoremap <Leader><Leader> <Plug>(easymotion-bd-w)
nnoremap <Leader>j <Plug>(easymotion-j)
nnoremap <Leader>k <Plug>(easymotion-k)
let g:EasyMotion_do_mapping = 0

" Easily get to underscores within variable names
nnoremap <Leader>w f_
nnoremap <Leader>b F_
vnoremap <Leader>w f_
vnoremap <Leader>b F_

" <Space> s does last seach
nnoremap <Leader>s /<Up><Up><CR>
nnoremap <Leader>ss /<Up><Up><Up><CR>
nnoremap <Leader>sss /<Up> <Up><Up><Up><CR>

" remove surrounding parens or if defines
nnoremap <Leader>a %x<C-o>x
nnoremap <Leader>A %"_dd<C-o>"_dd
" Insert spaces around a char
nnoremap <Leader>z i<Space><Esc>lli<Space><Esc>h

" Nerd Commenter - toggle comment.
map <Leader>c <plug>NERDComToggleComment


" -----------------------------------------------------------------------------
"

set noswapfile


" -----------------------------------------------------------------------------
" Searching

" General '/' search settings
set hlsearch
set incsearch
set ignorecase
set smartcase

" Search for selected text using * and #, n/N for forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" line wrapping
set textwidth=80
set formatoptions+=t
set formatoptions-=o

" save marks on exit (only works for upper case or lower when buffer isn't cleared, :he 21.3 / E20)
:set viminfo='1000,f1

" folding
set foldmethod=syntax
set foldlevel=20

" -----------------------------------------------------------------------------
" VISUAL APPEARANCE

set cursorline
hi CursorLine ctermbg=234 cterm=bold

" Colors
set t_Co=256
hi Visual ctermbg=236
hi Search cterm=NONE ctermfg=black ctermbg=202

" Grey background for column 81
set colorcolumn=+1

" Cursor color
if &term =~ "xterm\\|rxvt"
  " use a green cursor in insert mode
  let &t_SI = "\<Esc>]12;Green4\x7"
  " use a blue cursor otherwise
  let &t_EI = "\<Esc>]12;gray80\x7"
  silent !echo -ne "\033]12;gray80\007"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]112\007"
  " use \003]12;gray\007 for gnome-terminal and rxvt up to version 9.21
endif

colorscheme vimspectr210wflat-dark
"colorscheme burnttoast256

" -----------------------------------------------------------------------------
" REMAPS

" ESC remap
inoremap jk <Esc>
inoremap kj <Esc>

" Window switching
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
" Tab switching
nmap <silent> <C-Right> :tabn<CR>
nmap <silent> <C-Left>  :tabp<CR>
"nmap <silent> <End>     :tabn<CR>
"nmap <silent> <Home>    :tabp<CR>
" Window resizing TODO: Maybe make this ctrl as well?
nmap <silent> <M-Right> :vertical resize +3<CR>
nmap <silent> <M-Left>  :vertical resize -3<CR>
nmap <silent> <M-Up>		:resize +3<CR>
nmap <silent> <M-Down>  :resize -3<CR>

" Compile and run C program
map <F2> :! gcc % && ./a.out <CR>
" Compile and run C++ program
map <F3> :! g++ -std=c++11 % && ./a.out <CR>
" Run Python programs
autocmd FileType python nnoremap <buffer> <F7> :exec '!python3' shellescape(@%, 1)<cr>


" F5 opens vimrc
:map <F5> :tabedit $HOME/.vimrc<CR>
" F6 reloads vimrc
:map <F6> :so $MYVIMRC<CR>

" Insert line above or below
nnoremap _ O<Esc>j
nnoremap - o<Esc>k

" Line wrap annoyance
nnoremap j gj
nnoremap k gk

" CTRL-d duplicates selection in visual TODO
vmap <C-d> y'>p

" jump to beginning (soft) / end of line
nnoremap ( _
vnoremap ( _
nnoremap ) $
vnoremap ) $

" jump to matching bracket etc.
nnoremap 0 %
vnoremap 0 %

" jump up/down
nnoremap J }
nnoremap K {
vnoremap J }
vnoremap K {
" jump before word / after word
nnoremap H b
nnoremap L w
vnoremap H b
vnoremap L w

" necessary remap
nnoremap Q J
" Y inconsistency (normally copies entire line as opposed to C and D)
nnoremap Y y$

" move lines/blocks down/up TODO: map this to something new?
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi
vnoremap <M-j> :m '>+1<CR>gv
vnoremap <M-k> :m '<-2<CR>gv

" Use <C-G> to clear the highlighting of :set hlsearch.
nnoremap <silent> <C-G> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-G>

" Indenting
"autocmd Filetype python setlocal tabstop=2 shiftwidth=2 softtabstop=2
set autoindent
set tabstop=2 shiftwidth=2 softtabstop=2
"set expandtab       " On pressing tab, insert X spaces

" remove all trailing whitespaces (save curr search buffer, remove all trailing
" ws's w/o error if none are found, reset search buffer, turn off hl)
nnoremap <silent> <F8> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

 syntax on 

" Highlight matching Parenthesis
DoMatchParen
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta


" -----------------------------------------------------------------------------
" PLUGINS

" Syntastic
let g:loaded_syntastic_java_javac_checker = 1

" Indent Wise
"map [[ <Plug>(IndentWisePreviousLesserIndent)
"map ]] <Plug>(IndentWiseNextLesserIndent)
"map [= <Plug>(IndentWisePreviousEqualIndent)
"map ]= <Plug>(IndentWiseNextEqualIndent)

" Airline
let g:airline_theme='light'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" You Complete Me
let g:ycm_autoclose_preview_window_after_completion = 1

" fzf
nmap <C-f> :Files<CR>
nmap <C-t> :Tags<CR>
nmap <C-b> :Buffers<CR>

" Easy Align
vmap ga <Plug>(EasyAlign)

" Clever-f
let g:clever_f_smart_case = 1
let g:clever_f_timeout_ms = 10000
"let g:clever_f_fix_key_direction = 1

" Autosave
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1

filetype plugin indent on

" -----------------------------------------------------------------------------
" DEPRECATION AREA

" Insert Mode upper case remaps - trying this out.
" Ok, this is stupid.
"inoremap II <Esc>I
"inoremap AA <Esc>A
"inoremap OO <Esc>O
"inoremap CC <Esc>C
"inoremap SS <Esc>S
"inoremap DD <Esc>dd
"inoremap UU <Esc>u

" Quick buffer switching
":nnoremap <F3> :buffers<CR>:buffer<Space>

"nmap <PageUp> :tabp<CR>
"nmap <PageDown> :tabn<CR>

" set relativenumber
" set iskeyword-=_
