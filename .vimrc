filetype plugin indent on
set nocompatible



" -----------------------------------------------------------------------------
" PLATFORM DETECTION

let g:UNIX = has('unix') && !has('macunix') && !has('win32unix')
let g:GOOGLE = g:UNIX && filereadable('/usr/share/vim/google/google.vim')



" -----------------------------------------------------------------------------
" GOOGLE PLUGINS / SETTINGS

if g:GOOGLE
  source /usr/share/vim/google/google.vim

  " YCM support.
  Glug youcompleteme-google

  " UltiSnips Google specific TODO
  " Glug ultisnips-google

  " Find associated BUILD targets and update deps.
  Glug blazedeps
  nnoremap <Leader>b :BlazeDepsUpdate<CR>

  " Run blaze build/test etc. from within vim. TODO
  Glug blaze plugin[mappings]='<Leader>q'

  " Outline window for current file. Enter on a line to jump to location.
  Glug outline-window
  nnoremap <Leader>g :GoogleOutlineWindow<CR>

  " Leader f for Window -> Press h/c to open header/source.
  nnoremap <Leader>f :RelatedFilesWindow<CR>

  " Syntastic
  Glug syntastic-google checkers=`{'python': ['gpylint'], 'proto': ['glint'], 'cpp': ['cpplint']}`

  " Run :FormatCode. Alternatively, run :FormatLines on selection.
  Glug codefmt
  Glug codefmt-google
  vnoremap $ :FormatLines<CR>
end



" -----------------------------------------------------------------------------
" PLUGINS

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdcommenter'
Plugin 'henrik/vim-indexed-search' " Count search matches
Plugin 'gcmt/taboo.vim' " Name tabs in tabline
Plugin 'justinmk/vim-sneak'
Plugin 'tommcdo/vim-exchange' " Switch out two selections
Plugin 'bkad/CamelCaseMotion' " Move around camel case or underscore text objects
Plugin 'wellle/targets.vim' " Add some text objects: din) dal) da, daa
Plugin 'mhinz/vim-signify' " Indicate changes in gutter TODO
Plugin 'xtal8/traces.vim' " Previews ranges and patterns for ex commands live.
Plugin 'Julian/vim-textobj-variable-segment' " v textobject for _ and CamelCase
Plugin 'kana/vim-textobj-user' " (required)
Plugin 'vim-scripts/vim-auto-save'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/vim-easy-align'      " Aligning text
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'

" Testing area:
" Plugin 'SirVer/ultisnips'                    " TODO

if !g:GOOGLE
  Plugin 'scrooloose/syntastic'         " syntax checking
  Plugin 'Valloric/YouCompleteMe'
  " Plugin 'lervag/vimtex'
end

" Deprecated for now:

" Plugin 'vim-scripts/SearchHighlighting'
" Plugin 'airblade/vim-gitgutter'
" Plugin 'Rip-Rip/clang_complete'

call vundle#end()

filetype on



" -----------------------------------------------------------------------------
" VISUALS

if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

colorscheme inbetween
set cursorline
set colorcolumn=+1
" source ~/.vim/statusline.vim


" Cursor color: Green4 in insert, DodgerBlue3 in normal, reset when exiting vim.
if &term =~ "xterm\\|rxvt"
  let &t_SI = "\<Esc>]12;Green4\x7"
  let &t_EI = "\<Esc>]12;DodgerBlue3\x7"
  silent !echo -ne "\033]12;DodgerBlue3\007"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]112\007"
endif



" -----------------------------------------------------------------------------
" GENERAL SETTINGS MAKING LIFE EASIER

" Use space as Leader key
map <Space> <Leader>

" Indenting
set autoindent
set tabstop=2                  " on pressing TAB
set shiftwidth=2               " Shifting Text left or right using < and >
set softtabstop=2
set expandtab                  " On pressing tab, insert X spaces
set backspace=indent,eol,start " Backspace behaviour

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

set updatetime=1250 " Swap file or saving file.
set timeoutlen=300  " Timeout for key presses, e.g. jk

set number
set relativenumber
set noswapfile
set nowrap
set matchpairs+=<:>
set display+=lastline
set wildmenu
set sessionoptions=tabpages,winsize,buffers,globals
set nojoinspaces
set nrformats-=octal " Don't increment octal, only hex and dec.

set formatoptions+=j " Delete comment character when joining commented lines
set formatoptions+=t
set formatoptions-=o
set viminfo='1000,f1 " save marks on exit (only works for upper case or lower when buffer isn't cleared, :he 21.3 / E20)
set completeopt-=preview " Don't show a preview window for completions at the top of the page. todo: does this cause lag?

set foldmethod=indent " Note to self: foldmethod 'syntax' causes significant input lag in insert mode for larger files. DO NOT USE.
set foldlevelstart=99
" set foldlevel=20

set textwidth=80
set synmaxcol=200    " improve performance by only applying syntax highlighting to 200 chars per line

" Show a few lines before/after top/bottom line and left/right column.
if !&scrolloff
  set scrolloff=4
endif
if !&sidescrolloff
  set sidescrolloff=4
endif

" Fix ALT key binding problems
for i in range(97,122)
  let c = nr2char(i)
  exec "map \e".c." <M-".c.">"
  exec "map! \e".c." <M-".c.">"
endfor



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

" jump before word / after word
nnoremap H b
nnoremap L w
vnoremap H b
vnoremap L e

" Adapt text objects for h and l.
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
" nnoremap { H
" nnoremap } L
nnoremap + M

nnoremap # O// TODO(wierichs):
" vmap <Leader>c :s/_\([a-z]\)/\u\1/g
" nnoremap <Leader>c vL<Leader>c


" More convenient folding
" nnoremap zc zC
" nnoremap zo zO
" nnoremap zr zR
" nnoremap zm zM

" nnoremap zC zc
" nnoremap zO zo
" nnoremap zR zr
" nnoremap zM zm

" Window switching using CTRL + h/l
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

" Tab switching using TAB and ENTER.
nmap <silent> <Tab>     :tabp<CR>
nmap <silent> <CR>      :tabn<CR>

" Window resizing using ALT + Arrow keys.
nmap <silent> <M-Right> :vertical resize +3<CR>
nmap <silent> <M-Left>  :vertical resize -3<CR>
nmap <silent> <M-Up>    :resize +3<CR>
nmap <silent> <M-Down>  :resize -3<CR>

" Insert newline above/below staying on current line.
nnoremap ( O<Esc>j
nnoremap ) o<Esc>k

" Y inconsistency (normally copies entire line as opposed to C and D)
nnoremap Y y$
" necessary remap since J is remapped.
nnoremap Q J

" jump to beginning (soft) / end of line
nnoremap * _
vnoremap * _
nnoremap - $
vnoremap - $

" Search for word under cursor but don't move to next occurrence.
nnoremap <silent> _ :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<C-M>

" jump to matching bracket etc.
" nnoremap 0 %
" vnoremap 0 %

" Autoexpansion for curly braces
"inoremap {{ {<CR>}<C-o>O
"inoremap (( ()<Left>
"inoremap [[ []<Left>
"inoremap "" ""<Left>
"inoremap '' ''<Left>
"inoremap <> <lt>><Left>

" move lines/blocks down/up
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
vnoremap <C-j> :m '>+1<CR>gv
vnoremap <C-k> :m '<-2<CR>gv

" Jump forward in jump list (next location)
nnoremap { <C-o>
nnoremap } <C-i>

" Search for selected text using _, n/N for forwards or backwards.
vnoremap <silent> _ :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Use <C-G> to clear the highlighting of :set hlsearch.
nnoremap <silent> <C-G> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-G>

" Sort lines by occurrence, remove duplicated, add count in front.
" nnoremap <silent> <C-P> :%! sort | uniq -c | sort -nr

" C++ string formatting
nmap <silent> <Leader>q Qh3x

" F5 opens vimrc
:map <F5> :tabedit $HOME/.vimrc<CR>
" F6 reloads vimrc
:map <F6> :so $MYVIMRC<CR>
" F7 reloads all tabs and all windows
:map <F7> :tabdo windo e<CR>


" -----------------------------------
" REMAPS FOR PLUGINS

" Name current tab.
nnoremap <Leader>n :TabooRename<space>

" Signify
" nmap <M-Down> <plug>(signify-next-hunk)
" nmap <M-Up>   <plug>(signify-prev-hunk)
nmap ]] <plug>(signify-next-hunk)
nmap [[ <plug>(signify-prev-hunk)

" CamelCaseMotion
" (i/a bindings provided by v text object plugin)
map <silent> <Leader>l <Plug>CamelCaseMotion_w
map <silent> <Leader>h <Plug>CamelCaseMotion_b
map <silent> <Leader>e <Plug>CamelCaseMotion_e

" Vim Exchange
nmap ß  <Plug>(Exchange)
xmap ß  <Plug>(Exchange)
nmap ßß <Plug>(ExchangeLine)
nmap ßx <Plug>(ExchangeClear)

" fzf
let $FZF_DEFAULT_COMMAND =
      \ 'rg --files
      \ ./ccc/abuse/decision/
      \ ./configs/monitoring/identity_monitoring/monarch/alerts/
      \ ./configs/production/canary_analysis/identity_cas/
      \ ./configs/production/conductor/identity/
      \ ./configs/production/rollout/legislator/identity/
      \ ./experimental/users/wierichs/
      \ ./gaia/backend/
      \ ./gaia/bouncer/
      \ ./gaia/dreamcatcher/
      \ ./gaia/permission/
      \ ./gaia/signintrace/
      \ ./monitoring/viceroy/dashboards/hijacking/
      \ ./permission/
      \ ./production/borg/gaia-permission/
      \ ./production/borg/identity-authentication-risk/
      \ ./production/borg/identity_crons/crons/
      \ ./production/pod/realms/identity/projects/authentication-risk
      \ '
nmap <C-f> :Files<CR>
nmap <C-t> :Tags<CR>

" Easy Align
vmap ga <Plug>(EasyAlign)

if !g:GOOGLE
  nmap <C-b> :Buffers<CR>
end

" Vim Sneak
nmap <Leader>j <Plug>Sneak_s
nmap <Leader>k <Plug>Sneak_S
xmap <Leader>j <Plug>Sneak_s
xmap <Leader>k <Plug>Sneak_S

" Go to definition
nmap <silent> <Leader>o :YcmCompleter GoToDefinition<CR>

" Perform most recent search.
nnoremap <Leader>s /<Up><Up><CR>
nnoremap <Leader>ss /<Up><Up><Up><CR>

" Nerd Commenter - toggle comment.
"map <Leader>c <plug>NERDComToggleComment

" UltiSnips
"let g:UltiSnipsExpandTrigger       = '<C-l>'
"let g:UltiSnipsJumpForwardTrigger  = '<C-l>'
"let g:UltiSnipsJumpBackwardTrigger = '<C-b>'

" IndentWise
"map [[ <Plug>(IndentWisePreviousLesserIndent)
"map ]] <Plug>(IndentWiseNextLesserIndent)



" -----------------------------------------------------------------------------
" LEADER BINDINGS

" abcdefghijklmnopqrstuvwxyz
" ^  ^ ^ ^^^^^^^ ^ ^^^    ^^

" Keyboard
" !@#$€`{}_+
" ~\"' *()-=
" `&[]^|<>%/

" FREE
" €`\`^|0
" What about & ??

" replace word/visual selection under cursor, then . to replace other occurrences.
nnoremap <Leader>i *Ncgn
vnoremap <Leader>i "zy/<C-r>z<CR>Ncgn

" System clipboard copy
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y

nnoremap <Leader>t 
" Paste from register holding most recent yank (instead of possibly last delete)
nnoremap <Leader>p "0p
nnoremap <Leader>P "0P
vnoremap <Leader>p "0p
vnoremap <Leader>P "0P

" Delete line contents but don't delete the line
nnoremap <Leader>d 0D

" Duplicate line or selection.
nnoremap <silent> <Leader>m "9yyp
vnoremap <silent> <Leader>m "9y'>p

" remove surrounding parens
nnoremap <Leader>a %x<C-o>x

" Replace word under cursor or visual selection with text to-be-entered
" everywhere in file.
source ~/.vim/replace_visual.vim
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
vnoremap <Leader>r <Esc>:%s/<c-r>=GetVisual()<cr>//g<left><left>

" Remove trailing whitespaces.
nnoremap € :%s/\s\+$//e<CR>


" -----------------------------------------------------------------------------
" MACROS

" Format ABSL flag.
let @f='<Leader>kABv j);l:s/"\_s\+"//g<80>kb^MV kAB:s/(\_s\+//<80>kl(<80>kr^MQV$'

" -----------------------------------------------------------------------------
" PLUGIN SETTINGS

" YouCompleteMe
let g:ycm_filetype_blacklist = {
      \ 'tex' : 1,
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
" let g:loaded_youcompleteme = 1 " turn off YCM
" let g:ycm_global_ycm_extra_conf = '.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" let g:ycm_add_preview_to_completeopt = 0

" Vim Sneak
let g:sneak#streak = 1
let g:sneak#target_labels = ";asftjknuqm(){}<>/SFLTUNRMQZ?0"

" Autosave
let g:auto_save = 1 " Enable Plugin
let g:auto_save_in_insert_mode = 0
let g:auto_save_no_updatetime = 1 " Don't redefine the updatetime to 200.
let g:auto_save_silent = 1
" let g:auto_save_events = ["CursorHold"]

" NERDCommenter
let NERDSpaceDelims=1

" Signify
let g:signify_vcs_list              = [ 'hg' ]
let g:signify_skip_filename_pattern = ['\.pipertmp.*'] " Google specific.
let g:signify_vcs_cmds = {
  \ 'hg': 'hg diff --config extensions.color=! -r "clroots(.)^" --config defaults.diff= --nodates -U0 -- %f',
  \ }
let g:signify_vcs_cmds_diffmode = {
  \ 'hg': 'hg cat -r "clroots(.)^" %f',
  \ }
" let g:signify_vcs_list              = [ 'hg', 'git', 'perforce' ] " Complains.


" UltiSnips
"let g:UltiSnipsSnippetsDir         = '~/.vim/ultisnips'
"let g:UltiSnipsSnippetDirectories  = [$HOME.'/.vim/ultisnips']
"let g:UltiSnipsEditSplit           = "vertical"
