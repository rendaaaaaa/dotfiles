"vimrc
"================================================================================
set nocompatible
filetype off

set runtimepath^=$HOME/.vim
set runtimepath+=$HOME/.vim/after

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle'))
endif

NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
NeoBundle 'git://github.com/Shougo/vimproc.git'
NeoBundle 'git://github.com/thinca/vim-quickrun'
NeoBundle 'git://github.com/thinca/vim-ref'
NeoBundle 'git://github.com/pekepeke/ref-javadoc'
NeoBundle 'git://github.com/tpope/vim-fugitive.git'
NeoBundle 'git://github.com/tyru/DumbBuf.vim'
NeoBundle 'git://github.com/tpope/vim-unimpaired'
NeoBundle 'git://github.com/nanotech/jellybeans.vim.git'
NeoBundle 'kien/ctrlp.vim'

"ファイルごとのインデントとシンタックスの設定を有効にする
filetype plugin on
filetype indent on
syntax on

"auto-command groupの設定
augroup vimrc
    autocmd!
augroup END

"動作に関する設定
"================================================================================

"バックアップファイルは作らない
set nobackup

"別バッファに移動するときは何も言わない
"ただし、保存できないようなときはお知らせする
set hidden
set confirm

"クリップボードの同期
set clipboard&
set clipboard+=unnamed

"バックスペースの動作を一般的なアプリとそろえる
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]

"インクメンタルサーチ
"検索文字列の先頭が大文字でない場合は大文字小文字を無視する
set incsearch
set ignorecase
set smartcase

"IME制御
set iminsert=0
set imsearch=0

"バッファの保持と起動直後のハイライト抑止
set viminfo='1000,%

"C-a,C-xでは0から始まる数字を8進数として扱わない
set nrformats-=octal

"カレントディレクトリはファイルのあるところ
autocmd vimrc BufRead * execute ":lcd " . expand("%:p:h")

"コマンドモードの補完時の表示方法をbash風に
set wildmode=longest,list


"表示に関する設定
"================================================================================

"タブとシフトは基本4バイト、スペース
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"行番号表示
set number

"ツールバーを消す
set guioptions&
set guioptions-=T
set guioptions+=c

"タブの可視化
set list
set listchars=tab:=-

"ステータス行のカスタマイズ
set laststatus=2 " always show statusine
set statusline=%<%f\ %m%r%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c\ %p%%

"スクロール時に残す行数
set scrolloff=2
set sidescrolloff=3

"スワップファイルを編集中ファイルのあるところには置かない
set directory-=.

"キーマップの変更
"================================================================================

"motion
"------------------------------------------------------------
"表示行で上下移動
noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap <Down> gj
noremap <Up> gk

"normal mode
"------------------------------------------------------------
"プレフィックスをカンマに
let mapleader=","
let localmapleader=","

"insert modeに入らずに改行を挿入
nnoremap O :<C-u>call append(expand('.'), '')<CR>j

"C,Dと動きを統一
nnoremap Y y$

"Ctrl+jkで高速移動
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>

"スペース連打でバッファ移動
nnoremap <Space><Space> :<C-u>bn<CR>
"Shiftを入れると逆向き
nnoremap <S-Space><Space> :<C-u>bp<CR>
nnoremap <Space><S-Space> :<C-u>bp<CR>
nnoremap <S-Space><S-Space> :<C-u>bp<CR>

" ウィンドウを閉じずにバッファを閉じる
command! Ebd call EBufdelete()
function! EBufdelete()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")

  if buflisted(l:alternateBufNum)
    buffer #
  else
    bnext
  endif

  if buflisted(l:currentBufNum)
    execute "silent bwipeout".l:currentBufNum
    " bwipeoutに失敗した場合はウインドウ上のバッファを復元
    if bufloaded(l:currentBufNum) != 0
      execute "buffer " . l:currentBufNum
    endif
  endif
endfunction

"Ctrlを入れると閉じる
nnoremap <C-Space><C-Space> :<C-u>Ebd<CR>

"設定ファイルの変更・適用をスムーズに:/
nnoremap <Space>/v :<C-u>e $MYVIMRC<CR>
nnoremap <Space>/g :<C-u>e $MYGVIMRC<CR>
nnoremap <Space>// :<C-u>so $MYVIMRC \| so $MYGVIMRC<CR>

"一時的な設定変更:o
nnoremap <Space>ow :<C-u>setlocal wrap! \| setlocal wrap?<CR>
nnoremap <Space>on :<C-u>setlocal number! \| setlocal number?<CR>
nnoremap <Space>oh :<C-u>setlocal hlsearch! \| setlocal hlsearch?<CR>
nnoremap <Space>ol :<C-u>setlocal list! \| setlocal list?<CR>

"ウィンドウ移動:w
nnoremap <Space>j  <C-w>j
nnoremap <Space>k  <C-w>k
nnoremap <Space>h  <C-w>h
nnoremap <Space>l  <C-w>l
nnoremap <Space>ww  <C-w><C-w>
nnoremap <Space>wc  <C-w>c
nnoremap <Space>wo  <C-w>o

"タブ関係:t
nnoremap <Space>tt  <C-u>:tabnew
nnoremap <Space>tc  <C-u>:tabclose
nnoremap <Space>tn  <C-u>:tabnext
nnoremap <Space>tN  <C-u>:tabprevious
nnoremap <Space>tp  <C-u>:tabprevious
nnoremap <Space>tP  <C-u>:tabnext
nnoremap <Space>tl  <C-u>:tabs

"netrwで編集中のディレクトリを開く
nnoremap <space>- :e %:h<CR>

"normal modeからの復帰はC-j
inoremap <C-c> <Nop>
inoremap <C-j> <Esc>
 
"最小化を防ぐ
nnoremap <C-z> <Nop>
nnoremap <Space>z  :<C-u>update<CR>

"QuickRun
nnoremap <Space>r :<C-u>QuickRun<CR>
let g:quickrun_config = {
\  'perl': {
\    'command': 'perl',
\    'hook/output_encode/encoding': "&{termencoding}"
\  },
\  'go': {
\    'command': 'go',
\    'exec': ['%c run %s']
\  }
\}

"コマンドラインウィンドウ
nnoremap <sid>(command-line-enter) q:
xnoremap <sid>(command-line-enter) q:
nnoremap <sid>(command-line-norange) q:<C-u>
nmap :  <sid>(command-line-enter)
xmap :  <sid>(command-line-enter)
autocmd vimrc CmdwinEnter * call s:init_cmdwin()
function! s:init_cmdwin()
  nnoremap <buffer> q :<C-u>quit<CR>
  nnoremap <buffer> <TAB> :<C-u>quit<CR>
  nnoremap <buffer> <C-j> :<C-u>quit<CR>
  inoremap <buffer><expr><CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
  inoremap <buffer><expr><C-h> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
  inoremap <buffer><expr><BS> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
  inoremap <buffer><expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  startinsert!
endfunction

" dumbbuf
let dumbbuf_hotkey = "<Space>b"
let dumbbuf_wrap_cursor = 0
let dumbbuf_remove_marked_when_close = 1
" sometimes I put <Esc> to close dumbbuf buffer,
" which was mapped to close QuickBuf :)
let dumbbuf_mappings = {
    \"n": {
        \"<Esc>": {"alias_to": "q"},
    \}
\}

"ref
nnoremap <Space>rr :<C-u>Ref 
nnoremap <Space>rp :<C-u>Ref perldoc 

"Rename
command! -nargs=+ -bang -complete=file Rename let pbnr=fnamemodify(bufname('%'), ':p')|exec 'f '.escape(<q-args>, ' ')|w<bang>|call delete(pbnr)

"ToHTMLの設定
let g:use_xhtml = 1
let g:html_use_css = 1
let g:html_no_pre = 1

"XMLを開いたときはフォーマットする
autocmd vimrc FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

"CtrlP
nnoremap <Space>pp :<C-u>CtrlPMixed<CR>
let g:ctrlp_clear_cache_on_exit = 0   " 終了時キャッシュをクリアしない
let g:ctrlp_mruf_max            = 500 " MRUの最大記録数
let g:ctrlp_open_new_file       = 1   " 新規ファイル作成時にタブで開く
let g:ctrlp_map = '<Nop>'


