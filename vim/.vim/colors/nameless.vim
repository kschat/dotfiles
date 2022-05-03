" Syntax highlighting scheme is a heavily modified verson of the base-16 scheme
" https://github.com/chriskempson/base16-vim

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "nameless"

let s:black = "00"
let s:b_black = "08"

let s:red = "01"
let s:b_red = "09"

let s:green = "02"
let s:b_green = "10"

let s:yellow = "03"
let s:b_yellow = "11"

let s:blue = "04"
let s:b_blue = "12"

let s:magenta = "05"
let s:b_magenta = "13"

let s:cyan = "06"
let s:b_cyan = "14"

let s:white = "07"
let s:b_white = "15"

" Highlighting function
fun <sid>hi(group, ctermfg, ctermbg, attr)
  if a:ctermfg != ""
    exec "hi " . a:group . " ctermfg=" . a:ctermfg
  endif
  if a:ctermbg != ""
    exec "hi " . a:group . " ctermbg=" . a:ctermbg
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  endif
endfun

" Vim editor colors
call <sid>hi("Bold",          "", "", "bold")
call <sid>hi("Debug",         s:red, "", "")
call <sid>hi("Directory",     s:blue, "", "")
call <sid>hi("ErrorMsg",      s:red, s:black, "")
call <sid>hi("Exception",     s:red, "", "")
call <sid>hi("FoldColumn",    "", s:black, "")
call <sid>hi("Folded",        s:black, s:white, "")
call <sid>hi("IncSearch",     s:black, s:b_red, "none")
call <sid>hi("Italic",        "", "", "none")
call <sid>hi("Macro",         s:red, "", "")
call <sid>hi("MatchParen",    s:black, s:b_black,  "")
call <sid>hi("ModeMsg",       s:green, "", "")
call <sid>hi("MoreMsg",       s:green, "", "")
call <sid>hi("Question",      s:blue, "", "")
call <sid>hi("Search",        s:b_black, s:yellow,  "")
call <sid>hi("SpecialKey",    s:b_black, "", "")
call <sid>hi("TooLong",       s:red, "", "")
call <sid>hi("Underlined",    s:red, "", "")
call <sid>hi("Visual",        "", s:b_black, "")
call <sid>hi("VisualNOS",     s:red, "", "")
call <sid>hi("WarningMsg",    s:red, "", "")
call <sid>hi("WildMenu",      s:red, "", "")
call <sid>hi("Title",         s:blue, "", "none")
call <sid>hi("Conceal",       s:blue, s:black, "")
call <sid>hi("Cursor",        s:black, s:white, "")
call <sid>hi("NonText",       s:b_black, "", "")
call <sid>hi("Normal",        s:white, s:black, "")
call <sid>hi("LineNr",        s:b_black, s:black, "")
call <sid>hi("SignColumn",    s:b_black, s:black, "")
call <sid>hi("StatusLine",    s:white, s:black, "none")
call <sid>hi("StatusLineNC",  s:white, s:b_blue, "none")
call <sid>hi("VertSplit",     s:b_black, s:black, "none")
call <sid>hi("ColorColumn",   "", s:b_blue, "none")
call <sid>hi("CursorColumn",  "", s:b_blue, "none")
call <sid>hi("CursorLine",    "", s:b_blue, "none")
call <sid>hi("CursorLineNr",  s:white, s:b_blue, "")
call <sid>hi("PMenu",         s:b_white, s:b_blue, "none")
call <sid>hi("PMenuSel",      s:b_blue, s:white, "")
call <sid>hi("TabLine",       s:white, s:b_blue, "none")
call <sid>hi("TabLineFill",   s:white, s:b_blue, "none")
call <sid>hi("TabLineSel",    s:black, s:white, "none")

" Standard syntax highlighting
call <sid>hi("Boolean",      s:b_red, "", "")
call <sid>hi("Character",    s:red, "", "")
call <sid>hi("Comment",      s:b_black, "", "")
call <sid>hi("Conditional",  s:blue, "", "")
call <sid>hi("Constant",     s:b_red, "", "")
call <sid>hi("Define",       s:magenta, "", "none")
call <sid>hi("Delimiter",    s:b_cyan, "", "")
call <sid>hi("Float",        s:b_red, "", "")
call <sid>hi("Function",     s:blue, "", "")
call <sid>hi("Identifier",   s:red, "", "none")
call <sid>hi("Include",      s:blue, "", "")
call <sid>hi("Keyword",      s:cyan, "", "")
call <sid>hi("Label",        s:yellow, "", "")
call <sid>hi("Number",       s:b_red, "", "")
call <sid>hi("Operator",     s:b_white, "", "none")
call <sid>hi("PreProc",      s:yellow, "", "")
call <sid>hi("Repeat",       s:yellow, "", "")
call <sid>hi("Special",      s:cyan, "", "")
call <sid>hi("SpecialChar",  s:b_cyan, "", "")
call <sid>hi("Statement",    s:red, "", "")
call <sid>hi("StorageClass", s:yellow, "", "")
call <sid>hi("String",       s:green, "", "")
call <sid>hi("Structure",    s:magenta, "", "")
call <sid>hi("Tag",          s:yellow, "", "")
call <sid>hi("Todo",         s:yellow, s:black, "")
call <sid>hi("Type",         s:yellow, "", "none")
call <sid>hi("Typedef",      s:yellow, "", "")

" C highlighting
call <sid>hi("cOperator",   s:cyan, "", "")
call <sid>hi("cPreCondit",  s:magenta, "", "")

" CSS highlighting
call <sid>hi("cssBraces",      s:white, "", "")
call <sid>hi("cssClassName",   s:magenta, "", "")
call <sid>hi("cssColor",       s:cyan, "", "")

" Diff highlighting
call <sid>hi("DiffAdd",      s:green, s:black, "")
call <sid>hi("DiffChange",   s:b_black, s:black, "")
call <sid>hi("DiffDelete",   s:red, s:black, "")
call <sid>hi("DiffText",     s:blue, s:black, "")
call <sid>hi("DiffAdded",    s:green, s:black, "")
call <sid>hi("DiffFile",     s:red, s:black, "")
call <sid>hi("DiffNewFile",  s:green, s:black, "")
call <sid>hi("DiffLine",     s:blue, s:black, "")
call <sid>hi("DiffRemoved",  s:red, s:black, "")

" Git highlighting
call <sid>hi("gitCommitOverflow",  s:red, "", "")
call <sid>hi("gitCommitSummary",   s:green, "", "")

" GitGutter highlighting
call <sid>hi("GitGutterAdd",     s:green, s:black, "")
call <sid>hi("GitGutterChange",  s:blue, s:black, "")
call <sid>hi("GitGutterDelete",  s:red, s:black, "")
call <sid>hi("GitGutterChangeDelete",  s:magenta, s:black, "")

" HTML highlighting
call <sid>hi("htmlBold",    s:yellow, "", "")
call <sid>hi("htmlItalic",  s:magenta, "", "")
call <sid>hi("htmlEndTag",  s:white, "", "")
call <sid>hi("htmlTag",     s:white, "", "")

" JavaScript highlighting
call <sid>hi("javaScript",        s:white, "", "")
call <sid>hi("javaScriptBraces",  s:b_white, "", "")
call <sid>hi("javaScriptNumber",  s:b_red, "", "")

" Markdown highlighting
call <sid>hi("markdownCode",              s:green, "", "")
call <sid>hi("markdownError",             s:white, s:black, "")
call <sid>hi("markdownCodeBlock",         s:green, "", "")
call <sid>hi("markdownHeadingDelimiter",  s:blue, "", "")

" NERDTree highlighting
call <sid>hi("NERDTreeDirSlash",  s:blue, "", "")
call <sid>hi("NERDTreeExecFile",  s:white, "", "")

" PHP highlighting
call <sid>hi("phpMemberSelector",  s:white, "", "")
call <sid>hi("phpComparison",      s:white, "", "")
call <sid>hi("phpParent",          s:white, "", "")

" Python highlighting
call <sid>hi("pythonOperator",  s:magenta, "", "")
call <sid>hi("pythonRepeat",    s:magenta, "", "")

" Ruby highlighting
call <sid>hi("rubyAttribute",               s:blue, "", "")
call <sid>hi("rubyConstant",                s:yellow, "", "")
call <sid>hi("rubyInterpolation",           s:green, "", "")
call <sid>hi("rubyInterpolationDelimiter",  s:b_cyan, "", "")
call <sid>hi("rubyRegexp",                  s:cyan, "", "")
call <sid>hi("rubySymbol",                  s:green, "", "")
call <sid>hi("rubyStringDelimiter",         s:green, "", "")

" SASS highlighting
call <sid>hi("sassidChar",     s:red, "", "")
call <sid>hi("sassClassChar",  s:b_red, "", "")
call <sid>hi("sassInclude",    s:magenta, "", "")
call <sid>hi("sassMixing",     s:magenta, "", "")
call <sid>hi("sassMixinName",  s:blue, "", "")

" Signify highlighting
call <sid>hi("SignifySignAdd",     s:green, s:black, "")
call <sid>hi("SignifySignChange",  s:blue, s:black, "")
call <sid>hi("SignifySignDelete",  s:red, s:black, "")

" Spelling highlighting
call <sid>hi("SpellBad",     "", s:black, "undercurl")
call <sid>hi("SpellLocal",   "", s:black, "undercurl")
call <sid>hi("SpellCap",     "", s:black, "undercurl")
call <sid>hi("SpellRare",    "", s:black, "undercurl")

" Yank highlighting
call <sid>hi("IncSearch", "", s:b_black, "")

" CoC highlighting
call <sid>hi("CocHintSign",         s:b_black, "", "")
call <sid>hi("CocMarkdownLink",     s:b_black, "", "")
call <sid>hi("CocHintFloat",        s:b_black, "", "")
call <sid>hi("CocHintVirtualText",  s:b_black, "", "")
call <sid>hi("CocListFgBlue",       s:b_black, "", "")
call <sid>hi("CocRustChainingHint", s:b_black, "", "")
call <sid>hi("CocRustTypeHint",     s:b_black, "", "")

" Remove functions
delf <sid>hi

" Remove color variables
unlet s:black s:b_green s:b_yellow s:b_black s:b_blue s:white s:b_magenta s:b_white s:red s:b_red s:yellow s:green s:cyan s:blue s:magenta s:b_cyan

