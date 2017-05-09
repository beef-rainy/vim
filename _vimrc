"-------------START-------------------------------
syntax on
filetype plugin indent on
let mapleader = "\<space>"

"-------------Airline-----------------------------
let g:airline_powerline_fonts = 1
set enc=utf-8
set guifont=Powerline_Consolas:h9:cANSI
let g:airline_theme = "bubblegum"

"remove file encoding
let g:airline_section_y = ''

"remove filetype
let g:airline_section_x = ''

"show status bar on all buffers
set laststatus=2

"don't show mode since airline
set noshowmode

"------------Syntastic--------------------------
"1: auto open 0 auto close
let g:syntastic_auto_loc_list=1
let g:syntastic_python_checkers=['']

"too sloww: make passive to prevent checks after writes
let g:syntastic_check_on_open=0
let g:syntastic_loc_list_height=8
let g:syntastic_mode_map = {
        \ "mode": "passive"}
"let g:syntastic_debug = 1

"-----------Ag Surfer --------------------------
let g:ag_prg="ag -p C:/Users/franey/global.gitignore --vimgrep --smart-case"

"Silver Surfer directory is project root
let g:ag_working_path_mode="r"

nnoremap <leader>ag :Grepper -tool ag<CR>

"let g:grepper = {
"    \ 'tools': ['ag', 'git', 'grep'],
"    \ 'open':  0,
"    \ 'jump':  1,
"    \ }
"------------CtrlP------------------------------
"can change working path directory     ----might be 0 instead of rw. unsure.
let g:ctrlp_working_path_mode = 'rw'

"Use Ag to find since it is so gloriously fast.
if executable('ag')
  let g:ctrlp_user_command = 'ag -l --nocolor -g "" %s'
  let g:ctrlp_use_caching = 0
endif

"Actually map to <c-p>
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

"-----------C Tags------------------------------
"look for tags file in current directory first
set tags =./tags;C:/git/common/ants/fixed/ants/tags
"^^^unsure if working properly

"------------Rebinds----------------------------
"d no longer yanks, remap to black hole register
nnoremap d "_d

"x no longer yanks, remap to black hole register
nnoremap x "_x
vnoremap x "_x

"enable shift tab in insert mode
inoremap <S-Tab> <C-d>

"jk and kj map to <ESC> to normal mode
inoremap jk <ESC>
inoremap kj <ESC>

"go up and down visually in normal mode
nnoremap j gj
nnoremap k gk

"Better window navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"center buffer when jumping around functions
nnoremap ]] ]]zz
nnoremap [[ [[zz

"Y yanks till end of line
nnoremap Y y$

"don't open first file in quicklist for these functions
ca Ag Ag!
ca Glog Glog!

"-----------Leaders-----------------------------
"quit preserves windows
nnoremap <Leader>q :bp<CR>:bd #<CR>

"open VIMRC
nnoremap <Leader>$ :e $MYVIMRC<CR>

"update tags
nnoremap <leader>] :call UpdateTags()<CR>

"yank and paste from system clipboard
nnoremap <leader>p "+p
noremap <leader>y "+y

"stop highlighting searches
nnoremap <leader>/ :nohlsearch<CR>

"go to build.jam
nnoremap <leader>j :GarminBjamEdit()<CR>

"go to mod test
nnoremap <leader>m :call OpenModTest()<CR>

"increase/decrease current window width
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>

"grep for word under cursor
"nnoremap <leader>* :Grepper -tool ag -cword -noprompt<cr>
"not producing accurate results like Ag
"probably want to update path to be $HOME when I have time
nnoremap <leader>* :Ag! -Q <C-r>=expand('<cword>') <CR><CR>

"Ctrl-P search buffers
nnoremap<leader>ls :CtrlPBuffer<CR>

"run code checker
nnoremap<leader>cc :call CodeCheck()<CR><CR>

"run code complexity checker
nnoremap<leader>co :call CodeComplexity()<CR><CR>

"go to line number in code checker
nnoremap<leader>gf :call CCGoToLine()<CR>

"jump to requirement
let g:garmin_requiem_exe = "C:\\starteam\\Aviation\\Tools\\Requiem.exe"
nnoremap<leader>r :GarminJumpToRequirement<CR>

"create file in current dir
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"write file in current dir
map <Leader>w :w <C-R>=expand("%:p:h") . "/" <CR>

"run syntastic
nnoremap <leader>sq :SyntasticToggleMode<CR>
nnoremap <leader>sc :SyntasticCheck<CR>

"yank relative path of current file
noremap <silent> <leader>% :let @"=expand("%:h")<CR>

"call IWYU
noremap <leader>i :call IWYU()<CR>


"-----------editor setting ---------------------
set background=dark
colorscheme solarized
set guioptions-=T  "remove toolbar
set guioptions-=m  "remove menu
set guioptions-=r  "remove right scrollbar
set guioptions-=l  "remove left scrollbar
set guioptions-=L  "remove left scrollbar during vsp
set guioptions+=c  "use console dialogs
set guioptions+=e  "for tab label
set guitablabel=% "set tab label"

"remove annoying background highlighting for matching paren
hi MatchParen guibg=NONE guifg=red

"change highlight color so you can actually see the cursor
hi Search guifg=DarkCyan
hi IncSearch guifg=DarkRed

"initialize windows for console vim or gvim
if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=999 columns=999
else
  " This is console Vim.
  if exists("+lines")
    set lines=50
  endif
  if exists("+columns")
    set columns=100
  endif
endif

"maximize window (removing menu leaves a little extra space)
autocmd GUIEnter * simalt ~x

"case insensitive searching
set ignorecase

"become case sensitive when a capital is typed
set smartcase

"replace all tabs with spaces
set expandtab

"read files with tabs as 4 spaces
set softtabstop=4

"number of spaces to move in an autoindent
set shiftwidth=4

"show line numbers
set number

"search while typing in search query
set incsearch

"highlight searches
set hlsearch

"make backspace work like normal programs
set backspace=indent,eol,start

"don't wrap text on next line
set nowrap

"relative lines
set relativenumber

"don't redraw window during macro execution to increase speed
set lazyredraw

"------------augroups/autocmnds/commands--------
"ensures autocmds are only applied once
"clear all autocommands for current group
"implement delete trailing write spaces
"set python comments to '#' (implement later)
augroup configgroup
    autocmd!
    autocmd BufWritePre *.h,*.py,*.jam,*.c :%s/ \+$//ge
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufWritePre Filetype c,cpp,python,jam :UpdateCopyright
augroup END

"execute argument in cmd.exe from cwd
command! -nargs=* Start execute 'silent !start cmd /k ' . "<args>"

"open dir
command! -nargs=1 OpenDir call OpenDir(<args>)

"----------custom functions---------------------
"update tags
function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  call delete(tagfilename)
  let cmd = 'ctags ' . '-a -B -R -f ' . tagfilename . ' --exclude=bin --c++-kinds=+p --fields=+iaS --extra=+q '
  let resp = system(cmd)
endfunction

"open specified directory in new tab and refresh ctags
function! OpenDir(dir)
    let newdir="D:/git/" . a:dir
    execute 'tabnew | vsplit | vsplit | winc ='
    execute 'cd ' . newdir
    execute 'Ex | winc l'
    execute 'cd ' . newdir
    execute 'Ex | winc l'
    execute 'cd ' . newdir
    execute 'Ex | winc h | winc h'
endfunction

function! OpenModTest()
    let file = expand('%:t')
    let mod_test = "mod_test_" . file
    execute 'Ag '. mod_test
    execute "/src"
    execute "\<CR>"
endfunction

function! CodeCheck()
    set makeprg=python.exe
    set errorformat=%f!%l!%m
    exe ':make!' getcwd() . "\\support\\tools\\code-check\\code_check.py " . expand("%:p")
    botright copen
endfunction

function! CodeComplexity()
    set makeprg=python.exe
    set errorformat=%f!%l!%m
    exe ':make!' 'D:/giaw/Tools/CodeComplexityCheck/code_complexity_check.py ' . expand("%:p")
    botright copen
endfunction

function! CCGoToLine()
    "search for 'Line'
    execute "normal 0/Line\<cr>"
    "yank line number
    execute 'normal w"zyiw0'
    "go to previous window
    execute "normal \<c-w>\<c-p>"
    "jump to yanked line number
    execute "normal :\<c-r>z\<cr>"
endfunction

"run IWYU on current file
function IWYU()
    execute 'silent !start cmd /k "iwyu.sh -f " %'
endfunction

""setup default diff expression for windows
set diffexpr=MyDiff()
function! MyDiff()
   let opt = '-a --binary '
   if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
   if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
   let arg1 = v:fname_in
   if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
   let arg2 = v:fname_new
   if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
   let arg3 = v:fname_out
   if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
   if $VIMRUNTIME =~ ' '
     if &sh =~ '\<cmd'
       if empty(&shellxquote)
         let l:shxq_sav = ''
         set shellxquote&
       endif
       let cmd = '"' . $VIMRUNTIME . '\diff"'
     else
       let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
     endif
   else
     let cmd = $VIMRUNTIME . '\diff'
   endif
   silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
   if exists('l:shxq_sav')
     let &shellxquote=l:shxq_sav
   endif
 endfunction

