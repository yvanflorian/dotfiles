set encoding=utf-8
set hidden
set number
set incsearch
set smartindent
set scrolloff=8
set t_Co=256
set relativenumber
set autoindent
set tabstop=2
set shiftwidth=2
set background=dark
set signcolumn=yes
set noswapfile
"set binary
set fixendofline
set foldmethod=syntax
set foldlevelstart=99
set splitbelow
set splitright

call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim', {'branch':'release'}
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify'
Plug 'mkitt/tabline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'joshdick/onedark.vim'
"Plug 'itchyny/lightline.vim'
call plug#end()

"Airline settings: Highlight Tabline
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter="unique_tail"
let g:airline#extensions#tabline#tab_nr_type=1

let g:solarized_contrast="low"
let g:onedark_termcolors=16
let g:onedark_terminal_italics=1
let g:onedark_hide_endofbuffer=1
if (has("termguicolors"))
	set termguicolors
endif

colorscheme onedark

"cursor style in windows terminal
if &term =~ '^xterm'
	"normal mode
	let &t_EI .= "\<Esc>[0 q"
	"insert mode
	let &t_SI .= "\<Esc>[6 q"
endif

"set shell=$GITBASHPATH/bash
"set shell=pwsh

"mappings
nnoremap q <c-v>
syntax enable
filetype plugin on
map <F12> :NERDTreeToggle <CR>
"Ctrl + / to toggle comment
map <F3> <Plug>NERDCommenterToggle
map <C-p> :GFiles<CR>
"copy to clipboard
map <C-c> "*y

let $FZF_DEFAULT_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}' --bind \"ctrl-i:preview-page-down,ctrl-o:preview-page-up""
hi TabLineSel ctermfg=black ctermbg=LightGray

"Terminal inside vim settings
tnoremap <S-Tab> <C-W>:tabprevious<CR>
tnoremap <C-N>   <C-W>N


augroup twig_ft
	au!
	autocmd BufNewFile,BufRead *.tab   set syntax=sql
	autocmd BufNewFile,BufRead *.vw   set syntax=sql
	autocmd BufNewFile,BufRead *.prc  set syntax=sql
	autocmd BufNewFile,BufRead *.pks  set syntax=sql
	autocmd BufNewFile,BufRead *.pkb set syntax=sql
augroup END


" Use <c-space> to trigger completion.
if has("nvim")
	inoremap <silent><expr> <c-space> coc#refresh()
	inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
else
  inoremap <silent><expr> <c-@> coc#refresh()
	inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
endif

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" use K To show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
	if CocAction('hasProvider','hover')
		call CocActionAsync('doHover')
	else
		call feedKeys('K','in')
	endif
endfunction

" Snippets work like VScode
inoremap <expr> <TAB> pumvisible() ? "<C-y" : "\<TAB>"
let g:coc_snippet_next = "<TAB>"
let g:coc_snippet_prev = "<S-TAB>"

" Prettier configurations
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument
autocmd BufWritePre *.go :call CocAction("format")

"refresh nerdtree each time new file is created
" or whenever you press R on tree focus
autocmd BufWritePost * NERDTreeRefreshRoot
"autocmd BufWritePost * NERDTreeFocus | execute 'normal R' | wincmd p
" autocmd VimEnter * NERDTree | vertical resize 50
