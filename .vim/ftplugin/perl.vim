compiler perl
nnoremap <Space>xx :<C-u>!perl %<CR>
nnoremap <Space>xc :<C-u>!perl -wc %<CR>
nnoremap <Space>xt :<C-u>!prove -vl %<CR>
nnoremap <Space>xs :<C-u>%!perltidy<CR>
vnoremap <Space>xs :!perltidy<CR>

echo "perl setting"
