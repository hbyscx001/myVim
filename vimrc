set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'taglist.vim'
Plugin 'nerdtree'
Plugin 'DoxygenToolkit.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rking/ag.vim'
Plugin 'bling/vim-airline'
Plugin 'a.vim'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jiangmiao/auto-pairs'
Plugin 'sjl/gundo.vim'

"Python plugin
Plugin 'python-mode/python-mode'

call vundle#end()

filetype plugin on
filetype plugin indent on

syntax on
set st=4 autoindent sw=4
set hlsearch
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb2312
set termencoding=utf-8
set scrolloff=5
set showmatch

"taglist setting
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1

"ctrlp setting
let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd='CtrlP'
let g:ctrlp_custom_ignore='\v[\/]\.(git|hg|svn|pyc)$'

"YCM setting
noremap <leader>j :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_key_list_select_completion = ['<TAB>','<c-n>','<Down>']
let g:ycm_key_list_previous_completion = ['<S-TAB>','<c-p>','<Up>']
let g:ycm_auto_trigger = 1
let g:ycm_min_num_of_chars_for_completion = 3
set completeopt-=preview
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_warning_symbol = '>*'
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_python_binary_path = '/usr/bin/python2.7'

"airline setting
"let g:airline_powerline_fonts = 1
set laststatus=2

"colors setting
syntax enable

" indent_line settings
let g:indentLine_enabled=1

" autopep8 settings
let g:autopep8_disable_show_diff=1

" python settings
let g:pymode_virtualenv = 1

"Key map
let mapleader=","
nnoremap <silent> <leader>tb :TagbarToggle<CR>
nnoremap <silent> <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>e :e ~/.vimrc<CR>
nnoremap <leader>ga :YcmCompleter GoToDefinitionElseDeclaration
nnoremap <leader>n :tabnext<CR>
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>c :tabclose<CR>
nnoremap <leader>h :GundoToggle<CR>
map <special> <F5> :w<CR> :call RunPython()<CR>


" Fold method
autocmd FileType c,cpp setl fdm=syntax | setl fen


" custom function
"
set makeprg=/home/hlqhayq/rshell/cross-compiler-x86_64/bin/x86_64-gcc\ -lpcap\ -lssl\ -lcrypto\ -ldl\ -Wall\ -g\ -DDEBUG\ -static\ -I./include\ -lpthread\ plugin/*.c\ *.c\ -o\ output.x86_64
" set makeprg=make\ TARGET=winagent
"set makeprg=/home/hlqhayq/rshell/cross-compiler-mips/bin/mips-gcc\ -lssl\ -lcrypto\ -ldl\ -Wall\ -g\ -DDEBUG\ -static\ -I./include\ -lpthread\ plugin/*.c\ *.c\ -o\ output.mips

function RunPython()
	let mp=&makeprg
	let ef=&errorformat
	let exeFile=expand("%:t")
	setlocal makeprg=python\ -u
	set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %1%.%#,%Z%[%^\ ]%\\@=%m
	silent make %
	copen
	let &makeprg=mp
	let &errorformat=ef
endfunction

if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=0
	set cst
	set nocsverb
	if filereadable("cscope.out")
		cs add cscope.out
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
	set csverb
endif

