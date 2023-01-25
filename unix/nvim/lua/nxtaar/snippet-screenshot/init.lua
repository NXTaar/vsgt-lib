vim.cmd([[
    let g:silicon = {
    \   'theme':              'Dracula',
    \   'font':                  'Hack',
    \   'background':         '#AAAAFF',
    \   'shadow-color':       '#555555',
    \   'output': '~/Desktop/silicon-{time:%Y-%m-%d-%H%M%S}.png',
    \   'line-pad':                   2,
    \   'pad-horiz':                 40,
    \   'pad-vert':                  40,
    \   'shadow-blur-radius':         0,
    \   'shadow-offset-x':            0,
    \   'shadow-offset-y':            0,
    \   'line-number':           v:true,
    \   'round-corner':          v:true,
    \   'window-controls':       v:false,
    \ }
]])
