call plug#begin('~/.vim/plugged')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript'
Plug 'nikvdp/ejs-syntax'
Plug 'valloric/matchtagalways'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'Yggdroot/indentLine'
Plug 'w0rp/ale'
Plug 'mxw/vim-jsx'
Plug 'yuttie/comfortable-motion.vim'
Plug 'mhinz/vim-startify'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-fugitive'
Plug 'arcticicestudio/nord-vim'
Plug 'posva/vim-vue'
Plug 'tikhomirov/vim-glsl'
call plug#end()

" Line numbers
:set number

" netrw
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0

" Keep undo history across buffers
set hidden

" Hide netrw help
let g:netrw_banner=0

" Color scheme
" set background=dark
colorscheme nord

set t_Co=256

" vimgrep
:set wildignore+=node_modules/**
:set wildignore+=dist/**
:set wildignore+=android/**
command -nargs=1 VG vimgrep <q-args> **/* | copen

" Ctrlp
let g:ctrlp_custom_ignore = 'node_modules'

" Indent size 
" filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab

" Auto indent
set autoindent

" Incremental search
set incsearch

" ES Lint
" let g:ale_linters = { 'javascript': ['standard'], 'cpp': [] }

" GLSL
autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl

" Statusline
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
  redraws!
endfunction

let g:git_branch = StatuslineGit()

set laststatus=2
set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{g:git_branch}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %{strftime('%H:%M')}
set statusline+=\ 
