from vsg import token
from vsg.rules import remove_spaces_before_token_rule


class rule_016(remove_spaces_before_token_rule):
    """
    Check there are no spaces betwen the label and entity / compoent declaraion :
    """

    def __init__(self):
        remove_spaces_before_token_rule.__init__(
            self,
            "localized",
            "016",
            token.component_instantiation_statement.label_colon,
        )
        self.solution = (
            "Ensure no space exists betwen the label and entity / compoent declaraion: "
        )
