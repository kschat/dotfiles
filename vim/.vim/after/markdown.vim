setlocal nowrap conceallevel=2

" Set mark to save position, go to the next word than back to the current word
" to always insert at the beginning of the current word, insert '**', jump to
" the end of the current word, enter '**', jump back to the saved cursor
" position, and finally delete the mark.
nmap <silent> <buffer> <LocalLeader>ii mmysiw_`m:delmarks m<CR>
nmap <silent> <buffer> <LocalLeader>ib mmysiw*w.`m:delmarks m<CR>
nmap <silent> <buffer> <LocalLeader>is mmysiw~w.`m:delmarks m<CR>
nmap <silent> <buffer> <LocalLeader>ic mmysiw``m:delmarks m<CR>

nmap <silent> <buffer> <LocalLeader>ri mmds_`m:delmarks m<CR>
nmap <silent> <buffer> <LocalLeader>rb mmds*w.`m:delmarks m<CR>
nmap <silent> <buffer> <LocalLeader>rs mmds~ds~`m:delmarks m<CR>
nmap <silent> <buffer> <LocalLeader>rc mmds``m:delmarks m<CR>
