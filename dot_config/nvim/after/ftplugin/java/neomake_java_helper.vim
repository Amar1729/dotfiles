" -*- vim -*-
" FILE: neomake_java_helper.vim

" Function to help (neomake)[https://github.com/neomake/neomake/] find the
" gradle classpath.
" Uses (javacomplete2)[https://github.com/artur-shaik/vim-javacomplete2]
" to find and set the classpath.

function! s:GetBasePath()
    return substitute(g:JavaComplete_GradlePath, 'build.gradle', 'src/main/java', '')
endfunction

function! FixNeomakeGradle()
    if exists('g:JavaComplete_PluginLoaded') && exists('g:JavaComplete_ProjectKey')
        if javacomplete#classpath#gradle#IfGradle()
            " extend classpath manually
            let l:path = javacomplete#util#GetBase("classpath" . g:FILE_SEP) . g:JavaComplete_ProjectKey
            let l:javac_classpath = readfile(l:path)

            let g:neomake_java_javac_classpath = s:GetBasePath() . ":" . l:javac_classpath[0]
        endif
    endif
endfunction

au BufEnter * :call FixNeomakeGradle()
