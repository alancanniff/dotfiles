from vsg import token
from vsg.rules import remove_spaces_before_token_rule


class rule_001(remove_spaces_before_token_rule):
    """
    Check there are no spaces betwen the process label and :
    """

    def __init__(self):
        remove_spaces_before_token_rule.__init__(
            self, "localized", "001", token.process_statement.label_colon
        )
        self.solution = "Ensure no space exists between process label and :"
