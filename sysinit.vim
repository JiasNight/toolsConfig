" This line makes pacman-installed global Arch Linux vim packages work.
source /usr/share/nvim/archlinux.vim

"=============== 基础配置 =================="

"显示行号
set nu

"显示标尺
set ruler

"启用鼠标
set mouse=a

"高亮显示当前行
set cursorline

"打开文件总是定位到上次编辑的位置
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

"vim的默认寄存器和系统剪贴板共享
set clipboard+=unnamed

"突出显示非文本
highlight NonText guibg=#060606

"突出显示折叠
highlight Folded  guibg=#0A0A0A guifg=#9090D0

"显示中文帮助
set helplang=cn

" 解决consle输出乱码
language messages zh_CN.utf-8

"设置编码自动识别
set fileencodings=utf-8,cp936,gb18030,gbk,gb2312,ucs-bom,latin-1
set fileencoding=utf-8
set termencoding=utf-8

"设置默认编码为utf-8
set encoding=UTF-8

"设置为双字宽显示，否则无法完整显示如:☆
set ambiwidth=double

"智能选择对齐方式
set smartindent

"在行和段开始处使用制表符
set smarttab
set expandtab

"设置编辑时制表符所占的空格数
set tabstop=4

"设置4个空格为制表符
set softtabstop=4

"设置格式化时制表符占用的空格数
set shiftwidth=4

"禁止折行
"set nowrap

"使用回车键正常处理indent.eol,start等
set backspace=2
set textwidth=80

"vim自身命令行模式智能补全
set wildmenu

"补全时不显示窗口，只显示补全列表
"set completeopt-=preview

"检测文件类型
filetype on

"开启根据文件类型加载插件和缩进规则的功能
filetype plugin indent on

"当文件在外部被修改，自动更新该文件
set autoread

"将搜索内容反白
set hlsearch

"在光标接近底端或顶端时，自动下滚或上滚
set scrolloff=10

"去掉欢迎界面
set shortmess=atI

"设置命令行高度
set cmdheight=1

" 按tab 或作者ctrl+tab在打开的文件之间切换
nnoremap <tab> :bn<CR>
nnoremap <C-tab> :bp<CR>

"允许光标出现在最后一个字符的后面
set virtualedit=block,onemore

"分割出来的窗口位于当前窗口下边/右边
set splitbelow
set splitright

"若打开分割窗口,可快速切换窗口;Ctrl+w切换窗口; Ctrl+w s 水平分割; Ctrl+w v 竖直分割
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

"自动切换目录为当前编辑文件所在目录
autocmd BufEnter * silent! lcd %:p:h

"总是显示状态栏
set laststatus=2

"禁止生成 .~文件
set noundofile
set nobackup
set noswapfile

"保存文件前建立备份，保存成功后删除该备份
set writebackup

" 打开终端窗口
map term:set splitbelow<CR>:term<CR>

"=============== 插件配置 =================="
call plug#begin('~/.local/share/nvim/vimplugs')

"快速打开大文件
Plug 'vim-scripts/LargeFile'

"代码补全
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"使用tab补全
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"文件浏览器
nnoremap <F2> :CocCommand explorer<CR>

"开始显示
Plug 'mhinz/vim-startify'

"代码缩进线
Plug 'Yggdroot/indentLine'
"指定对齐线的尺寸
let g:indent_guides_guide_size = 1
"从第二层开始可视化显示缩进
let g:indent_guides_start_level = 2

"类似Sublime Text的多光标插件
Plug 'terryma/vim-multiple-cursors'

"添加flake8代码风格检查,运行F7就可以进行flake8检查了
Plug 'nvie/vim-flake8'

"代码提纲
"Plug 'majutsushi/tagbar'
"nmap <F6> :TagbarToggle<CR>
"imap <F6> <ESC>:TagbarToggle<CR>
"设置宽度为25
"let g:tagbar_width = 25
"这是tagbar一打开，光标即在tagbar页面内，默认在vim打开的文件内
"let g:tagbar_autofocus = 1
"设置标签不排序，默认排序
"let g:tagbar_sort = 0

"vista.vim 本机需要安装 ctags
Plug 'liuchengxu/vista.vim'
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
let g:vista_ctags_cmd = {
      \ 'haskell': 'hasktags -x -o - -c',
      \ }
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
"快捷键
nmap <F3> :Vista!!<CR>
imap <F3> <ESC>:Vista!!<CR>

"代码注释
Plug 'hrp/EnhancedCommentify'
let g:EnhCommentifyRespectIndent = 'Yes'
let g:EnhCommentifyPretty = 'Yes'
"有2种方式来注释：
"1 <leader>c 这个注释之后光标会跳转到下一行。
"2 <leader>x 用这个注释之后，光标仍然停留在当前行
nmap <silent> <C-\> \x
vmap <silent> <C-\> \x
imap <silent> <C-\> \x

"补全括号
Plug 'Raimondi/delimitMate'
"For Python docstring.
au FileType python let b:delimitMate_nesting_quotes = ['"']

"补全HTML/XML标签
Plug 'docunext/closetag.vim'
let g:rainbow_active = 1

"彩虹括号
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1 " 彩虹括号, 0代表关闭

"美化状态栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='simple'
"使用powerline打过补丁的字体
let g:airline_powerline_fonts = 1
"设置字体和大小，根据自己的需要调整
set guifont=Hack
"关闭状态显示空白符号计数"
"let g:airline#extensions#whitespace#enabled=0
"let g:airline#extensions#whitespace#symbol='!'
"开启tabline
let g:airline#extensions#tabline#enabled=1
"关闭空白符检测
let g:airline#extensions#whitespace#enabled=0
"tabline中buffer显示编号
"let g:airline#extensions#tabline#buffer_nr_show = 1
"在 airline 的状态栏上显示文件的绝对路径
"let g:airline_section_c = "%{expand('%:p')}"

"美化文件管理图标，需要设置特定的字体
Plug 'ryanoasis/vim-devicons'
" 对图标进行美化
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" HTML, CSS, JavaScript, PHP, JSON, etc.
Plug 'elzr/vim-json',{'for':['json','vim-plug']}
" 去掉JSON自动隐藏引号
"let g:vim_json_syntax_conceal = 0
let g:indentLine_concealcursor=""
Plug 'hail2u/vim-css3-syntax'
Plug 'spf13/PIV', { 'for' :['php', 'vim-plug'] }
Plug 'gko/vim-coloresque', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
Plug 'pangloss/vim-javascript', { 'for' :['javascript', 'vim-plug'] }
Plug 'mattn/emmet-vim'
" 只在html和css文件中起作用
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstal
" 修改Emmet扩展键 实现tab补全
let g:user_emmet_expandabbr_key = '<tab>'
" 修改Emmet默认快捷键 将默认的<C-y>修改成<C-e>方便操作
"let g:user_emmet_leader_key = '<C-e>'


call plug#end()
" ----- vim-plug结束-----



"按 F5 调用当前脚本
map <F5> :call CompileRunGo()<CR>
imap <F5> <ESC>:call CompileRunGo()<CR>
func! CompileRunGo()
    exec "w"
    exec "cd %:p:h"
    if &filetype == 'c'
    exec "!g++ % -o %<"
    exec "! ./%<"
    elseif &filetype == 'cpp'
    exec "!g++ % -o %<"
    exec "! ./%<"
    elseif &filetype == 'java'
    exec "!javac -encoding utf-8 %"
    exec "!java %<"
    elseif &filetype == 'python'
        ":term python %
    exec ":!python %"
    elseif &filetype == 'html'
    exec "!start %:p"
    "exec '!start "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" %:p'
    elseif &filetype == 'markdown'
    exec "MarkdownPreview"
    endif
endfunc

" --------------------
" < 新文件标题 >
" --------------------
"新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.py,*.java exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
func SetTitle()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1,"\#!/bin/bash")
        call append(line("."),"\#########################################################################")
        call append(line(".")+1, "\#      File Name: ".expand("%"))
        call append(line(".")+2, "\#      Author: JIAS")
        call append(line(".")+3, "\#      Email: Jias96@163.com")
        call append(line(".")+4, "\#      Blog： http://www.****.com/")
        call append(line(".")+5, "\#      Created Time: ".strftime("%c"))
        call append(line(".")+6, "\#########################################################################")
        call append(line(".")+7, "")

    elseif &filetype == 'python'
        call setline(1,"\# -*- coding: utf-8 -*-")
        call append(line("."),"\#########################################################################")
        call append(line(".")+1, "\#      File Name: ".expand("%"))
        call append(line(".")+2, "\#      Author: JIAS")
        call append(line(".")+3, "\#      Email: Jias96@163.com")
        call append(line(".")+4, "\#      Blog： http://www.*****.com/")
        call append(line(".")+5, "\#      Created Time: ".strftime("%c"))
        call append(line(".")+6, "\#########################################################################")
        call append(line(".")+7, "")

    elseif &filetype == 'java'
        call setline(1, "/*************************************************************************")
        call append(line("."), "      File Name: ".expand("%"))
        call append(line(".")+1, "      Author: JIAS  ")
        call append(line(".")+2, "      Email: Jias96@163.com")
        call append(line(".")+3, "      Blog： http://www.*****.com/")
        call append(line(".")+4, "      Created Time: ".strftime("%c"))
        call append(line(".")+5, " ************************************************************************/")
        call append(line(".")+6, "")
        call append(line(".")+7,"public class ".expand("%:r"))
        call append(line(".")+8,"{")
        call append(line(".")+9,"")
        call append(line(".")+10,"}")

    endif
    if &filetype == 'cpp'
        call append(line(".")+6, "#include<iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
    endif
    "新建文件后，自动定位到文件末尾
endfunc
autocmd BufNewFile * normal G-1
