"----------------------------------------------------------------------
" system detection
"----------------------------------------------------------------------
if exists('g:asc_uname')
	let s:uname = g:asc_uname
elseif has('win32') || has('win64') || has('win95') || has('win16')
	let s:uname = 'windows'
elseif has('win32unix')
	let s:uname = 'cygwin'
elseif has('unix')
	let s:uname = system("echo -n \"$(uname)\"")
	if !v:shell_error && s:uname == 'Linux'
		let s:uname = 'linux'
	elseif v:shell_error == 0 && match(s:uname, 'Darwin') >= 0
		let s:uname = 'darwin'
	else
		let s:uname = 'posix'
	endif
else
	let s:uname = 'posix'
endif

let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

function! s:path(path)
	let l:path = expand(s:home . '/' . a:path )
	return substitute(l:path, '\\', '/', 'g')
endfunc

if !exists('g:bundle_group')
	let g:bundle_group=[]
endif

call plug#begin(get(g:, 'bundle_home', '~/.vim/plugged'))

"----------------------------------------------------------------------
" package gropu - basic
"----------------------------------------------------------------------
if index(g:bundle_group, 'basic') >=0
	" YouCompletemMe代码补全
	Plug 'https://github.com/Valloric/YouCompleteMe.git'
	"Plug 'justinmk/vim-dirvish'
	" c++语法高亮	
	Plug 'octol/vim-cpp-enhanced-highlight'
	" python语法高亮
	Plug 'hdima/python-syntax'
	" let g:python_highlight_all=1
	" vim 配色方案
	Plug 'flazz/vim-colorschemes'
	" vim快速注释
	Plug 'scrooloose/nerdcommenter'
	highlight PMenu ctermfg=0 ctermbg=242 guifg=black guibg=darkgrey
	highlight PMenuSel ctermfg=242 ctermbg=8 guifg=darkgrey guibg=black

	if has('python') || has('python3')
		Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }	
	endif
endif 

"----------------------------------------------------------------------
" package gropu - opt
"----------------------------------------------------------------------
if index(g:bundle_group, 'opt') >=0
	"Plug 'wsdjeg/FlyGrep.vim'
	" grep搜索工具
	Plug 'mileszs/ack.vim'
	" <c-x>+<c-k>组合查找常用语法词
	Plug 'asins/vim-dict'
	" Calendar功能
	Plug 'itchyny/calendar.vim', { 'on': 'Calendar' }
	" Code Snippets
	Plug 'honza/vim-snippets'
	Plug 'SirVer/ultisnips'
	" 光标快速移动
	Plug 'Lokaltog/vim-easymotion'
	let g:gutentags_modules = []
	if executable('ctags')
		let g:gutentags_modules += ['ctags']
	endif
	if executable('gtags-cscope') && executable('gtags')
		let g:gutentags_modules += ['gtags_cscope']
	endif
	
	"gutentags增量tags插件
	if len(g:gutentags_modules) > 0
		if s:uname != 'windows'
			Plug 'ludovicchabant/vim-gutentags'
		else
			Plug 'skywind3000/vim-gutentags'
		endif
	endif
endif

"----------------------------------------------------------------------
" package gropu - high
"----------------------------------------------------------------------
if index(g:bundle_group, 'high') >=0
	"textobj插件
	Plug 'kana/vim-textobj-user'
	Plug 'kana/vim-textobj-syntax'
	Plug 'kana/vim-textobj-function', {'for':['c', 'cpp', 'vim', 'java']}
	"textobj python
	"f函数 c类
	Plug 'bps/vim-textobj-python'
endif

"----------------------------------------------------------------------
" package gropu - nerdtree
"----------------------------------------------------------------------
if index(g:bundle_group, 'nerdtree') >=0
	"nerdtree
	Plug 'scrooloose/nerdtree', {'on': ['NERDTree', 'NERDTreeFocus', 'NERDTreeToggle', 'NERDTreeCWD', 'NERDTreeFind']}
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight', {'on': ['NERDTree', 'NERDTreeFocus', 'NERDTreeToggle', 'NERDTreeCWD', 'NERDTreeFind']}
	"Plug 'ryanosis/vim-devicons'
	"Plug 'ryanosis/nerd-fonts'
endif

"----------------------------------------------------------------------
" package gropu - echodoc
"----------------------------------------------------------------------
if index(g:bundle_group, 'opt') >=0
	" 显示函数定义的提示
	" 没有起作用，怀疑跟YouCompleteMe功能冲突了
	Plug 'Shougo/echodoc.vim'
	set noshowmode
endif

"----------------------------------------------------------------------
" package gropu - airline
"----------------------------------------------------------------------
if index(g:bundle_group, 'airline') >= 0
	"增强版的statusline
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	let g:airline_left_sep = ''
	let g:airline_left_alt_sep = ''
	let g:airline_right_sep = ''
	let g:airline_right_alt_sep = ''
	let g:airline_powerline_fonts = 0
	let g:airline_exclude_preview = 1
	let g:airline_section_b = '%n'
	" let g:airline_section_z = '%P %l/%L%{g:airline_symbols.maxlinenr} : %v'
	" let g:airline_section_z = '%{AirlineLineNumber()}'
	" let g:airline_theme='bubblegum'
endif

" lightline
if index(g:bundle_group, 'lightline') >= 0
	"轻量级的statusline
	Plug 'itchyny/lightline.vim'
endif

"----------------------------------------------------------------------
" package gropu - ale
"----------------------------------------------------------------------
if index(g:bundle_group, 'ale') >= 0
	" 代码检查工具
	Plug 'w0rp/ale'

	let g:airline#extensions#ale#enabled = 1
	let g:ale_linters = {
				\ 'c': ['gcc', 'cppcheck'],
				\ 'cpp': ['cppcheck'],
				\ 'python': ['flake8', 'pylint'],
				\ 'lua': ['luac'],
				\ 'go': ['go build', 'gofmt'],
				\ 'java': ['javac'],
				\ 'javascript': ['eslint'],
				\ 'vim': ['vint'],
				\ } 
	function! s:lintcfg(name)
		let l:conf = s:path('tools/conf/')
		let l:path1 = l:conf . a:name
		let l:path2 = expand('~/.vim/linter/'. a:name)
		if filereadable(l:path2)
			return l:path2
		endif
		return shellescape(filereadable(l:path2)? l:path2 : l:path1)
	endfunc

	let g:ale_python_flake8_options = '--conf='.s:lintcfg('flake8.conf')
	let g:ale_python_pylint_options = '--rcfile='.s:lintcfg('pylint.conf')
	let g:ale_python_pylint_options .= ' --disable=W'
	let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
	let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
	let g:ale_c_cppcheck_options = ''
	let g:ale_cpp_cppcheck_options = ''

	let g:ale_linters.text = ['textlint', 'write-good']

	if executable('gcc') == 0 && executable('clang')
		let g:ale_linters.c += ['clang']
		let g:ale_linters.cpp += ['clang']
	endif
endif

call plug#end()
