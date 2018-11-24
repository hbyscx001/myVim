set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'taglist.vim'
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
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'Valloric/ListToggle'
Plugin 'SirVer/ultisnips'
Plugin 'scrooploose/syntastic'
Plugin 't9md/vim-quickhl'
Plugin 'tpope/vim-surround'
Bundle 'hari-rangarajan/CCTree'
Bundle 'suan/vim-instant-markdown'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'YankRing.vim'


"Python plugin
Plugin 'python-mode/python-mode'

"Go plugin
Plugin 'fatih/vim-go'

call vundle#end()

if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

let mapleader=","

"Key map
nnoremap <silent> <leader>tb :TagbarToggle<CR>
nnoremap <silent> <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>f :CtrlP<CR>
nnoremap <leader>ga :YcmCompleter GoToDefinitionElseDeclaration
nnoremap <leader>n :tabnext<CR>
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>c :tabclose<CR>
nnoremap <leader>h :GundoToggle<CR>
map <special> <F5> :w<CR> :call RunPython()<CR>
map <silent> <leader>ss :source ~/.vimrc<cr>
map <silent> <leader>ee :e ~/.vimrc<cr>
nnoremap <leader>h :GundoToggle<CR>
autocmd! bufwritepost .vimrc source ~/.vimrc 

set tabstop=4 shiftwidth=4 autoindent
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb2312
set termencoding=utf-8
set scrolloff=5
set showmatch
set backspace=indent,eol,start
set showcmd
set ruler
set nu
set nobackup

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

"taglist setting
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1

"ctrlp setting
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore={
			\ 'dir' : '\v[\/]\.(git|hg|svn|pyc)$',
			\ 'file' : '\v\.(exe|so|dll|jpg|png|jpeg)$',
			\}
let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd='CtrlP'

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
" let g:pymode_python = 'python'
let g:pymode_virtualenv = 1
let g:pymode_init = 0
let g:pymode_lint = 0
let g:pymode_python = 'python3'
let g:pymode_rope_goto_definition_bind = "<C-]>"
let g:pymode_lint_on_write = 1
let g:pymode_indent = 1

" airline settings
let g:airline_powerline_fonts = 1
"set rtp+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim
set laststatus=2

" Fold method
autocmd FileType c,cpp setl fdm=syntax | setl fen

" custom function
"

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
