"---------表示設定-----------
"set cursorline
"set cursorcolumn
set imdisable

" vi との互換性OFF
set nocompatible
" ファイル形式の検出を無効にする
filetype off

" Vundle を初期化して Vundle 自身も Vundle で管理
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'neocomplcache'

let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" " Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" " Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3

" ファイル形式検出、プラグイン、インデントを ON
filetype plugin indent on

" [Backspace] で既存の文字を削除できるように設定
"  start - 既存の文字を削除できるように設定
"  eol - 行頭で[Backspace]を使用した場合上の行と連結
"  indent - オートインデントモードでインデントを削除できるように設定
set backspace=start,eol,indent

set encoding=utf-8
set fenc=utf-8
"set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8

set title "編集中のファイル名を表示
set showmatch "括弧入力時の対応する括弧を表示
syntax on "コードの色分け
highlight Normal ctermbg=black ctermfg=grey
highlight StatusLine term=none cterm=none ctermfg=black ctermbg=gray
highlight CursorLine term=none cterm=none ctermfg=none ctermbg=darkgrey
"highlight Normal ctermbg=grey ctermfg=black
"highlight StatusLine term=none cterm=none ctermfg=grey ctermbg=black
"highlight CursorLine term=none cterm=none ctermfg=darkgray ctermbg=none

set tabstop=2 "インデントをスペース4つ分に設定
set shiftwidth=2 "タブの挿入
set smartindent "オートインデント

" #####検索設定#####
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る
" インクリメンタル検索を有効化
set incsearch

" 補完時の一覧表示機能有効化
set wildmenu wildmode=list:full

set foldmethod=marker

if has('multi_byte_ime')
  hi Cursor guifg=bg guibg=Green gui=NONE
  hi CursorIM guifg=NONE guibg=Purple gui=NONE
endif

"syntax enable
"set background=dark
"colorscheme solarized
"let g:solarized_termcolors=256

au BufEnter * execute 'lcd ' fnameescape(expand('%:p:h'))

let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1

function! ToglleVExplorer()
	if !exists("t:netrw_bufnr")
		exec '1wincmd w'
		25Vexplore
		let t:netrw_bufnr = bufnr("%")
		return
	endif
	let win = bufwinnr(t:netrw_bufnr)
	if win != -1
		let cur = winnr()
		exe win . 'wincmd w'
		close
		exe cur . 'wincmd w'
	endif
	unlet t:netrw_bufnr
endfunction
map <silent> <Leader>e :call ToglleVExplorer()<cr><c-w>p

let Tlist_Show_One_File = 1
let Tlist_User_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1
map <silent> <leader>E :TlistToggle<cr>


set mouse=a
set ttymouse=xterm2

" jjで挿入モードから抜ける設定
inoremap <silent> jj <ESC>

" 入力モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" 日本語入力がオンのままでも使えるコマンド(Enterキーは必要)
nnoremap あ a
nnoremap い i
nnoremap う u
nnoremap お o
nnoremap っd dd
nnoremap っy yy
" neobundle settings {{{
if has('vim_starting')
  set nocompatible
  " neobundle をインストールしていない場合は自動インストール
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install neobundle..."
    " vim からコマンド呼び出しているだけ neobundle.vim のクローン
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
  endif
  " runtimepath の追加は必須
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))
let g:neobundle_default_git_protocol='https'

" neobundle#begin - neobundle#end の間に導入するプラグインを記載します。
NeoBundleFetch 'Shougo/neobundle.vim'
" ↓こんな感じが基本の書き方
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplete.vim'

NeoBundle 'joonty/vdebug'

" vimrc に記述されたプラグインでインストールされていないものがないかチェックする
NeoBundleCheck
call neobundle#end()
filetype plugin indent on
" どうせだから jellybeans カラースキーマを使ってみましょう
" set t_Co=256
" syntax on
" colorscheme jellybeans
