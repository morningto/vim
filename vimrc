let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

   
"Get out of VI's compatible mode..
set nocompatible

"Sets how many lines of history VIM har to remember
set history=400

"Enable filetype plugin
filetype plugin on
filetype indent on

"Set to auto read when a file is changed from the outside
set autoread

"Have the mouse enabled all the time:
set mouse=a

"Set mapleader
let mapleader = ","
let g:mapleader = ","

"Fast saving
nmap <leader>w :w!<cr>
nmap <leader>f :find<cr>

"Fast reloading of the .vimrc
exec "map <leader>s :source ".fnameescape(s:home)."/vimrc<cr>"
"Fast editing of .vimrc
exec "map <leader>e :e! ".fnameescape(s:home)."/vimrc<cr>"
"When .vimrc is edited, reload it
exec "autocmd! bufwritepost ".fnameescape(s:home)."/vimrc source ".fnameescape(s:home)."/vimrc"

func! MySys()
  return "macww"
endfunc

set pastetoggle=<F3>
let g:winManagerWindowLayout='FileExplorer|BufExplorer'
map <F4> :NERDTreeToggle<cr>

map <F6> :run macros/gdb_mappings.vim<cr>
"map <F7> :toggle debug
map <F8> :tp<cr>
map <F9> :tn<cr>
map <F10> :b#<cr>

set background=dark
highlight Normal guibg = grey90

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable syntax hl
syntax enable

if MySys() == "mac"
  set gfn=Bitstream\ Vera\ Sans\ Mono:h14
  "set nomacatsui
  set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
  set fileencoding=utf-8
  set encoding=utf-8
  set termencoding=utf-8
  set gfn=Monospace\ 20
elseif MySys() == "linux"
  set gfn=Monospace\ 11
  set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
  set fileencoding=utf-8
  set encoding=utf-8
  set termencoding=utf-8
endif

set background=dark

map <leader>$ :syntax sync fromstart<cr>

autocmd BufEnter * :syntax sync fromstart
 

"Omni menu colors
hi Pmenu guibg=#333333
hi PmenuSel guibg=#555555 guifg=#ffffff


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fileformats
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Favorite filetypes
set ffs=unix,dos,mac

nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
set so=7

"Turn on WiLd menu
set wildmenu

"Always show current position
set ruler

"The commandbar is 2 high
set cmdheight=2

"Show line number
set nu

"Do not redraw, when running macros.. lazyredraw
set lz

"Change buffer - without saving
set hid

"Set backspace
set backspace=eol,start,indent

"Bbackspace and cursor keys wrap to
set whichwrap+=<,>,h,l

"Ignore case when searching
set ignorecase
set incsearch

"Set magic on
set magic

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

"show matching bracets
set showmatch

"How many tenths of a second to blink
set mat=2

"Highlight search things
set hlsearch

""""""""""""""""""""""""""""""
" => Visual
""""""""""""""""""""""""""""""
" From an idea by Michael Naumann
function! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"
  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  else
    execute "normal /" . l:pattern . "^M"
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

"Basically you press * or # to search for the current selection !! Really useful
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around and tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

func! SvnCurrentFile(cmd)
	execute("!svn ".a:cmd." ".expand("%")."|head -n ".line('.'))
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Switch to current dir
map <leader>cd :cd %:p:h<cr>
map <leader>gl :call SvnCurrentFile("log") <CR>
map <leader>gb :call SvnCurrentFile("blame") <CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"My information
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
iab xname morningto

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings etc.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^

"Move a line of text using control
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
"autocmd BufWrite *.py :call DeleteTrailingWS()

set completeopt=menu

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command-line config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! Cwd()
  let cwd = getcwd()
  return "e " . cwd 
endfunc

func! DeleteTillSlash()
  let g:cmd = getcmdline()
  if MySys() == "linux" || MySys() == "mac"
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  else
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
  endif
  if g:cmd == g:cmd_edited
    if MySys() == "linux" || MySys() == "mac"
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
    else
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
    endif
  endif   
  return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc

"Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./

cno $q <C-\>eDeleteTillSlash()<cr>

cno $c e <C-\>eCurrentFileDir("e")<cr>

cno $tc <C-\>eCurrentFileDir("tabnew")<cr>
cno $th tabnew ~/
cno $td tabnew ~/Desktop/

"Bash like
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffer realted
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Fast open a buffer by search for a name
map <c-q> :sb 

"Open a dummy buffer for paste
map <leader>q :e ~/buffer<cr>

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Buffer - reverse everything ... :)

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()

function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn backup off
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable folding, I find it very useful
set nofen
set fdl=0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set expandtab

set smarttab
set lbr
set tw=500

   """"""""""""""""""""""""""""""
   " => Indent
   """"""""""""""""""""""""""""""
   "Auto indent
   set ai

   "Smart indet
   set si

   "C-style indeting
   set cindent

   "Wrap lines
   set wrap


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   """"""""""""""""""""""""""""""
   " => Vim Grep
   """"""""""""""""""""""""""""""
   let Grep_Skip_Dirs = 'RCS CVS SCCS .svn'
   let Grep_Cygwin_Find = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Filetype generic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   """"""""""""""""""""""""""""""
   " => C mappings
   """""""""""""""""""""""""""""""
   autocmd FileType c map <buffer> <leader><space> :w<cr>:!gcc %<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"For Cope
map <silent> <leader><cr> :noh<cr>

"Orginal for all
map <leader>n :cn<cr>
map <leader>p :cp<cr>
map <leader>c :botright cw 10<cr>
"map <c-u> <c-l><c-j>:q<cr>:botright cw 10<cr>
"my change 
map <c-g> <c-l><c-j>:q<cr>:botright cw 10<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remove the Windows ^M
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"Paste toggle - when pasting something in, don't indent.
set pastetoggle=<F3>

"Super paste
inoremap <C-v> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>

"myself config
set cinoptions=s,e0,n0,f0,{0,}0,^0,:s,=s,l0,b0,gs,hs,ps,ts,is,+s,c3,C0,/0,(2s,us,U0,w0,W0,m0,j0,)20,*30
"map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

set ts=4
set sw=4

"set hidden
set switchbuf="useopen"

set previewheight=12

"set bomb

if !exists('g:bundle_group')
	let g:bundle_group=[]
endif
let g:bundle_group += ['basic', 'opt', 'high', 'nerdtree', 'airline', 'ale']

exec 'source '.fnameescape(s:home).'/bundle.vim'
exec 'source '.fnameescape(s:home).'/unix.vim'
exec 'source '.fnameescape(s:home).'/plugin.vim'
exec 'source '.fnameescape(s:home).'/keymap.vim'
exec 'source '.fnameescape(s:home).'/config.vim'
"VimImport fnameescape(s:home).'/bundle.vim'
set statusline+=%{gutentags#statusline('[',']')}
