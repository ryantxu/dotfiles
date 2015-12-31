" VIMRC (pieces picked from multiple sources, primarily
" "   http://www.vim.org/scripts/script.php?script_id=760
" "   http://amix.dk/vim/vimrc.html
" "   http://stackoverflow.com/questions/164847/what-is-in-your-vimrc
"
" " Catered to the needs and woes of a Tufts University student
" " Contact Marshall @ mmoutenot@gmail.com with questions or comments.
"
let mapleader = ","
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'jceb/vim-orgmode'

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'

" My Plugins here:

" Semantic highlighting
Plugin 'jaxbot/semantic-highlight.vim'
let s:semanticGUIColors = [ '#72d572', '#c5e1a5', '#e6ee9c', '#fff59d', '#ffe082', '#ffcc80', '#ffab91', '#bcaaa4', '#b0bec5', '#ffa726', '#ff8a65', '#f9bdbb', '#f9bdbb', '#f8bbd0', '#e1bee7', '#d1c4e9', '#ffe0b2', '#c5cae9', '#d0d9ff', '#b3e5fc', '#b2ebf2', '#b2dfdb', '#a3e9a4', '#dcedc8' , '#f0f4c3', '#ffb74d' ]

" Allows you to use <tab> for all insert completion needs
Plugin 'ervandew/supertab'

" Comment plugin - gcc toggles comment of current line
Plugin 'tomtom/tcomment_vim'

" adds cool git stuff from within vim
" Plugin 'tpope/vim-fugitive'

" cs"' changes surrounding " to '
Plugin 'tpope/vim-surround'

" Rails integration
Plugin 'tpope/vim-haml'

" quick file switcher
Plugin 'kien/ctrlp.vim'
let g:ctrlp_map = '<leader>t'
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
set wildignore+=node_modules/**
set wildignore+=bower_components/**
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" Snipmate and dependencies
" Allows you to complete code snipits like 'for loops'!
" Plugin "MarcWeber/vim-addon-mw-utils"
" Plugin "tomtom/tlib_vim"
" Plugin "honza/snipmate-snippets"
" Plugin 'garbas/vim-snipmate'

" Aligns on any character with ':Align ='
Plugin 'vim-scripts/Align'

" Run ack from within vim!
Plugin 'rking/ag.vim'
Plugin 'karlbright/qfdo.vim'

" fantastic file browser, open a directory with vim
" 1. Open NERDtree
" 2. Point to a directory
" 3. Press `ms`
" 4. Enter search term (e.g. `control\ panel -i`)
" 5. Profit!
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/nerdtree-ack'

" TESTING
Plugin 'tpope/vim-dispatch'

" BEAUTIFUL COLORZ
Plugin 'altercation/vim-colors-solarized'
Plugin 'Lokaltog/vim-distinguished'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
set laststatus=2

" Git gutter shows diffs on the left num bar!
Plugin 'airblade/vim-gitgutter'

" Coffeescript support
Plugin 'kchmck/vim-coffee-script'

" Jade support
Plugin 'digitaltoad/vim-jade'
Plugin 'wavded/vim-stylus'

" syntax checking
Plugin 'scrooloose/syntastic'
let g:syntastic_javascript_checkers = ['eslint']

Plugin 'othree/yajs.vim'
Plugin 'mxw/vim-jsx'
Plugin 'gavocanov/vim-js-indent'
let g:jsx_ext_required = 0

Plugin 'Townk/vim-autoclose'
Plugin 'vim-scripts/closetag.vim'

call vundle#end()
filetype plugin indent on

noremap <Leader>a :Ag <cword><cr>
autocmd FileType coffee let b:dispatch = 'mocha --compilers coffee:coffee-script/register %'

noremap <tab> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" hamlc
au BufRead,BufNewFile *.hamlc set ft=haml

"{{{Auto Commands

" Automatically cd into the directory that the file is in
" set autochdir

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
  au!
  autocmd BufReadPost *
        \ if expand("<afile>:p:h") !=? $TEMP |
        \   if line("'\"") > 1 && line("'\"") <= line("$") |
        \     let JumpCursorOnEdit_foo = line("'\"") |
        \     let b:doopenfold = 1 |
        \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
        \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
        \        let b:doopenfold = 2 |
        \     endif |
        \     exe JumpCursorOnEdit_foo |
        \   endif |
        \ endif
  " Need to postpone using "zv" until after reading the modelines.
  autocmd BufWinEnter *
        \ if exists("b:doopenfold") |
        \   exe "normal zv" |
        \   if(b:doopenfold > 1) |
        \       exe  "+".1 |
        \   endif |
        \   unlet b:doopenfold |
        \ endif
augroup END

"}}}

"{{{Misc Settings

" This shows what you are typing as a command at the bottom of the page
set showcmd
set cmdheight=2

" set wrap
" set textwidth=80
" let g:RightAlign_RightBorder=80
" if exists('+colorcolumn')
"   set colorcolumn=80
" else
"   au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
" endif

" Syntax Higlighting
filetype plugin indent on

" read a file when it is changed from the outside
set autoread

" Use grep
set grepprg=grep\ -nH\ $*

" Make the omnicomplete text readable
highlight PmenuSel ctermfg=black

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
" The following alternative may be less obtrusive.
highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
" Try the following if your GUI uses a dark background.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
" Show trailing whitespace and spaces before a tab:
match ExtraWhitespace /\s\+$\| \+\ze\t/

" Change tab to a space character
set expandtab
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Spell checking (default=false)
if version >= 700
  set spl=en spell
  set nospell
endif

" Mainly for Command-T
set wildignore+=*.o,*.obj,.git,*.png,*env

set backspace=2
set autoindent

" Case handling
set ignorecase
set smartcase

" Incremental search
set incsearch
set hlsearch
set nolazyredraw

" For linux clipboard register
let g:clipbrdDefaultReg = '+'

" Second paren
highlight MatchParen ctermbg=4
"}}}


"{{{Look and Feel and sound
syntax enable "Enable syntax hl

" Set font according to system
" if you're using a mac
set gfn="Fira Code":h12
set shell=/bin/bash

" if you're using windows
"set gfn=Bitstream\ Vera\ Sans\ Mono:h10

" if you're using linux
"  set gfn=Monospace\ 10
"  set shell=/bin/bash

" set t_Co=256
" set background=dark
" colorscheme ir_black

" hides the bullsheet
set guioptions-=T

set background=dark
colorscheme grb256
set encoding=utf8

try
  lang en_US
catch
endtry

set ffs=unix,dos,mac "Default file types

"Status line gnarliness - I use powerline now
" set laststatus=2
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c
" function! CurDir()
"   let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
"   return curdir
" endfunction
" function! HasPaste()
"   if &paste
"     return 'PASTE MODE  '
"   else
"     return ''
"   endif
" endfunction

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set backupdir=~/.tmp
set directory=~/.tmp " Don't clutter my dirs up with swp and tmp files

" }}}

"{{{Functions

"{{{ Open URL in Browser

function! Browser()
  let line = getline (".")
  let line = matchstr (line,"http[^  ]*")
  exec "!chrome ".line
endfunction

"}}}

"{{{ Todo List Mode

function! TodoListMode()
  e ~/.todo.otl
  Calendar
  wincmd l
  set foldlevel=1
  tabnew ~/.notes.txt
  tabfirst
  "or 'norm! zMzr'
endfunction

"}}}

"{{{ Persistant Undo
"if windows
"set undodir=C:\Windows\Temp
"otherwise
set undofile                " Save undo's after file closes
set undodir=$HOME.'/.tmp/undodir'
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo
set hidden
"}}}

"}}}

"{{{ Mappings

vmap <C-x> :!pbcopy<CR>
vmap <C-c> :w !pbcopy<CR><CR>

" GIT Commands
noremap <Leader>gac :Gcommit -m -a ""<LEFT>
noremap <Leader>gc :Gcommit -m ""<LEFT>
noremap <Leader>gs :Gstatus<CR>

" Other remaps
"
" split navigation
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

noremap <Leader>[ :set nopaste<cr>
noremap <Leader>] :set paste<cr>
noremap <Leader>vi :tabe ~/.vimrc<CR>
noremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
noremap <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
noremap <Leader>v :vnew
" noremap <Leader>t :tabe <C-R><CR>
" Emacs-like beginning and end of line.
imap <c-e> <c-o>$
imap <c-a> <c-o>^
"
" Open Url with the browser ',w'
map <Leader>w :call Browser ()<CR>

" Trigger the above todo mode
noremap <silent> <Leader>todo :execute TodoListMode()<CR>

" Folds html tags
nnoremap <leader>ft Vatzf

" Centers the next result on the page
map N Nzz
map n nzz

" Move up and down easier
" let g:C_Ctrl_j = 'off'
" nmap <C-J> <C-d>
" nmap <C-K> <C-u>

" Swap ; and : (one less keypress)
nnoremap ; :
nnoremap : ;

function! DelEmptyLineAbove()
  if line(".") == 1
    return
  endif
  let l:line = getline(line(".") - 1)
  if l:line =~ '^\s*$'
    let l:colsave = col(".")
    .-1d
    silent normal! <C-y>
    call cursor(line("."), l:colsave)
  endif
endfunction

function! AddEmptyLineAbove()
  let l:scrolloffsave = &scrolloff
  " Avoid jerky scrolling with ^E at top of window
  set scrolloff=0
  call append(line(".") - 1, "")
  if winline() != winheight(0)
    silent normal! <C-e>
  endif
  let &scrolloff = l:scrolloffsave
endfunction

function! DelEmptyLineBelow()
  if line(".") == line("$")
    return
  endif
  let l:line = getline(line(".") + 1)
  if l:line =~ '^\s*$'
    let l:colsave = col(".")
    .+1d
    ''
    call cursor(line("."), l:colsave)
  endif
endfunction

function! AddEmptyLineBelow()
  call append(line("."), "")
endfunction

" Arrow key remapping: Up/Dn = move line up/dn; Left/Right = indent/unindent
function! SetArrowKeysAsTextShifters()
  " normal mode
  nmap <silent> <Left> <<
  nmap <silent> <Right> >>
  nnoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>
  nnoremap <silent> <Down>  <Esc>:call AddEmptyLineAbove()<CR>
  nnoremap <silent> <C-Up> <Esc>:call DelEmptyLineBelow()<CR>
  nnoremap <silent> <C-Down> <Esc>:call AddEmptyLineBelow()<CR>
  nnoremap <silent> <C-S-Right> <Esc>:RightAlign<CR>

  " visual mode
  vmap <silent> <Left> <
  vmap <silent> <Right> >
  vnoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>gv
  vnoremap <silent> <Down>  <Esc>:call AddEmptyLineAbove()<CR>gv
  vnoremap <silent> <C-Up> <Esc>:call DelEmptyLineBelow()<CR>gv
  vnoremap <silent> <C-Down> <Esc>:call AddEmptyLineBelow()<CR>gv
  vnoremap <silent> <C-S-Right> <Esc>:RightAlign<CR>gv

  " insert mode
  imap <silent> <Left> <C-D>
  imap <silent> <Right> <C-T>
  inoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>a
  inoremap <silent> <Down> <Esc>:call AddEmptyLineAbove()<CR>a
  inoremap <silent> <C-Up> <Esc>:call DelEmptyLineBelow()<CR>a
  inoremap <silent> <C-Down> <Esc>:call AddEmptyLineBelow()<CR>a
  inoremap <silent> <C-S-Right> <Esc>:RightAlign<CR>a

  " disable modified versions we are not using
  nnoremap  <S-Up>     <NOP>
  nnoremap  <S-Down>   <NOP>
  nnoremap  <S-Left>   <NOP>
  nnoremap  <S-Right>  <NOP>
  vnoremap  <S-Up>     <NOP>
  vnoremap  <S-Down>   <NOP>
  vnoremap  <S-Left>   <NOP>
  vnoremap  <S-Right>  <NOP>
  inoremap  <S-Up>     <NOP>
  inoremap  <S-Down>   <NOP>
  inoremap  <S-Left>   <NOP>
  inoremap  <S-Right>  <NOP>
endfunction

call SetArrowKeysAsTextShifters()

" resize current buffer by +/- 5
nnoremap <D-S-left> :vertical resize -5<cr>
nnoremap <D-S-down> :resize +5<cr>
nnoremap <D-S-up> :resize -5<cr>
nnoremap <D-S-right> :vertical resize +5<cr>

" switch between windows with Cmd-[H,J,K,L]
noremap <D-S-H> <C-w>h
noremap <D-S-J> <C-w>j
noremap <D-S-K> <C-w>k
noremap <D-S-L> <C-w>l

" DJANGO STUFF
" let g:last_relative_dir = ''
" nnoremap \1 :call RelatedFile ("models.py")<cr>
" nnoremap \2 :call RelatedFile ("views.py")<cr>
" nnoremap \3 :call RelatedFile ("urls.py")<cr>
" nnoremap \4 :call RelatedFile ("admin.py")<cr>
" nnoremap \5 :call RelatedFile ("tests.py")<cr>
" nnoremap \6 :call RelatedFile ( "templates/" )<cr>
" nnoremap \7 :call RelatedFile ( "templatetags/" )<cr>
" nnoremap \8 :call RelatedFile ( "management/" )<cr>
" nnoremap \0 :e settings.py<cr>
" nnoremap \9 :e urls.py<cr>
" map <F8> :vertical wincmd f<CR>
"
" fun! RelatedFile(file)
"   #This is to check that the directory looks djangoish
"   if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
"     exec "edit %:h/" . a:file
"     let g:last_relative_dir = expand("%:h") . '/'
"     return ''
"   endif
"   if g:last_relative_dir != ''
"     exec "edit " . g:last_relative_dir . a:file
"     return ''
"   endif
"   echo "Cant determine where relative file is : " . a:file
"   return ''
" endfun

" fun SetAppDir()
"     if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
"         let g:last_relative_dir = expand("%:h") . '/'
"         return ''
"     endif
" endfun
" autocmd BufEnter *.py call SetAppDir()
"
" function! Grep(name)
"   let l:pattern = input("Other pattern: ")
"   "let l:_name = substitute(a:name, "\\s", "*", "g")
"   let l:list=system("grep -nIR '".a:name."' * | grep -v 'svn-base' | grep '" .l:pattern. "' | cat -n -")
"   let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))
"   if l:num < 1
"     echo "'".a:name."' not found"
"     return
"   endif
"
"   echo l:list
"   let l:input=input("Which?\n")
"
"   if strlen(l:input)==0
"     return
"   endif
"
"   if strlen(substitute(l:input, "[0-9]", "", "g"))>0
"     echo "Not a number"
"     return
"   endif
"
"   if l:input<1 || l:input>l:num
"     echo "Out of range"
"     return
"   endif
"
"   let l:line=matchstr("\n".l:list, "".l:input."\t[^\n]*")
"   let l:lineno=matchstr(l:line,":[0-9]*:")
"   let l:lineno=substitute(l:lineno,":","","g")
"   "echo "".l:line
"   let l:line=substitute(l:line, "^[^\t]*\t", "", "")
"   "echo "".l:line
"   let l:line=substitute(l:line, "\:.*", "", "")
"   "echo "".l:line
"   "echo "\n".l:line
"   execute ":e ".l:line
"   execute "normal ".l:lineno."gg"
" endfunction
" command! -nargs=1 Grep :call Grep("<args>")
" map <leader>g "syiw:Grep^Rs<cr>


" Always show line numbers and current position. ALWAYS!
set ruler
set number
set mouse=a
filetype on

