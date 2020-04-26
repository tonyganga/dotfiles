execute pathogen#infect()
syntax on
syntax enable
filetype plugin indent on
" no bells please
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set t_Co=256
"----------
" ui 
"----------
set number
set nowrap
set ruler
set hidden
set background=dark
set encoding=utf8
set ffs=unix,dos,mac
set cursorline
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set expandtab
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set linebreak
set textwidth=250
set laststatus=2
set t_ut=
" window nagivation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
colorscheme gruvbox
"----------
" writes + 
"----------
set autowrite
set nobackup
set nowritebackup
set noswapfile
"-----------
" vim-fugitive (git)
"
nnoremap <Leader>gg :G<CR>
nnoremap <Leader>ga :Git add %:p<CR><CR>
nnoremap <Leader>gr :Git reset %:p<CR><CR>
nnoremap <Leader>gR :Git reset<CR><CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit -S -v -q<CR>
nnoremap <Leader>gC :Gcommit -S -v -q %:p<CR>
nnoremap <Leader>gd :Gvdiff<CR>
nnoremap <Leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <Leader>gb :Gblame<CR>
"----------
" airline
"----------
let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline_theme = "gruvbox"
"------
" ycm
"------
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
"-----------
" ctrlp
"-----------
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " ag settings
  let g:ag_working_path_mode = "r"
  map <silent> <LocalLeader>ag :Ag<CR>
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --hidden --ignore .git --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  "let g:ctrlp_use_caching = 0
else
  " Let's try this with git
  let g:ctrlp_user_command = [
        \ '.git', 'cd %s && git ls-files . -co --exclude-standard',
        \ 'find %s -type f'
        \ ]
endif
let g:ctrlp_extensions = ['tag' ]
let g:ctrlp_max_files=0
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_show_hidden = 1
nmap <silent> <LEFT> :cprev<CR>
nmap <silent> <RIGHT> :cnext<CR>
"-----------
" nerdtree 
"-----------
" NERDTree ignores
let g:NERDTreeIgnore=['build$','tags']
" NERDTree mappings
map <silent> <LocalLeader>ne :call g:WorkaroundNERDTreeFind()<CR>
function! g:WorkaroundNERDTreeFind()
  try | NERDTreeFind | catch | silent! NERDTree | silent! NERDTreeFind | endtry
endfunction
"NERDTree Workaround - otherwise if you :bd the nt buffer it gets saddy
map <silent> <LocalLeader>nt :call g:WorkaroundNERDTreeToggle()<CR>
function! g:WorkaroundNERDTreeToggle()
  try | NERDTreeToggle | catch | silent! NERDTree | endtry
endfunction
"--------------
" vim-terraform
"--------------
"
let g:terraform_align=1
let g:terraform_fmt_on_save=1
"--------------
" vim-go
"--------------
let g:go_fmt_command = "goimports"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
let g:go_gocode_propose_source = 1
" Auto-lint on save
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet']
let g:go_auto_type_info = 1
"let g:go_info_mode = 'gocode'
  let g:go_debug_windows = {
              \ 'vars':       'leftabove 50vnew',
              \ 'stack':      'rightbelow 40new',
              \ 'goroutines': 'botright 10new',
              \ 'out':        'botright 5new',
    \ }
" Shortcuts
augroup go
  set updatetime=100
  autocmd!
  " Show by default 4 spaces for a tab
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
  " :GoBuild and :GoTestCompile
  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
  " :GoTest
  autocmd FileType go nmap <leader>t  <Plug>(go-test)
  " :GoRun
  autocmd FileType go nmap <leader>r  <Plug>(go-run)
  " :GoDoc
  autocmd FileType go nmap <Leader>d <Plug>(go-doc)
  " :GoCoverageToggle
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
  " :GoInfo
  autocmd FileType go nmap <Leader>i <Plug>(go-info)
  " :GoMetaLinter
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)
  " :GoDef but opens in a vertical split
  autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
  " :GoDef but opens in a horizontal split
  autocmd FileType go nmap <Leader>s <Plug>(go-def-split)
  " :GoAlternate  commands :A, :AV, :AS and :AT
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END
" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
