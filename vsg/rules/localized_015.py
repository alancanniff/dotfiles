from vsg import token
from vsg.rules import remove_spaces_before_token_rule


class rule_015(remove_spaces_before_token_rule):
    """
    Check there are no spaces betwen the element declaration (record) and :
    """

    def __init__(self):
        super().__init__(token.element_declaration.colon)
        self.solution = "Ensure no space exists between element declaration and :"
