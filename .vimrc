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

"�t�@�C�����Ƃ̃C���f���g�ƃV���^�b�N�X�̐ݒ��L���ɂ���
filetype plugin on
filetype indent on
syntax on

"auto-command group�̐ݒ�
augroup vimrc
    autocmd!
augroup END

"����Ɋւ���ݒ�
"================================================================================

"�o�b�N�A�b�v�t�@�C���͍��Ȃ�
set nobackup

"�ʃo�b�t�@�Ɉړ�����Ƃ��͉�������Ȃ�
"�������A�ۑ��ł��Ȃ��悤�ȂƂ��͂��m�点����
set hidden
set confirm

"�N���b�v�{�[�h�̓���
set clipboard&
set clipboard+=unnamed

"�o�b�N�X�y�[�X�̓������ʓI�ȃA�v���Ƃ��낦��
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]

"�C���N�����^���T�[�`
"����������̐擪���啶���łȂ��ꍇ�͑啶���������𖳎�����
set incsearch
set ignorecase
set smartcase

"IME����
set iminsert=0
set imsearch=0

"�o�b�t�@�̕ێ��ƋN������̃n�C���C�g�}�~
set viminfo='1000,%

"C-a,C-x�ł�0����n�܂鐔����8�i���Ƃ��Ĉ���Ȃ�
set nrformats-=octal

"�J�����g�f�B���N�g���̓t�@�C���̂���Ƃ���
autocmd vimrc BufRead * execute ":lcd " . expand("%:p:h")

"�R�}���h���[�h�̕⊮���̕\�����@��bash����
set wildmode=longest,list


"�\���Ɋւ���ݒ�
"================================================================================

"�^�u�ƃV�t�g�͊�{4�o�C�g�A�X�y�[�X
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"�s�ԍ��\��
set number

"�c�[���o�[������
set guioptions&
set guioptions-=T
set guioptions+=c

"�^�u�̉���
set list
set listchars=tab:=-

"�X�e�[�^�X�s�̃J�X�^�}�C�Y
set laststatus=2 " always show statusine
set statusline=%<%f\ %m%r%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c\ %p%%

"�X�N���[�����Ɏc���s��
set scrolloff=2
set sidescrolloff=3

"�X���b�v�t�@�C����ҏW���t�@�C���̂���Ƃ���ɂ͒u���Ȃ�
set directory-=.

"�L�[�}�b�v�̕ύX
"================================================================================

"motion
"------------------------------------------------------------
"�\���s�ŏ㉺�ړ�
noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap <Down> gj
noremap <Up> gk

"normal mode
"------------------------------------------------------------
"�v���t�B�b�N�X���J���}��
let mapleader=","
let localmapleader=","

"insert mode�ɓ��炸�ɉ��s��}��
nnoremap O :<C-u>call append(expand('.'), '')<CR>j

"C,D�Ɠ����𓝈�
nnoremap Y y$

"Ctrl+jk�ō����ړ�
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>

"�X�y�[�X�A�łŃo�b�t�@�ړ�
nnoremap <Space><Space> :<C-u>bn<CR>
"Shift������Ƌt����
nnoremap <S-Space><Space> :<C-u>bp<CR>
nnoremap <Space><S-Space> :<C-u>bp<CR>
nnoremap <S-Space><S-Space> :<C-u>bp<CR>

" �E�B���h�E������Ƀo�b�t�@�����
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
    " bwipeout�Ɏ��s�����ꍇ�̓E�C���h�E��̃o�b�t�@�𕜌�
    if bufloaded(l:currentBufNum) != 0
      execute "buffer " . l:currentBufNum
    endif
  endif
endfunction

"Ctrl������ƕ���
nnoremap <C-Space><C-Space> :<C-u>Ebd<CR>

"�ݒ�t�@�C���̕ύX�E�K�p���X���[�Y��:/
nnoremap <Space>/v :<C-u>e $MYVIMRC<CR>
nnoremap <Space>/g :<C-u>e $MYGVIMRC<CR>
nnoremap <Space>// :<C-u>so $MYVIMRC \| so $MYGVIMRC<CR>

"�ꎞ�I�Ȑݒ�ύX:o
nnoremap <Space>ow :<C-u>setlocal wrap! \| setlocal wrap?<CR>
nnoremap <Space>on :<C-u>setlocal number! \| setlocal number?<CR>
nnoremap <Space>oh :<C-u>setlocal hlsearch! \| setlocal hlsearch?<CR>
nnoremap <Space>ol :<C-u>setlocal list! \| setlocal list?<CR>

"�E�B���h�E�ړ�:w
nnoremap <Space>j  <C-w>j
nnoremap <Space>k  <C-w>k
nnoremap <Space>h  <C-w>h
nnoremap <Space>l  <C-w>l
nnoremap <Space>ww  <C-w><C-w>
nnoremap <Space>wc  <C-w>c
nnoremap <Space>wo  <C-w>o

"�^�u�֌W:t
nnoremap <Space>tt  <C-u>:tabnew
nnoremap <Space>tc  <C-u>:tabclose
nnoremap <Space>tn  <C-u>:tabnext
nnoremap <Space>tN  <C-u>:tabprevious
nnoremap <Space>tp  <C-u>:tabprevious
nnoremap <Space>tP  <C-u>:tabnext
nnoremap <Space>tl  <C-u>:tabs

"netrw�ŕҏW���̃f�B���N�g�����J��
nnoremap <space>- :e %:h<CR>

"normal mode����̕��A��C-j
inoremap <C-c> <Nop>
inoremap <C-j> <Esc>
 
"�ŏ�����h��
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

"�R�}���h���C���E�B���h�E
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

"ToHTML�̐ݒ�
let g:use_xhtml = 1
let g:html_use_css = 1
let g:html_no_pre = 1

"XML���J�����Ƃ��̓t�H�[�}�b�g����
autocmd vimrc FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

"CtrlP
nnoremap <Space>pp :<C-u>CtrlPMixed<CR>
let g:ctrlp_clear_cache_on_exit = 0   " �I�����L���b�V�����N���A���Ȃ�
let g:ctrlp_mruf_max            = 500 " MRU�̍ő�L�^��
let g:ctrlp_open_new_file       = 1   " �V�K�t�@�C���쐬���Ƀ^�u�ŊJ��
let g:ctrlp_map = '<Nop>'


