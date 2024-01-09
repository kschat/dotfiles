setlocal nowrap
setlocal conceallevel=2
setlocal textwidth=100

" insert bold, italic, etc
nmap <silent> <buffer> <LocalLeader>ii mmysiw_`m:delmarks m<CR>
nmap <silent> <buffer> <LocalLeader>ib mmysiw*w.`m:delmarks m<CR>
nmap <silent> <buffer> <LocalLeader>is mmysiw~w.`m:delmarks m<CR>
nmap <silent> <buffer> <LocalLeader>ic mmysiw``m:delmarks m<CR>

" remove bold, italic, etc
nmap <silent> <buffer> <LocalLeader>ri mmds_`m:delmarks m<CR>
nmap <silent> <buffer> <LocalLeader>rb mmds*w.`m:delmarks m<CR>
nmap <silent> <buffer> <LocalLeader>rs mmds~ds~`m:delmarks m<CR>
nmap <silent> <buffer> <LocalLeader>rc mmds``m:delmarks m<CR>

" toggle conceal level
nmap <silent> <buffer> <LocalLeader>tc :set <C-R>=&conceallevel ? 'conceallevel=0' : 'conceallevel=2'<CR><CR>

" highlight tweaks for headlines.vim
call Highlight('@text.title.1.marker', g:palette.yellow, g:palette.bg1)
call Highlight('@text.title.1', g:palette.yellow, g:palette.bg1)

call Highlight('@text.title.2.marker', g:palette.yellow, g:palette.bg1)
call Highlight('@text.title.2', g:palette.yellow, g:palette.bg1)

call Highlight('@text.title.3.marker', g:palette.yellow, g:palette.bg1)
call Highlight('@text.title.3', g:palette.yellow, g:palette.bg1)

call Highlight('@text.title.4.marker', g:palette.yellow, g:palette.bg1)
call Highlight('@text.title.4', g:palette.yellow, g:palette.bg1)

call Highlight('@text.title.5.marker', g:palette.yellow, g:palette.bg1)
call Highlight('@text.title.5', g:palette.yellow, g:palette.bg1)

call Highlight('@text.title.6.marker', g:palette.yellow, g:palette.bg1)
call Highlight('@text.title.6', g:palette.yellow, g:palette.bg1)

