from vsg import token
from vsg.rules import remove_spaces_before_token_rule


class rule_002(remove_spaces_before_token_rule):
    """
    Check there are no spaces betwen the signal declaration and :
    """

    def __init__(self):
        remove_spaces_before_token_rule.__init__(
            self, "localized", "002", token.signal_declaration.colon
        )
        self.solution = "Ensure no space exists between signal declaration and :"
