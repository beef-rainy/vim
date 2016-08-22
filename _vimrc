"-------------Pathogen-------------------------------
"for Pathogen plugin bundler
execute pathogen#infect()
syntax on
filetype plugin indent on

"-------------Powerline-------------------------
"add run time path to .vim for pathogen
set rtp+=C:\\Program\ Files\ (x86)\\Vim\\vim74\\bundle\\powerline-develop\\powerline\\bindings\\vim

" Always display the statusline in all windows
set laststatus=2

" Hide the default mode text (e.g. -- INSERT -- below the statusline)
set noshowmode

"-----------Ag Surfer --------------------------
"Silver Surfer directory is project root
let g:ag_working_path_mode="r"

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
nnoremap dd "_dd
vnoremap dd "_dd

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

"-----------Leaders-----------------------------
let mapleader = "\<space>"

"quit preserves windows
nnoremap <Leader>q :bp<CR>:bd #<CR>

"open VIMRC
nnoremap <Leader>$ :e $MYVIMRC<CR>

"open directory     ---Not working yet
nnoremap <leader>o :call OpenDir()

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
nnoremap <leader>* :Ag! -Q <C-r>=expand('<cword>')<CR><CR>

"Ctrl-P search buffers
nnoremap<leader>ls :CtrlPBuffer<CR>

"visual block select variable names and sort lines
vnoremap<leader>s :sort /\s\+/<CR>

"jump to requirement
"nnoremap <leader>r :GarminJumpToRequirement
" not working yet
"g:garmin_requiem_exe = C:\\starteam\\Aviation\\Tools\\Requiem.exe"


"-----------editor setting ---------------------
set background=dark
colorscheme solarized
set guifont=Consolas:cANSI
set guioptions-=T  "remove toolbar
set guioptions-=m  "remove menu

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

"------------augroups/autocmnds-----------------
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

"----------custom functions---------------------
"update tags files
function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction

function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let cmd = 'ctags -a -R -f' . tagfilename . ' --exclude=bin --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
  call DelTagOfFile(f)
  let resp = system(cmd)
endfunction

function! AddAntsTags()
   "refresh ants tags and add tags file to tags
   "set tags ./tags;C:/git/common/ants/fixed/ants/tags
   "let dir = C:/git/common/ants/fixed/ants
   "let cmd = 'ctags -a -R -f' . tagfilename . ' --python-kinds=i --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
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
    execute 'split'
    execute 'Ex | winc j'
    execute 'cd ' . newdir
    execute 'Ex | winc h | winc h'
    call UpdateTags()
endfunction

function! OpenModTest()
    let file = expand('%:t')
    let mod_test = "mod_test_" . file
    execute 'Ag '. mod_test
    execute "/src"
    execute "\<CR>"
endfunction

function! GetDir()
  let curline = getline('.')
  call inputsave()
  let name = input('Enter name: ')
  call inputrestore()
  call setline('.', curline . ' ' . name)
endfunction

"function! HexConv()
"    let prev_yank = @"
"    normal yiw
"    let hex_val = @"
"    let len= strlen(hex_val)
"    let hex_str = ""
"    if len % 2 != 0
"        echo "not valid hex"
"    endif
"    i=0
"    while i < len
"        if i % 2 == 0
"            let hex_str = "\x" . hex_val[i] . hex_val[i+1] . hex_str
"        endif
"        i += 1
"    endwhile
"        echo hex_str
"endfunction
function! SortHeaders()
    normal gg
    execute "normal /#include\<CR>v/\n\n\<CR>kk$"
    execute "'<,'>sort"
    execute "normal /\n\n\<CR>"
    execute "normal /#include\<CR>v/\n\n\<CR>kk$"
    execute "'<,'>sort"
endfunction

