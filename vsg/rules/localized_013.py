from vsg import token
from vsg.rules import remove_spaces_before_token_rule


class rule_013(remove_spaces_before_token_rule):
    """
    Check there are no spaces betwen the file declaration and :
    """

    def __init__(self):
        super().__init__(token.attribute_declaration.colon)
        self.solution = "Ensure no space exists between file declaration and :"
