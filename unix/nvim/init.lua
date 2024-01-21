require('nxtaar.spec')
require('nxtaar.settings')
require('nxtaar.commands')
require('nxtaar.core.keymapper')

spec('nxtaar.lsp.setup')
spec('nxtaar.core.treesitter')

spec('nxtaar.editor.colorscheme')
spec('nxtaar.editor.bottom_line')
spec('nxtaar.editor.comments')
spec('nxtaar.editor.navigation')
spec('nxtaar.editor.undo')
-- spec('nxtaar.editor.notifications')

spec('nxtaar.tools.git')
spec('nxtaar.tools.fs_navigation')
spec('nxtaar.tools.problems')
spec('nxtaar.tools.reformatting')
spec('nxtaar.tools.buffers')
spec('nxtaar.tools.telescope')

require('nxtaar.launch')
