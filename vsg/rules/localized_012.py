from vsg import token
from vsg.rules import remove_spaces_before_token_rule


class rule_012(remove_spaces_before_token_rule):
    """
    Check there are no spaces betwen the file declaration and :
    """

    def __init__(self):
        super().__init__(token.file_declaration.colon)
        self.solution = "Ensure no space exists between interface / parameter unknown declaration and :"
