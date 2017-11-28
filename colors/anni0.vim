" Vim color file - anni0

set background=dark
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

set t_Co=256
let g:colors_name = "anni0"

hi Normal         ctermfg=251  ctermbg=234  cterm=NONE

hi Search         ctermfg=233  ctermbg=172  cterm=NONE
hi IncSearch      ctermfg=233  ctermbg=172  cterm=NONE

hi Comment        ctermfg=106  ctermbg=NONE cterm=italic
hi SpecialComment ctermfg=106  ctermbg=NONE cterm=italic

hi String         ctermfg=242  ctermbg=NONE cterm=NONE

hi Type           ctermfg=231  ctermbg=NONE cterm=bold
hi Structure      ctermfg=231  ctermbg=NONE cterm=bold
hi Statement      ctermfg=231  ctermbg=NONE cterm=bold
hi Typedef        ctermfg=231  ctermbg=NONE cterm=bold
hi StorageClass   ctermfg=231  ctermbg=NONE cterm=bold
hi Conditional    ctermfg=231  ctermbg=NONE cterm=bold
hi Repeat         ctermfg=231  ctermbg=NONE cterm=bold
hi Operator       ctermfg=231  ctermbg=NONE cterm=bold
hi Keyword        ctermfg=231  ctermbg=NONE cterm=bold
hi Label          ctermfg=231  ctermbg=NONE cterm=bold
hi Identifier     ctermfg=NONE ctermbg=NONE cterm=NONE

hi PreProc        ctermfg=110   ctermbg=NONE cterm=NONE
hi Include        ctermfg=110   ctermbg=NONE cterm=NONE
hi Define         ctermfg=110   ctermbg=NONE cterm=NONE

hi Macro          ctermfg=172  ctermbg=NONE cterm=NONE
hi PreCondit      ctermfg=172  ctermbg=NONE cterm=bold

hi SpecialChar    ctermfg=172  ctermbg=NONE cterm=NONE
hi Special        ctermfg=172  ctermbg=NONE cterm=NONE
hi Tag            ctermfg=110   ctermbg=NONE cterm=NONE
hi Delimiter      ctermfg=172  ctermbg=NONE cterm=NONE
hi Exception      ctermfg=110   ctermbg=NONE cterm=NONE

hi ColorColumn    ctermfg=NONE ctermbg=235  cterm=NONE
hi CursorLine     ctermfg=NONE ctermbg=235  cterm=NONE
hi Cursor         ctermfg=235  ctermbg=15   cterm=NONE

hi LineNr         ctermfg=243  ctermbg=NONE cterm=NONE
hi CursorLineNr   ctermfg=106  ctermbg=NONE cterm=bold

hi PMenu          ctermfg=251  ctermbg=238  cterm=NONE
hi PMenuSel       ctermfg=234  ctermbg=106  cterm=NONE
hi PMenuSbar      ctermfg=NONE ctermbg=102  cterm=NONE
hi PMenuThumb     ctermfg=NONE ctermbg=248  cterm=NONE

hi TabLine        ctermfg=15   ctermbg=236  cterm=bold
hi TabLineSel     ctermfg=235  ctermbg=106  cterm=bold
hi TabLineFill    ctermfg=15   ctermbg=236  cterm=bold

hi VertSplit      ctermfg=250  ctermbg=250  cterm=bold
hi StatusLineNC   ctermfg=235  ctermbg=231  cterm=bold
hi StatusLine     ctermfg=235  ctermbg=231  cterm=bold

hi Folded         ctermfg=110  ctermbg=NONE  cterm=bold
hi FoldColumn     ctermfg=235  ctermbg=248  cterm=NONE

hi Visual         ctermfg=NONE ctermbg=239  cterm=NONE

hi Todo           ctermfg=234  ctermbg=250  cterm=NONE

hi Number         ctermfg=172  ctermbg=NONE cterm=NONE
hi Constant       ctermfg=172  ctermbg=NONE cterm=NONE
hi Character      ctermfg=172  ctermbg=NONE cterm=NONE
hi Float          ctermfg=172  ctermbg=NONE cterm=NONE
hi Boolean        ctermfg=172  ctermbg=NONE cterm=NONE
hi Function       ctermfg=172  ctermbg=NONE cterm=bold

hi MatchParen     ctermfg=233  ctermbg=172  cterm=bold

hi WildMenu       ctermfg=NONE ctermbg=248  cterm=NONE
hi SignColumn     ctermfg=235  ctermbg=60   cterm=NONE
hi Title          ctermfg=189  ctermbg=235  cterm=bold
hi NonText        ctermfg=243  ctermbg=NONE cterm=NONE
hi DiffText       ctermfg=NONE ctermbg=52   cterm=NONE
hi ErrorMsg       ctermfg=248  ctermbg=88   cterm=NONE
hi Debug          ctermfg=1    ctermbg=NONE cterm=NONE
hi SpellRare      ctermfg=189  ctermbg=235  cterm=underline
hi WarningMsg     ctermfg=248  ctermbg=88   cterm=NONE
hi VisualNOS      ctermfg=235  ctermbg=189  cterm=underline
hi DiffDelete     ctermfg=NONE ctermbg=235  cterm=NONE
hi ModeMsg        ctermfg=15   ctermbg=235  cterm=bold
hi MoreMsg        ctermfg=1    ctermbg=NONE cterm=bold
hi SpellCap       ctermfg=189  ctermbg=235  cterm=underline
hi DiffChange     ctermfg=NONE ctermbg=52   cterm=NONE
hi SpellLocal     ctermfg=189  ctermbg=235  cterm=underline
hi Error          ctermfg=248  ctermbg=88   cterm=NONE
hi SpecialKey     ctermfg=66   ctermbg=NONE cterm=NONE
hi SpellBad       ctermfg=189  ctermbg=235  cterm=underline
hi Directory      ctermfg=60   ctermbg=NONE cterm=bold
hi Underlined     ctermfg=189  ctermbg=235  cterm=underline
hi DiffAdd        ctermfg=NONE ctermbg=236  cterm=NONE
hi cursorim       ctermfg=235  ctermbg=60   cterm=NONE

"hi CTagsMember -- no settings --
"hi CTagsGlobalConstant -- no settings --
"hi Ignore -- no settings --
"hi CTagsImport -- no settings --
"hi CTagsGlobalVariable -- no settings --
"hi EnumerationValue -- no settings --
"hi Union -- no settings --
"hi Question -- no settings --
"hi E74 -- no settings --
"hi DefinedName -- no settings --
"hi LocalVariable -- no settings --
"hi CTagsClass -- no settings --
"hi clear -- no settings --

