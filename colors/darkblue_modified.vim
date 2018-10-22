" Vim color file - darkblue_modified
" Generated by http://bytefluent.com/vivify 2018-10-17
set background=dark
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

set t_Co=256
let g:colors_name = "darkblue_modified"

"hi SignColumn -- no settings --
"hi CTagsMember -- no settings --
"hi CTagsGlobalConstant -- no settings --
hi Normal guifg=#a7a7a7 guibg=#000020 guisp=#000020 gui=NONE ctermfg=248 ctermbg=17 cterm=NONE
"hi CTagsImport -- no settings --
"hi CTagsGlobalVariable -- no settings --
"hi SpellRare -- no settings --
"hi EnumerationValue -- no settings --
"hi TabLineSel -- no settings --
"hi Union -- no settings --
"hi TabLineFill -- no settings --
"hi EnumerationName -- no settings --
"hi SpellCap -- no settings --
"hi SpellLocal -- no settings --
"hi Error -- no settings --
"hi DefinedName -- no settings --
"hi MatchParen -- no settings --
"hi LocalVariable -- no settings --
"hi SpellBad -- no settings --
"hi CTagsClass -- no settings --
"hi TabLine -- no settings --
"hi clear -- no settings --
hi IncSearch guifg=#9fe6e6 guibg=#2050d0 guisp=#2050d0 gui=NONE ctermfg=116 ctermbg=26 cterm=NONE
hi WildMenu guifg=#e6e600 guibg=#000000 guisp=#000000 gui=NONE ctermfg=184 ctermbg=NONE cterm=NONE
hi SpecialComment guifg=#e69600 guibg=NONE guisp=NONE gui=NONE ctermfg=172 ctermbg=NONE cterm=NONE
hi Typedef guifg=#57e657 guibg=NONE guisp=NONE gui=NONE ctermfg=77 ctermbg=NONE cterm=NONE
hi Title guifg=#e600e6 guibg=NONE guisp=NONE gui=bold ctermfg=164 ctermbg=NONE cterm=bold
hi Folded guifg=#676767 guibg=#000040 guisp=#000040 gui=bold ctermfg=241 ctermbg=17 cterm=bold
hi PreCondit guifg=#e673e6 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Include guifg=#e673e6 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Float guifg=#e69090 guibg=NONE guisp=NONE gui=NONE ctermfg=174 ctermbg=NONE cterm=NONE
hi StatusLineNC guifg=#000000 guibg=#a9a9a9 guisp=#a9a9a9 gui=NONE ctermfg=NONE ctermbg=248 cterm=NONE
hi NonText guifg=#002ae6 guibg=NONE guisp=NONE gui=NONE ctermfg=20 ctermbg=NONE cterm=NONE
hi DiffText guifg=NONE guibg=#ff0000 guisp=#ff0000 gui=bold ctermfg=NONE ctermbg=196 cterm=bold
hi ErrorMsg guifg=#e6e6e6 guibg=#287eff guisp=#287eff gui=NONE ctermfg=254 ctermbg=27 cterm=NONE
hi Ignore guifg=#000027 guibg=NONE guisp=NONE gui=NONE ctermfg=17 ctermbg=NONE cterm=NONE
hi Debug guifg=#e69600 guibg=NONE guisp=NONE gui=NONE ctermfg=172 ctermbg=NONE cterm=NONE
hi PMenuSbar guifg=#0000e6 guibg=#a9a9a9 guisp=#a9a9a9 gui=NONE ctermfg=20 ctermbg=248 cterm=NONE
hi Identifier guifg=#3ae6e6 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi SpecialChar guifg=#e69600 guibg=NONE guisp=NONE gui=NONE ctermfg=172 ctermbg=NONE cterm=NONE
hi Conditional guifg=#57e657 guibg=NONE guisp=NONE gui=NONE ctermfg=77 ctermbg=NONE cterm=NONE
hi StorageClass guifg=#57e657 guibg=NONE guisp=NONE gui=NONE ctermfg=77 ctermbg=NONE cterm=NONE
hi Todo guifg=#b84111 guibg=#1248d1 guisp=#1248d1 gui=NONE ctermfg=1 ctermbg=26 cterm=NONE
hi Special guifg=#e69600 guibg=NONE guisp=NONE gui=NONE ctermfg=172 ctermbg=NONE cterm=NONE
hi LineNr guifg=#7fd61d guibg=NONE guisp=NONE gui=NONE ctermfg=76 ctermbg=NONE cterm=NONE
hi StatusLine guifg=#6e715f guibg=#000000 guisp=#000000 gui=NONE ctermfg=101 ctermbg=NONE cterm=NONE
hi Label guifg=#57e657 guibg=NONE guisp=NONE gui=NONE ctermfg=77 ctermbg=NONE cterm=NONE
hi PMenuSel guifg=#a7a7a7 guibg=#2050d0 guisp=#2050d0 gui=NONE ctermfg=248 ctermbg=26 cterm=NONE
hi Search guifg=#82e6d9 guibg=#2050d0 guisp=#2050d0 gui=underline ctermfg=116 ctermbg=26 cterm=underline
hi Delimiter guifg=#e69600 guibg=NONE guisp=NONE gui=NONE ctermfg=172 ctermbg=NONE cterm=NONE
hi Statement guifg=#e6e657 guibg=NONE guisp=NONE gui=NONE ctermfg=185 ctermbg=NONE cterm=NONE
hi Comment guifg=#7390e6 guibg=NONE guisp=NONE gui=NONE ctermfg=68 ctermbg=NONE cterm=NONE
hi Character guifg=#e69090 guibg=NONE guisp=NONE gui=NONE ctermfg=174 ctermbg=NONE cterm=NONE
hi Number guifg=#e69090 guibg=NONE guisp=NONE gui=NONE ctermfg=174 ctermbg=NONE cterm=NONE
hi Boolean guifg=#e6e657 guibg=NONE guisp=NONE gui=NONE ctermfg=185 ctermbg=NONE cterm=NONE
hi Operator guifg=#57e657 guibg=NONE guisp=NONE gui=NONE ctermfg=77 ctermbg=NONE cterm=NONE
hi CursorLine guifg=NONE guibg=#101040 guisp=#101040 gui=NONE ctermfg=NONE ctermbg=17 cterm=NONE
hi Question guifg=#00e600 guibg=NONE guisp=NONE gui=NONE ctermfg=40 ctermbg=NONE cterm=NONE
hi WarningMsg guifg=#e60000 guibg=NONE guisp=NONE gui=NONE ctermfg=160 ctermbg=NONE cterm=NONE
hi VisualNOS guifg=#7373e6 guibg=#c0c0c0 guisp=#c0c0c0 gui=underline ctermfg=62 ctermbg=7 cterm=underline
hi DiffDelete guifg=#0000e6 guibg=#008b8b guisp=#008b8b gui=bold ctermfg=20 ctermbg=30 cterm=bold
hi ModeMsg guifg=#1eb5c9 guibg=NONE guisp=NONE gui=NONE ctermfg=38 ctermbg=NONE cterm=NONE
hi CursorColumn guifg=NONE guibg=#101040 guisp=#101040 gui=NONE ctermfg=NONE ctermbg=17 cterm=NONE
hi Define guifg=#e673e6 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Function guifg=#3ae6e6 guibg=NONE guisp=NONE gui=NONE ctermfg=80 ctermbg=NONE cterm=NONE
hi FoldColumn guifg=#676767 guibg=#000040 guisp=#000040 gui=bold ctermfg=241 ctermbg=17 cterm=bold
hi PreProc guifg=#e673e6 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Visual guifg=#7373e6 guibg=#c0c0c0 guisp=#c0c0c0 gui=NONE ctermfg=62 ctermbg=7 cterm=NONE
hi MoreMsg guifg=#004b00 guibg=NONE guisp=NONE gui=NONE ctermfg=22 ctermbg=NONE cterm=NONE
hi VertSplit guifg=#343434 guibg=#303030 guisp=#303030 gui=NONE ctermfg=236 ctermbg=236 cterm=NONE
hi Exception guifg=#57e657 guibg=NONE guisp=NONE gui=NONE ctermfg=77 ctermbg=NONE cterm=NONE
hi Keyword guifg=#57e657 guibg=NONE guisp=NONE gui=NONE ctermfg=77 ctermbg=NONE cterm=NONE
hi Type guifg=#57e657 guibg=NONE guisp=NONE gui=NONE ctermfg=77 ctermbg=NONE cterm=NONE
hi DiffChange guifg=NONE guibg=#8b008b guisp=#8b008b gui=NONE ctermfg=NONE ctermbg=90 cterm=NONE
hi Cursor guifg=#000000 guibg=#ffff00 guisp=#ffff00 gui=NONE ctermfg=NONE ctermbg=11 cterm=NONE
hi PMenu guifg=#a7a7a7 guibg=#404080 guisp=#404080 gui=NONE ctermfg=248 ctermbg=60 cterm=NONE
hi SpecialKey guifg=#00e6e6 guibg=NONE guisp=NONE gui=NONE ctermfg=44 ctermbg=NONE cterm=NONE
hi Constant guifg=#e69090 guibg=NONE guisp=NONE gui=NONE ctermfg=174 ctermbg=NONE cterm=NONE
hi Tag guifg=#e69600 guibg=NONE guisp=NONE gui=NONE ctermfg=172 ctermbg=NONE cterm=NONE
hi String guifg=#e69090 guibg=NONE guisp=NONE gui=NONE ctermfg=174 ctermbg=NONE cterm=NONE
hi PMenuThumb guifg=#a7a7a7 guibg=NONE guisp=NONE gui=NONE ctermfg=248 ctermbg=NONE cterm=NONE
hi Repeat guifg=#57e657 guibg=NONE guisp=NONE gui=NONE ctermfg=77 ctermbg=NONE cterm=NONE
hi Directory guifg=#00e6e6 guibg=NONE guisp=NONE gui=NONE ctermfg=44 ctermbg=NONE cterm=NONE
hi Structure guifg=#57e657 guibg=NONE guisp=NONE gui=NONE ctermfg=77 ctermbg=NONE cterm=NONE
hi Macro guifg=#e673e6 guibg=NONE guisp=NONE gui=NONE ctermfg=170 ctermbg=NONE cterm=NONE
hi Underlined guifg=NONE guibg=NONE guisp=NONE gui=underline ctermfg=NONE ctermbg=NONE cterm=underline
hi DiffAdd guifg=NONE guibg=#00008b guisp=#00008b gui=NONE ctermfg=NONE ctermbg=18 cterm=NONE
hi lcursor guifg=#000000 guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=NONE ctermbg=15 cterm=NONE
