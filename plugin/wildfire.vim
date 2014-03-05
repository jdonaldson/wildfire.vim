" =============================================================================
" File: wildfire.vim
" Description: Smart selection of the closest text object
" Mantainer: Giacomo Comitti (https://github.com/gcmt)
" Url: https://github.com/gcmt/wildfire.vim
" License: MIT
" =============================================================================

" Init
" =============================================================================

if exists("g:loaded_wildfire")
    finish
endif
let g:loaded_wildfire = 1

let s:save_cpo = &cpo
set cpo&vim


" Settings
" =============================================================================

let g:wildfire_fuel_map =
    \ get(g:, "wildfire_fuel_map", "<ENTER>")

let g:wildfire_water_map =
    \ get(g:, "wildfire_water_map", "<BS>")


" Commands and Mappings
" =============================================================================

function! s:SetCommands()
    if !empty(&bt)
        return
    endif

    nnoremap <silent> <Plug>(wildfire-fuel) :<C-U>call wildfire#start(v:count1)<CR>
    vnoremap <silent> <Plug>(wildfire-fuel) :<C-U>call wildfire#fuel(v:count1)<CR>
    vnoremap <silent> <Plug>(wildfire-water) :<C-U>call wildfire#water()<CR>

    if !hasmapto('<Plug>(wildfire-fuel)') && !hasmapto('<Plug>(wildfire-water)')
        exe "nnoremap " . g:wildfire_fuel_map . " <Plug>(wildfire-fuel)"
        exe "map" g:wildfire_fuel_map "<Plug>(wildfire-fuel)"
        exe "map" g:wildfire_water_map "<Plug>(wildfire-water)"
    endif
endfunction


" Autocommands
" =============================================================================

augroup wildfire
    au!

    " Enable Wildfire outside of help or quickfix buffers
    au BufReadPost,CmdWinEnter * call s:SetCommands()

augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
