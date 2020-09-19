" sane dafaults
set noerrorbells
set noshowmatch
set noshowmode
set hidden
set nowrap
set smartcase
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.config/nvim/undodir
set undofile
set nohlsearch
set incsearch
set scrolloff=10
" set cursorline
set shortmess+=c
set shell=/bin/bash
set mouse-=a
set lazyredraw
set ttyfast
set showtabline=2

" set tabs(as spaces) sizes
set tabstop=2 softtabstop=2
set shiftwidth=2
set smartindent
set expandtab

" display line numbers
set number
set relativenumber
" set line gutter size
set numberwidth=5

" lower update times for a better experience
set updatetime=50

" line length gutter. 
set colorcolumn=80

" mappings with leader key
let mapleader = " "

" jump back to where you left off
" from: https://askubuntu.com/a/202077
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

call plug#begin()
" my colorscheme (the one and only colorscheme)
" + other purely visual extensions
" Plug 'gruvbox-community/gruvbox'
Plug 'ryanoasis/vim-devicons'

" essentials (status line, commenter, zen mode)
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'junegunn/goyo.vim'
Plug 'mbbill/undotree'
Plug 'tpope/vim-commentary'

" lsp & navigation
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'

" the only vim extension
Plug 'tpope/vim-fugitive'

" languages
Plug 'sheerun/vim-polyglot'
call plug#end()

" -----------------------------------------------------------------------------
" appearance
" -----------------------------------------------------------------------------
source ~/.config/nvim/theme.vim

" -----------------------------------------------------------------------------
" lightline
" -----------------------------------------------------------------------------

" configure lightline
let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode' ], 
  \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ],
  \   'right': [
  \     [ 'lineinfo' ],
  \     [ 'percent' ],
  \     [ 'filetype' ],
  \   ] 
  \ },
  \ 'tabline': {
  \   'left': [ ['buffers'] ],
  \   'right': []
  \ },
  \ 'component_expand': {
  \   'buffers': 'lightline#bufferline#buffers'
  \ },
  \ 'component_type': {
  \   'buffers': 'tabsel'
  \ },
  \ 'component_function': {
  \   'filetype': 'FileType',
  \   'cocstatus': 'coc#status',
  \ }
\ }

function! FileType()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : '') : ''
endfunction

" -----------------------------------------------------------------------------
" coc & fzf
" -----------------------------------------------------------------------------

" definition/warning on hover
" from: https://thoughtbot.com/blog/modern-typescript-and-react-development-in-vim
function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#util#has_float() == 0)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(750, 'ShowDocIfNoDiagnostic')
endfunction

autocmd CursorHoldI * :call <SID>show_hover_doc()
autocmd CursorHold * :call <SID>show_hover_doc()

" prettier format command
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" quick fzf config
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'

" -----------------------------------------------------------------------------
" language specific
" -----------------------------------------------------------------------------

" alias .svelte to html
au! BufNewFile,BufRead *.svelte set ft=html

" format c files on save
function FormatBuffer()
  if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
    let cursor_pos = getpos('.')
    :%!clang-format
    call setpos('.', cursor_pos)
  endif
endfunction
autocmd BufWritePre *.h,*.hpp,*.c,*.cpp :call FormatBuffer()

" go (vim polyglot) config
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_auto_sameids = 1
"
" format go code on save
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" -----------------------------------------------------------------------------
" binds
" -----------------------------------------------------------------------------

" movement and reiszing across splits
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

noremap <leader>H :vertical resize +5<CR>
noremap <leader>J :resize -5<CR>
noremap <leader>K :resize +5<CR>
noremap <leader>L :vertical resize -5<CR>

" other bindings
nnoremap <leader>p :GFiles --cached --others --exclude-standard<CR>
nnoremap <leader>f :Rg<space>
nnoremap <leader>g :Goyo<CR>
nnoremap <leader>u :UndotreeShow <bar> :UndotreeFocus<CR>

" <c-space> to trigger completion.
inoremap <silent><expr> <C-space> coc#refresh()
" coc bindings
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gy <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

" map <ESC> in terminal
tnoremap <ESC> <C-\><C-n>
