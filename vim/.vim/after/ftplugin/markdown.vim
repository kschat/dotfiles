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

