set encoding=utf-8

" set tabspace. 4 for code. 8 for kernel
set ts=4
set shiftwidth=4
set noet
"%retab!
" set wrap is on by default
" https://vim.fandom.com/wiki/Working_with_long_lines

" compat etc...
set t_Co=256
set background=dark
set nocompatible
filetype off
syntax on
set laststatus=2
set statusline+=%f
"set hlsearch
set incsearch
set autoindent
set smartindent
set pastetoggle=<F2>

set ignorecase
set smartcase

" mouse enabled
set mouse=a

" clipboard
set clipboard=unnamedplus
vmap <C-c> "+y

" tell it to use an undo file
set undofile
set undodir=~/.vim/undodir

" line numbers
set number!
nnoremap <F3> :NumbersToggle<CR>
nnoremap <F4> :NumbersOnOff<CR>

" whitespaces etc
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
"https://stackoverflow.com/questions/356126/how-can-you-automatically-remove-trailing-whitespace-in-vim
"https://vi.stackexchange.com/questions/454/whats-the-simplest-way-to-strip-trailing-whitespace-from-all-lines-in-a-file

" plugins (ctrlP & vimautocompletesme & unimpaired.vim)
" vundle
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'rbong/vim-crystalline'
Plugin 'davidhalter/jedi-vim'
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/gv.vim'
Plugin 'ervandew/supertab'
Plugin 'morhetz/gruvbox'
Plugin 'preservim/nerdtree'
call vundle#end()

" gruvbox
colorscheme gruvbox

" ctrlP
set runtimepath+=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = "<c-p>"
let g:ctrlp_cmd = "CtrlP ."
" map \b to list current open buffers
:map <leader>b :ls<CR>:b

let g:jedi#force_py_version = 3
"let g:jedi#completions_command = "<Tab>"

let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

" move between split windows without taking up screen space
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
set wmh=0

" SHIFT-ZQ -> exit without saving

autocmd FileType python map <buffer> <F3> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F3> <esc>:w<CR>:exec '!python' shellescape(@%, 1)<CR>
"autocmd FileType python map <buffer> <F3> :w<CR>:ter python "%"<CR>
"autocmd FileType python imap <buffer> <F3> <esc>:w<CR>:vert ter python "%"<CR>

" ------------------------------
function! StatusLine(current)
  return (a:current ? crystalline#mode() . '%#Crystalline#' : '%#CrystallineInactive#')
        \ . ' %f%h%w%m%r '
        \ . '%=' . (a:current ? '%#Crystalline# %{&paste?"PASTE ":""}%{&spell?"SPELL ":""}' . crystalline#mode_color() : '')
        \ . ' %{&ft}[%{&enc}][%{&ffs}] %l/%L %c%V %P '
endfunction

function! TabLine()
  let l:vimlabel = has("nvim") ?  " NVIM " : " VIM "
  return crystalline#bufferline(2, len(l:vimlabel), 1) . '%=%#CrystallineTab# ' . l:vimlabel
endfunction

let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_tabline_fn = 'TabLine'
let g:crystalline_theme = 'default'

set showtabline=2
set laststatus=2

" ------------------------------
" http://tdaly.co.uk/projects/vim-statusline-generator/
"

"set laststatus=2
"" set statusline+=%{strftime("%H:%M")}
"set statusline+=\ 
"set statusline+=|
"set statusline+=\ 
"set statusline+=%1*
"set statusline+=%{StatuslineMode()}
"set statusline+=%9*
"set statusline+=%2*
"set statusline+=\ 
"set statusline+=:
"set statusline+=:
"set statusline+=\ 
"set statusline+=%F
"set statusline+=\ 
"set statusline+=:
"set statusline+=:
"set statusline+=%=
"set statusline+=%m
"set statusline+=\ 
"set statusline+=|
"set statusline+=\ 
"set statusline+=%L
"set statusline+=\ 
"set statusline+=:
"set statusline+=:
"set statusline+=\ 
"set statusline+=%P
"set statusline+=\ 
"set statusline+=|
"set statusline+=\ 
"set statusline+=%y
"set statusline+=\ 
"set statusline+=%{&ff}
"set statusline+=\ 
"set statusline+=%{strlen(&fenc)?&fenc:'none'}
"set statusline+=\ 
"set statusline+=|
"set statusline+=\ 
"set statusline+=%{b:gitbranch}
"set statusline+=%9*
"hi User1 ctermbg=white ctermfg=red guibg=white guifg=red
"hi User2 ctermbg=white ctermfg=black guibg=white guifg=black
"
"function! StatuslineMode()
"	let l:mode=mode()
"	if l:mode==#"n"
"		return "NORMAL"
"	elseif l:mode==?"v"
"		return "VISUAL"
"	elseif l:mode==#"i"
"		return "INSERT"
"	elseif l:mode==#"R"
"		return "REPLACE"
"	endif
"endfunction
"hi User9 NONE
"
"function! StatuslineGitBranch()
"	let b:gitbranch=""
"	if &modifiable
"		lcd %:p:h
"		let l:gitrevparse=system("git rev-parse --abbrev-ref HEAD")
"		lcd -
"		if l:gitrevparse!~"fatal: not a git repository"
"			let b:gitbranch="(".substitute(l:gitrevparse, '\n', '', 'g').") "
"		endif
"	endif
"endfunction
"
"augroup GetGitBranch
"	autocmd!
"	autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
"augroup END
"
