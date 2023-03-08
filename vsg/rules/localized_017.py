from vsg import token
from vsg.rules import remove_spaces_before_token_rule


class rule_017(remove_spaces_before_token_rule):
    """
    Check there are no spaces betwen the entity specification (attribute) and :
    """

    def __init__(self):
        remove_spaces_before_token_rule.__init__(
            self, "localized", "017", token.entity_specification.colon
        )
        self.solution = (
            "Ensure no space exists between entity specification (attribute) and :"
        )
