
# some custom ipython settings - i don't like the In/Out line prompts

## Use colors for displaying information about objects. Because this information
#  is passed through a pager (like 'less'), and some pagers get confused with
#  color codes, this capability can be turned off.
c.InteractiveShell.color_info = True

## Set the color scheme (NoColor, Neutral, Linux, or LightBG).
c.InteractiveShell.colors = 'Linux'

from IPython.terminal.prompts import Prompts
from pygments.token import Token

class MyPrompt(Prompts):
    # keep regular >>> prompt
    def in_prompt_tokens(self, cli=None):
        return [(Token.Prompt, '>>> ')]

    # empty continuation lines to make copy/paste to script easier
    def continuation_prompt_tokens(self, cli=None):
        return [(Token.Prompt, ' ')]

    # simplify outline
    def out_prompt_tokens(self, cli=None):
        return [(Token.Prompt, '> ')]

c.TerminalInteractiveShell.prompts_class = MyPrompt
