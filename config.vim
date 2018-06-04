"----------------------------------------------------------------------
" python-syntax
"----------------------------------------------------------------------
let g:python_version_2=1

"----------------------------------------------------------------------
" gtags-cscope
"----------------------------------------------------------------------
let g:cscopeprg='gtags-cscope'

colorscheme molokai

"https://zhuanlan.zhihu.com/p/36279445
"第一个 GTAGSLABEL 告诉 gtags 默认 C/C++/Java 等六种原生支持的代码直接使用 gtags 本地分析器，而其他语言使用 pygments 模块。
"第二个环境变量必须设置，否则会找不到 native-pygments 和 language map 的定义， Windows 下面在 gtags/share/gtags/gtags.conf，Linux 下要到 /usr/local/share/gtags 里找，也可以把它拷贝成 ~/.globalrc ，Vim 配置的时候方便点。
let $GTAGSLABEL = 'native-pygments'
let $GTAGSCONF = '/Users/morningto/.globalrc'

"----------------------------------------------------------------------
" nerdcommenter
"----------------------------------------------------------------------
let g:NERDSpaceDelims=1

"----------------------------------------------------------------------
" colorscheme 
"----------------------------------------------------------------------
colorscheme molokai

"----------------------------------------------------------------------
" ultisnips
"----------------------------------------------------------------------
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
