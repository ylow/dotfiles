set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'Valloric/YouCompleteMe'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'rust-lang/rust.vim'
call vundle#end()            " required
filetype plugin indent on     " required!

call pathogen#infect()
call pathogen#helptags()

"set pythonthreedll=/Users/ylow/anaconda3/lib/libpython3.9.dylib
"set pythonthreehome=/Users/ylow/anaconda3
set pythonthreedll=/opt/homebrew/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/lib/python3.9/config-3.9-darwin/libpython3.9.dylib
set pythonthreehome=/opt/homebrew/opt/python@3.9/Frameworks/Python.framework/Versions/3.9

set completeopt=menu,menuone,longest
set pumheight=15

set tabstop=2
set expandtab
set softtabstop=2
set shiftwidth=2
set cindent
set smarttab
set wildmenu
set wildmode=list:longest,full
set mouse=a
set number
set ignorecase
set smartcase
set incsearch
set hlsearch
set nohidden
set showmatch
set backspace=2
set noswapfile
"set autochdir

map <c-w><c-f> :FirstExplorerWindow<cr>
map <c-w><c-b> :BottomExplorerWindow<cr>
map <c-w><c-t> :WMToggle<cr> 
imap <c-v> <C-O>"*p
nmap <c-Down> :bn<cr>
nmap <c-Up> :bp<cr>
imap <c-Down> <C-O>:bn<cr>
imap <c-Up> <C-O>:bp<cr>

vnoremap > >gv
vnoremap < <gv
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

"Allow home behavior to match most other editors. Alternates between
"start of line and first non-space character
function! HomeBehavior()
  let l:curvnum = wincol() 
  "try to move to beginning of line
  exe "normal" "^"
  let l:newvnum = wincol()
  "we did not move. So move all the way to the start
  if (l:curvnum == l:newvnum)
    exe "normal" "0"
  endif
endfunction
  
"insert mode starting at end of line switches to append
function! InsertTransitionBehavior()
  let l:curvnum = wincol()
  " try to move right
  exe 'normal' 'l'
  let l:curvnext = wincol()

  if (l:curvnum == l:curvnext)
    " this is the end of the line
    :startinsert! 
  else
    " move back 1 char and insert
    exe 'normal' 'h'
    :startinsert
  endif 
endfunction
 

imap <silent> <home> <C-O>:call HomeBehavior()<cr>
noremap <silent> <home> :call HomeBehavior()<cr>
imap <c-home> <C-O>:0<cr>
imap <c-end> <C-O>G
noremap <c-home> :0<cr>
noremap <c-end> G
"nnoremap <silent> i :call InsertTransitionBehavior()<cr>


let g:clipbrdDefaultReg = '+'
let g:winManagerWidth=35

"set cul 
set cursorcolumn
"hi CursorLine term=none cterm=none ctermbg=234
hi CursorColumn term=none cterm=none ctermbg=234

let g:bufExplorerSortBy='number' 
let g:load_doxygen_syntax=1
let g:doxygen_my_rendering=1
let g:doxygen_enhanced_color=1

set formatoptions=croql

set hidden
let macvim_skip_cmd_opt_movement = 1
  map <F11> <Home>
  map <F12> <End>
  imap <F11> <Home>
  imap <F12> <End>
if has("gui_running")
  colorscheme morning
  set guifont=Inconsolata\ Medium\ 11
"  let g:smooth_page_scroll_delay=1
"  map <PageDown> :call SmoothPageScrollDown()<CR>
"  map <PageUp>   :call SmoothPageScrollUp()<CR> 

else
"  if has("gui_running")
"    map <PageUp> 3<C-Y>3<C-Y>3<C-Y>3<C-Y>3<C-Y>3<C-Y>3<C-Y>3<C-Y>3<C-Y>3<C-Y>3<C-Y>3<C-Y>3<C-Y>3<C-Y>3<C-Y>3<C-Y>
"
"	  map <PageDown> 3<C-E>3<C-E>3<C-E>3<C-E>3<C-E>3<C-E>3<C-E>3<C-E>3<C-E>3<C-E>3<C-E>3<C-E>3<C-E>3<C-E>3<C-E>3<C-E>
"
"  else
"    let g:smooth_page_scroll_delay=2
"    map <PageDown> :call SmoothPageScrollDown()<CR>
"    map <PageUp>   :call SmoothPageScrollUp()<CR> 
"  end
endif

if (!exists("*CppIndentDepth"))
  function CppIndentDepth()
    let l:lineno = v:lnum
    " check if last character is a semicolon
    if l:lineno >= 1 
      let l:prevline= getline(l:lineno - 1)
      " if line does not end with a semicolon
      if match(l:prevline, ";\\s*$") == -1
        " if there is a stream operator align to it
        let l:laststreamop = match(l:prevline, "<<")
        if laststreamop != -1
          return laststreamop 
        endif
      endif
    endif
"     if (l:lineno >= 1) 
"       let l:tmpprev = indent(lineno - 1)
"       let l:tmp = cindent(lineno)
"       if (l:tmp > l:tmpprev + softtabstop) 
"         " indentation depth of greater than 2.
"         " something funky going on!
"         " search for previous parenthesis
"         l:s = search('\({\)\|\([\|(\|<\)','bnWp')
"         if (l:s == 1) 
"           " open brace in a funky place. Probably a 
"           " fiun
"           l:s = search('\({\)\|\([\|(\|<\)','bnWp')
"         end
" 
"       endif
" 
"     endif
  return cindent(lineno)
  endfunction
endif

set colorcolumn=81
set scrolloff=5
set complete=.,w,b,u,t
hi Comment ctermfg=LightGrey guifg=DarkGray
syntax on

" auto change directory to the window's path
" autocmd BufEnter * silent! lcd %:p:h

set viminfo='0,f0,<50,s10,h

function! Box() range
  :'<,'>!boxes -ac -s 76 -k 1 -pa1 
endfunction


function! Lbox() range
  :'<,'>!boxes -al -s 76 -k 1 -pa1 
endfunction

function! Unbox() range
  :'<,'>!boxes -r
endfunction

function! Cowsay() range
  :'<,'>!cowsay
endfunction

command! -range Box <line1>,<line2>call Box()
command! -range Lbox <line1>,<line2>call Lbox()
command! -range Unbox <line1>,<line2>call Unbox()
command! -range Cowsay <line1>,<line2>call Cowsay()

nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>

"autocmd FileType c,cpp,java,php autocmd BufWritePre <buffer> :%s/\s\+$//e

au FileType vim let b:comment_leader = '" '
au FileType c,cpp,java let b:comment_leader = '// '
au FileType sh,make let b:comment_leader = '# '
au FileType tex let b:comment_leader = '% '
noremap <silent> <c-d> :<C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
noremap <silent> <c-e> :<C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>

let g:ConqueTerm_Color = 1
let g:ConqueTerm_ReadUnfocused = 1
let g:ConqueTerm_InsertOnEnter = 0
let g:ConqueTerm_StartMessages = 1
let g:ConqueTerm_ToggleKey = '<F3>'
let g:ConqueTerm_ExecFileKey = ''
let g:ConqueTerm_SendVisKey = '<F5>'
let g:ConqueTerm_SendFileKey = ''
let g:ConqueTerm_TERM = 'xterm'

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

let g:ycm_confirm_extra_conf = 0



let g:rainbow_guifgs = [
    \ '#458588',
    \ '#b16286',
    \ '#cc241d',
    \ '#d65d0e',
    \ '#458588',
    \ '#b16286',
    \ '#cc241d',
    \ '#d65d0e',
    \ '#458588',
    \ '#b16286',
    \ '#cc241d',
    \ '#d65d0e',
    \ '#458588',
    \ '#b16286',
    \ '#cc241d',
    \ '#d65d0e',
    \ ]
"au FileType c,cpp,objc,objcpp call rainbow#load()
set matchpairs+=<:>
let g:pymode_folding = 0

if has("gui_macvim")
  anoremenu 1.1 TouchBar.-flexspace- <Nop>
endif

function! YcmStuff() 
    nnoremap ;g :YcmCompleter GoToDefinition<cr>
    nnoremap ;f :YcmCompleter FixIt<cr>
    nnoremap ;d :YcmCompleter GetDoc<cr>
    nnoremap ;t :YcmCompleter GetType<cr>
    vnoremap ;g :YcmCompleter GoToDefinition<cr>
    vnoremap ;f :YcmCompleter FixIt<cr>
    vnoremap ;d :YcmCompleter GetDoc<cr>
    vnoremap ;t :YcmCompleter GetType<cr>
endfunction

let g:rustfmt_autosave = 1
augroup rust
    autocmd!
	autocmd FileType rust call YcmStuff()
augroup end

"imap <c-Left> <Plug>(copilot-previous)
"imap <c-Right> <Plug>(copilot-next)

