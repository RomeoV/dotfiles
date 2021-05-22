" set makeprg=cmake\ --build\ build\ -j3
" FocusDispatch -dir=build ctest . -V
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1

nmap <leader>ln :LL n<CR>
nmap <leader>lc :LL c<CR>
nmap <leader>lr :LL r<CR>
nmap <leader>lpu :LL p *(sFace(*)[220])data->faces<CR>
nmap <leader>lpp :LL p *(sCell(*)[100])data->cells<CR>
nmap <leader>lb <Plug>LLBreakSwitch
