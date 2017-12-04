" -----------------------------------------------------------------------------
" GENERAL SETTINGS MAKING LIFE EASIER

set nocompatible

filetype plugin indent on
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

set autoindent
set tabstop=2    " on pressing TAB
set shiftwidth=2 " Shifting Text left or right using < and >
set softtabstop=2
" set expandtab    " On pressing tab, insert X spaces
set backspace=indent,eol,start " BS behaviour

set hlsearch
set incsearch
set ignorecase
set smartcase

set number                     " Line numbers
set matchpairs+=<:>            " matching by using % for <> pairs as well.
set nrformats-=octal					 " Don't increment octal, only hex and dec.
set laststatus=2							 " Always display status bar.
set nowrap
set display+=lastline
set timeoutlen=300             " Timeout for key presses, e.g. jk
set wildmenu
set synmaxcol=200              " improve performance by only applying syntax highlighting to 250 chars per line
set noswapfile
set sessionoptions-=options
set sessionoptions+=tabpages,globals

set textwidth=80
set formatoptions+=t
set formatoptions-=o
set viminfo='1000,f1 " save marks on exit (only works for upper case or lower when buffer isn't cleared, :he 21.3 / E20)

set foldmethod=syntax
set foldlevelstart=0
" set foldlevel=20

if !&scrolloff
  set scrolloff=5							 " Couple lines after bottom line / before top line with cursor
endif
if !&sidescrolloff
  set sidescrolloff=5					 " Couple columns after/before cursor in line
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j				 " Delete comment character when joining commented lines
endif

" Fix ALT key binding problems
for i in range(97,122)
  let c = nr2char(i)
  exec "map \e".c." <M-".c.">"
  exec "map! \e".c." <M-".c.">"
endfor


" -----------------------------------------------------------------------------
" VUNDLE

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

"Plugin 'ervandew/supertab'

Plugin 'Valloric/YouCompleteMe'       " auto-completion
Plugin 'jeetsukumaran/vim-indentwise' " moving based on indent levels
Plugin 'terryma/vim-multiple-cursors' " sublime text style mult cursors
Plugin 'vim-airline/vim-airline'      " bottom vim line
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/syntastic'         " syntax checking
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
Plugin 'easymotion/vim-easymotion'    " moving quickly through file
Plugin 'majutsushi/tagbar'						" 
Plugin 'tpope/vim-surround'
Plugin 'tmhedberg/SimpylFold'
Plugin 'gcmt/taboo.vim'								" Name tabs in tabline

" Testing area:
Plugin 'xtal8/traces.vim'
Plugin 'justinmk/vim-sneak'
" Plugin 'Yggdroot/indentLine'
"Plugin 'SirVer/ultisnips' " TODO
"Plugin 'honza/vim-snippets'


" Deprecated for now:

" Plugin 'scrooloose/nerdtree'

" install vim with Python3 support to get this going
" Plugin 'Rip-Rip/clang_complete'

call vundle#end()


" -----------------------------------------------------------------------------
" VISUAL APPEARANCE

set cursorline
set colorcolumn=+1

" Cursor color: Green4 in insert, DodgerBlue3 in normal, reset when exiting vim.
if &term =~ "xterm\\|rxvt"
  let &t_SI = "\<Esc>]12;Green4\x7"
  let &t_EI = "\<Esc>]12;DodgerBlue3\x7"
  silent !echo -ne "\033]12;DodgerBlue3\007"
  autocmd VimLeave * silent !echo -ne "\033]112\007" " reset cursor when vim exits
endif

" colorscheme burnttoast256
colorscheme inbetween

" -----------------------------------------------------------------------------
" LEADER BINDINGS

" abcdefghijklmnopqrstuvwxyz
" ^^ ^ ^  ^^^^^  ^ ^^-  ^ ^^

" Use space as leader key
map <Space> <Leader>

" Replace word under cursor everywhere.
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
vnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>

" replace word under cursor in insert mode, then . to replace other occurrences.
nnoremap <Leader>i *Ncgn

" Paste from register holding most recent yank (instead of possibly last delete)
nnoremap <Leader>p "0p
nnoremap <Leader>P "0P

" Delete line contents but don't delete the line
nnoremap <Leader>d ^D

" Duplicate line or selection.
nnoremap <silent> <Leader>m "9yyp
vnoremap <silent> <Leader>m "9y'>p

" Add 'todo' at the end of the line depending on filetype.
autocmd Filetype c,cpp     nnoremap <silent> <Leader>t :normal A // TODO: <CR>A
autocmd Filetype python    nnoremap <silent> <Leader>t :normal A # TODO: <CR>A
autocmd Filetype vimscript nnoremap <silent> <Leader>t :normal A " TODO: <CR>A

" Easy Motion movements
map <Leader>O <Plug>(easymotion-overwin-w)
map <Leader>o <Plug>(easymotion-bd-w)
map <Leader>f <Plug>(easymotion-bd-f)
map <Leader>F <Plug>(easymotion-overwin-f)

map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>l <Plug>(easymotion-wl)
map <Leader>h <Plug>(easymotion-bl)

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
" REMAPS

" ESC remap
inoremap jk <Esc>
inoremap kj <Esc>

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

" Window switching
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
" Tab switching
nmap <silent> <C-Right> :tabn<CR>
nmap <silent> <C-Left>  :tabp<CR>
" Window resizing
nmap <silent> <M-Right> :vertical resize +3<CR>
nmap <silent> <M-Left>  :vertical resize -3<CR>
nmap <silent> <M-Up>		:resize +3<CR>
nmap <silent> <M-Down>  :resize -3<CR>

" Insert line above or below
nnoremap _ O<Esc>j
nnoremap - o<Esc>k

" Line wrap annoyance
nnoremap j gj
nnoremap k gk
" Y inconsistency (normally copies entire line as opposed to C and D)
nnoremap Y y$
" necessary remap
nnoremap Q J

" jump to beginning (soft) / end of line
nnoremap ( _
vnoremap ( _
nnoremap ) $
vnoremap ) $

" jump to matching bracket etc.
nnoremap 0 %
vnoremap 0 %

" move lines/blocks down/up
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi
vnoremap <M-j> :m '>+1<CR>gv
vnoremap <M-k> :m '<-2<CR>gv

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

" Use <C-G> to clear the highlighting of :set hlsearch.
nnoremap <silent> <C-G> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-G>

" remove all trailing whitespaces (save curr search buffer, remove all trailing
" ws's w/o error if none are found, reset search buffer, turn off hl)
nnoremap <silent> <F8> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" TODO: Use filetypes here.
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
let g:ycm_global_ycm_extra_conf = '$USER/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

" fzf
nmap <C-f> :Files<CR>
nmap <C-t> :Tags<CR>
nmap <C-b> :Buffers<CR>

" Easy Align
vmap ga <Plug>(EasyAlign)

" Autosave
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1

" NERDCommenter
let NERDSpaceDelims=1

" Tagbar
nmap <F7> :TagbarToggle<CR>

" SimpylFold
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_import = 0

" Sneak


" IndentLine
" let g:indentLine_color_term = 239
" let g:indentLine_char = '⎸'
" set list
" set listchars=tab:>-

" UltiSnips

" make YCM compatible with UltiSnips (using supertab)
"let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
"let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
"let g:UltiSnipsExpandTrigger = "<C-s>"
"let g:UltiSnipsJumpForwardTrigger = "<tab>"
"let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


" -----------------------------------------------------------------------------
" DEPRECATION AREA

"source /usr/share/vim/google/google.vim
"Glug g4

" Quick buffer switching
":nnoremap <F3> :buffers<CR>:buffer<Space>

"nmap <PageUp> :tabp<CR>
"nmap <PageDown> :tabn<CR>

" set relativenumber
" set iskeyword-=_
