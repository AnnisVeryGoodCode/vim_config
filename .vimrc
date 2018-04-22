" -----------------------------------------------------------------------------
" GENERAL SETTINGS MAKING LIFE EASIER

set nocompatible

filetype plugin indent on
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

set autoindent
set tabstop=2 " on pressing TAB
set shiftwidth=2 " Shifting Text left or right using < and >
set softtabstop=2
" autocmd FileType python setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
" autocmd FileType tex    setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
" set list lcs=tab:\|\ 
set expandtab " On pressing tab, insert X spaces
set backspace=indent,eol,start " BS behaviour

set hlsearch
set incsearch
set ignorecase
set smartcase

set updatetime=2000
set number " Line numbers
set matchpairs+=<:> " matching by using % for <> pairs as well.
set nrformats-=octal " Don't increment octal, only hex and dec.
set nowrap
set display+=lastline
set timeoutlen=300 " Timeout for key presses, e.g. jk
set wildmenu
set synmaxcol=200 " improve performance by only applying syntax highlighting to 250 chars per line
set noswapfile
set sessionoptions=tabpages,winsize,buffers,globals
set nojoinspaces

set textwidth=100

set formatoptions+=t
set formatoptions-=o
set viminfo='1000,f1 " save marks on exit (only works for upper case or lower when buffer isn't cleared, :he 21.3 / E20)

set foldmethod=syntax
set foldlevelstart=0
" set foldlevel=20

if !&scrolloff
  set scrolloff=5 " Couple lines after bottom line / before top line with cursor
endif
if !&sidescrolloff
  set sidescrolloff=5 " Couple rows after/before cursor in line
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
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

Plugin 'Valloric/YouCompleteMe' " auto-completion
Plugin 'jeetsukumaran/vim-indentwise' " moving based on indent levels
" Plugin 'terryma/vim-multiple-cursors' " sublime text style mult cursors
" Plugin 'vim-airline/vim-airline' " bottom vim line
" Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/syntastic' " syntax checking
Plugin 'scrooloose/nerdcommenter' " commenting
Plugin 'nvie/vim-flake8' " style/syntax checking for python
Plugin 'hynek/vim-python-pep8-indent' " proper python indenting
Plugin 'vim-scripts/vim-auto-save' " saves when in normal
Plugin 'henrik/vim-indexed-search' " count search matches
Plugin 'evidanary/grepg.vim'
Plugin 'lervag/vimtex' " Latex stuff
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/vim-easy-align' " Aligning text
" Plugin 'easymotion/vim-easymotion' " moving quickly through file
Plugin 'tpope/vim-surround'
Plugin 'tmhedberg/SimpylFold'
Plugin 'gcmt/taboo.vim' " Name tabs in tabline
Plugin 'MattesGroeger/vim-bookmarks'
Plugin 'justinmk/vim-sneak'
Plugin 'airblade/vim-gitgutter'

" Testing area:
Plugin 'tommcdo/vim-exchange'
Plugin 'wellle/targets.vim'
Plugin 'majutsushi/tagbar'
Plugin 'Yggdroot/indentLine'
Plugin 'SirVer/ultisnips'
" Plugin 'xtal8/traces.vim'
Plugin 'Julian/vim-textobj-variable-segment' " not working??
Plugin 'kana/vim-textobj-user'


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
" ^  ^^  ^^^^^^^ ^^^^^ ^  ^^

" Use space as leader key
map <Space> <Leader>

" Replace word under cursor everywhere.
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
vnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>

nnoremap <Leader>l  f_l
vnoremap <Leader>l  f_l
onoremap <Leader>l  t_
onoremap i<Leader>l t_
onoremap a<Leader>l f_
nnoremap <Leader>h  hT_
vnoremap <Leader>h  hT_

" Go to letter at beginning (maybe end) of word
" nnoremap <Leader>f
" nnoremap <Leader>f

" replace word/visual selection under cursor, then . to replace other occurrences.
nnoremap <Leader>i *Ncgn
vnoremap <Leader>i "zy/<C-r>z<CR>Ncgn

" Paste from register holding most recent yank (instead of possibly last delete)
nnoremap <Leader>p "0p
nnoremap <Leader>P "0P
vnoremap <Leader>p "0p
vnoremap <Leader>P "0P

" System clipboard copy/paste
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y
nnoremap <Leader>v "+p
nnoremap <Leader>V "+P

" Delete line contents but don't delete the line
nnoremap <Leader>d 0D

" Duplicate line or selection.
nnoremap <silent> <Leader>m "9yyp
vnoremap <silent> <Leader>m "9y'>p

" nnoremap <Leader>c :e tools/uhyve-ibv.c>%

" Add 'todo' at the end of the line depending on filetype.
autocmd Filetype c,cpp nnoremap <silent> <Leader>t :normal A // TODO:<CR>A
autocmd Filetype python nnoremap <silent> <Leader>t :normal A # TODO:<CR>A
autocmd Filetype vimscript nnoremap <silent> <Leader>t :normal A " TODO:<CR>A

" Easy Motion movements
map <Leader>o <Plug>(easymotion-bd-W)

" Easily get to underscores within variable names
" nnoremap <Leader>w f_
" nnoremap <Leader>b F_
" vnoremap <Leader>w f_
" vnoremap <Leader>b F_

" <Space> s does last seach
nnoremap <Leader>s /<Up><Up><CR>
nnoremap <Leader>ss /<Up><Up><Up><CR>
nnoremap <Leader>sss /<Up><Up><Up><Up><CR>

" remove surrounding parens or if defines
nnoremap <Leader>a %x<C-o>x
nnoremap <Leader>A %"_dd<C-o>"_dd
" Insert spaces around a char
nnoremap <Leader>z i<Space><Esc>lli<Space><Esc>h

" Nerd Commenter - toggle comment.
map <Leader>c <plug>NERDComToggleComment

" Cool Macros

" TODO
" (f{lyi{o%{{{\label{jkpF{a:jkA}jkkkk(lvttyjjjf:PA%}}}jk

" -----------------------------------------------------------------------------
" REMAPS

" ESC remap
inoremap jk <Esc>
inoremap kj <Esc>

" Add numbered jumps to jumplist and use gk/gj to fix line wrap annoyance
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'gk'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'gj'

" jump up/down without adding motions to jumplist
nnoremap <silent> J :<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>
nnoremap <silent> K :<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>
vnoremap J }
vnoremap K {

nnoremap { }
vnoremap { }
vnoremap } {
nnoremap } {

" jump before word / after word
nnoremap H b
nnoremap L w
vnoremap H b
vnoremap L e

onoremap il iw
onoremap al aw
onoremap l w
onoremap h b

" w -> W
nnoremap w W
vnoremap w W
onoremap w W
onoremap iw aW
onoremap aw aW

" b -> B
nnoremap b B
vnoremap b B
onoremap b B

" e -> E -- maybe not nice?
" nnoremap e E
" vnoremap e E
" onoremap e E

" Top/middle/bottom of page
nnoremap { H
nnoremap } L
nnoremap + M

" More convenient folding
" nnoremap zc zC
nnoremap zo zO
nnoremap zr zR
nnoremap zm zM

" nnoremap zC zc
nnoremap zO zo
nnoremap zR zr
nnoremap zM zm

" Window switching
" nmap <silent> <C-Left>  :wincmd h<CR>
" nmap <silent> <C-Down>  :wincmd j<CR>
" nmap <silent> <C-Up>    :wincmd k<CR>
" nmap <silent> <C-Right> :wincmd l<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>
"
" Tab switching
nmap <silent> <Tab>     :tabp<CR>
nmap <silent> <CR>      :tabn<CR>
" nmap <silent> <C-Right> :tabn<CR>
" nmap <silent> <C-Left>  :tabp<CR>
"
" Window resizing
nmap <silent> <M-Right> :vertical resize +3<CR>
nmap <silent> <M-Left>  :vertical resize -3<CR>
nmap <silent> <M-Up>    :resize +3<CR>
nmap <silent> <M-Down>  :resize -3<CR>

" Insert line above or below
nnoremap <silent>- :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent>_ :set paste<CR>m`O<Esc>``:set nopaste<CR>
" Line wrap annoyance
" nnoremap j gj
" nnoremap k gk
" Y inconsistency (normally copies entire line as opposed to C and D)
nnoremap Y y$
" necessary remap
nnoremap Q J
" nnoremap Q gJ

" jump to beginning (soft) / end of line
nnoremap ( _
vnoremap ( _
nnoremap ) $
vnoremap ) $

" jump to matching bracket etc.
nnoremap 0 %
vnoremap 0 %

" Autoexpansion for curly braces
" inoremap {<CR> {<CR>}<Esc>O

" move lines/blocks down/up
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv
vnoremap <C-k> :m '<-2<CR>gv

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
" Statusline

set laststatus=2 " Always display status bar.

" Status Line:

" Status Function: {{{2
function! Status(winnum)
  let active = a:winnum == winnr()
  let bufnum = winbufnr(a:winnum)

  let stat = ''

  " this function just outputs the content colored by the
  " supplied colorgroup number, e.g. num = 2 -> User2
  " it only colors the input if the window is the currently
  " focused one

  function! Color(active, group, content)
    if a:active
      return '%#' . a:group . '#' . a:content . '%*'
    else
      return a:content
    endif
  endfunction

  " this handles alternative statuslines
  let usealt = 0

  let type = getbufvar(bufnum, '&buftype')
  let name = bufname(bufnum)

  let altstat = ''

  if type ==# 'help'
    let altstat .= '%#SLHelp# HELP %* ' . fnamemodify(name, ':t:r')
    let usealt = 1
  elseif name ==# '__Gundo__'
    let altstat .= ' Gundo'
    let usealt = 1
  elseif name ==# '__Gundo_Preview__'
    let altstat .= ' Gundo Preview'
    let usealt = 1
  endif

  if usealt
    return altstat
  endif

  " column
  " this might seem a bit complicated but all it amounts to is
  " a calculation to see how much padding should be used for the
  " column number, so that it lines up nicely with the line numbers

  " an expression is needed because expressions are evaluated within
  " the context of the window for which the statusline is being prepared
  " this is crucial because the line and virtcol functions otherwise
  " operate on the currently focused window

  function! Column()
    let vc = virtcol('.')
    let ruler_width = max([strlen(line('$')), (&numberwidth - 1)]) + &l:foldcolumn
    let column_width = strlen(vc)
    let padding = ruler_width - column_width
    let column = ''

    if padding <= 0
      let column .= vc
    else
      " + 1 because for some reason vim eats one of the spaces
      let column .= repeat(' ', padding + 1) . vc
    endif

    return column . ' '
  endfunction

  let stat .= '%#SLColumn#'
  let stat .= '%{Column()}'
  let stat .= '%*'

  if getwinvar(a:winnum, 'statusline_progress', 0)
    let stat .= Color(active, 'SLProgress', ' %p ')
  endif

  " file name
  " let stat .= Color(active, 'SLArrows', active ? ' »' : ' «')
  let stat .= ' %<'
  let stat .= '%f'
  " let stat .= ' ' . Color(active, 'SLArrows', active ? '«' : '»')

  " file modified
  let modified = getbufvar(bufnum, '&modified')
  let stat .= Color(active, 'SLLineNr', modified ? ' +++' : '')

  " read only
  let readonly = getbufvar(bufnum, '&readonly')
  let stat .= Color(active, 'SLLineNR', readonly ? ' ---' : '')

  " let stat .= \ %p%%
  " let stat .= \ %l:%c

  return stat

endfunction
" }}}

" Status AutoCMD: {{{
function! s:ToggleStatusProgress()
  if !exists('w:statusline_progress')
    let w:statusline_progress = 0
  endif

  let w:statusline_progress = !w:statusline_progress
endfunction

command! ToggleStatusProgress :call s:ToggleStatusProgress()

nnoremap <silent> ,p :ToggleStatusProgress<CR>

function! s:IsDiff()
  let result = 0

  for nr in range(1, winnr('$'))
    let result = result || getwinvar(nr, '&diff')

    if result
      return result
    endif
  endfor

  return result
endfunction

function! s:RefreshStatus()
  for nr in range(1, winnr('$'))
    call setwinvar(nr, '&statusline', '%!Status(' . nr . ')')
  endfor
endfunction

command! RefreshStatus :call <SID>RefreshStatus()

augroup status
  autocmd!
  autocmd VimEnter,VimLeave,WinEnter,WinLeave,BufWinEnter,BufWinLeave * :RefreshStatus
augroup END
" }}}

" }}}

" function! StatuslineGit()
  " let l:branchname = GitBranch()
  " return strlen(l:branchname) > 0?' '.l:branchname.' ':''
" endfunction

" set statusline=
" set statusline+=%{StatuslineGit()}



" -----------------------------------------------------------------------------
" PLUGINS

" Syntastic
let g:loaded_syntastic_java_javac_checker = 1

" Indent Wise
map [[ <Plug>(IndentWisePreviousLesserIndent)
map ]] <Plug>(IndentWiseNextLesserIndent)
"map [= <Plug>(IndentWisePreviousEqualIndent)
"map ]= <Plug>(IndentWiseNextEqualIndent)

" Airline
" let g:airline_theme='light'
" let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'

" You Complete Me
" let g:loaded_youcompleteme = 1 " while testing completor
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_global_ycm_extra_conf = '$USER/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_filetype_blacklist = {
      \ 'tex' : 1,
      \ 'tagbar' : 1,
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ 'unite' : 1,
      \ 'text' : 1,
      \ 'vimwiki' : 1,
      \ 'pandoc' : 1,
      \ 'infolog' : 1,
      \ 'mail' : 1
      \}

" Completor
" let g:completor_python_binary = '/usr/lib/python3.5'
" let g:completor_clang_binary = '/usr/bin/clang'
" let g:completor_completion_delay = 20

" imap <Tab> <C-n>
" imap <S-Tab> <C-p>

" fzf
nmap <C-f> :Files<CR>
nmap <C-t> :Tags<CR>
nmap <C-b> :Buffers<CR>

" Easy Align
vmap ga <Plug>(EasyAlign)

" Vim Sneak
nmap <Leader>j <Plug>Sneak_s
nmap <Leader>k <Plug>Sneak_S
xmap <Leader>j <Plug>Sneak_s
xmap <Leader>k <Plug>Sneak_S

" nmap s <Plug>Sneak_s
" nmap S <Plug>Sneak_S
" xmap s <Plug>Sneak_s
" xmap S <Plug>Sneak_S

" Replace one char f/t searching with one char sneak
" map f <Plug>Sneak_f
" map F <Plug>Sneak_F
" map t <Plug>Sneak_t
" map T <Plug>Sneak_T

let g:sneak#streak = 1
let g:sneak#target_labels = "asftjkuqm(){}<>/SFTUNRMQZ?0"

" Autosave
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1
let g:auto_save_events = ["CursorHold"]

" NERDCommenter
let NERDSpaceDelims=1

" Gitgutter
let g:gitgutter_eager=0

" Tagbar
nmap <F7> :TagbarToggle<CR>

" SimpylFold
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_import = 0


" IndentLine
" let g:indentLine_color_term = 239
" let g:indentLine_char = '⎸'
" set list
" set listchars=tab:>-

" Vim Exchange
nmap ß  <Plug>(Exchange)
xmap ß  <Plug>(Exchange)
nmap ßß <Plug>(ExchangeLine)
nmap ßx <Plug>(ExchangeClear)

" UltiSnips
let g:UltiSnipsSnippetsDir         = '~/.vim/ultisnips'
let g:UltiSnipsSnippetDirectories  = [$HOME.'/.vim/ultisnips']

let g:UltiSnipsExpandTrigger       = '<C-n>'
let g:UltiSnipsJumpForwardTrigger  = '<C-n>'
let g:UltiSnipsJumpBackwardTrigger = '<C-b>'

let g:UltiSnipsEditSplit           = "vertical"

" VimTex
let g:tex_conceal = "" " Dont hide $ and 'prettify' subscripts etc.

" MiniSnip

" let g:minisnip_trigger = '<C-m>'

" -----------------------------------------------------------------------------
" DEPRECATION AREA

"source /usr/share/vim/google/google.vim
"Glug g4

" Quick buffer switching
":nnoremap <F3> :buffers<CR>:buffer<Space>

"nmap <PageUp> :tabp<CR>
"nmap <PageDown> :tabn<CR>

set relativenumber
" set iskeyword-=_
