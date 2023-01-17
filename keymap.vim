"----------------------------------------------------------------------
" Ack
"----------------------------------------------------------------------
nmap <leader>a :Ack! -i 
nmap <leader>s :Ack! <C-R>=expand("<cword>")<CR><CR>


"----------------------------------------------------------------------
" Leaderf
"----------------------------------------------------------------------
noremap <c-u> :LeaderfMru<cr>
"noremap <c-g> :LeaderfTag<cr>
nnoremap <leader>t :LeaderfFunction!<cr>

" use hotkey to operate tab
noremap <silent><tab> <nop>
noremap <silent><tab>m :tabnew<cr>
noremap <silent><tab>e :tabclose<cr>
noremap <silent><tab>n :tabn<cr>
noremap <silent><tab>p :tabp<cr>
noremap <silent><tab>f <c-i>
noremap <silent><tab>b <c-o>
noremap <silent>\t :tabnew<cr>
noremap <silent>\g :tabclose<cr>
noremap <silent>\1 :tabn 1<cr>
noremap <silent>\2 :tabn 2<cr>
noremap <silent>\3 :tabn 3<cr>
noremap <silent>\4 :tabn 4<cr>
noremap <silent>\5 :tabn 5<cr>
noremap <silent>\6 :tabn 6<cr>
noremap <silent>\7 :tabn 7<cr>
noremap <silent>\8 :tabn 8<cr>
noremap <silent>\9 :tabn 9<cr>
noremap <silent>\0 :tabn 10<cr>
noremap <silent><s-tab> :tabnext<CR>
inoremap <silent><s-tab> <ESC>:tabnext<CR>

"----------------------------------------------------------------------
" ALE
"----------------------------------------------------------------------
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)

"----------------------------------------------------------------------
" Calendar
"----------------------------------------------------------------------
nmap <F8> :Calendar<cr>

"----------------------------------------------------------------------
" vim-snipmate
"----------------------------------------------------------------------
imap <C-j> <Plug>snipMateNextOrTrigger
smap <C-j> <Plug>snipMateNextOrTrigger
