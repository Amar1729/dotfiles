" -*- vim -*-
" FILE: neomake_java_helper.vim

" Function to help (neomake)[https://github.com/neomake/neomake/] find the
" gradle classpath.
" Uses (javacomplete2)[https://github.com/artur-shaik/vim-javacomplete2]
" to find and set the classpath.

function! FixNeomakeGradle()
    if exists('g:JavaComplete_PluginLoaded') && exists('g:JavaComplete_ProjectKey')
        if javacomplete#classpath#gradle#IfGradle()
            " extend classpath manually
            let path = javacomplete#util#GetBase("classpath". g:FILE_SEP). g:JavaComplete_ProjectKey
            let javac_classpath = readfile(path)

            let g:neomake_java_javac_classpath = javac_classpath[0]
        endif
    endif
endfunction

au BufEnter * :call FixNeomakeGradle()
