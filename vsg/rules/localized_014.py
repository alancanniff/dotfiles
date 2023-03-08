from vsg import token
from vsg.rules import remove_spaces_before_token_rule


class rule_014(remove_spaces_before_token_rule):
    """
    Check there are no spaces betwen the attribute declaration and :
    """

    def __init__(self):
        remove_spaces_before_token_rule.__init__(
            self, "localized", "014", token.attribute_declaration.colon
        )
        self.solution = "Ensure no space exists between attribute declaration and :"
