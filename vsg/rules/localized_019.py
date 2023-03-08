from vsg import token
from vsg.rules import remove_spaces_before_token_rule


class rule_019(remove_spaces_before_token_rule):
    """
    Check there are no spaces betwen the if generate label and :
    """

    def __init__(self):
        remove_spaces_before_token_rule.__init__(
            self, "localized", "019", token.if_generate_statement.label_colon
        )
        self.solution = "Ensure no space exists between if generate label and :"


class rule_020(remove_spaces_before_token_rule):
    """
    Check there are no spaces betwen the for generate label and :
    """

    def __init__(self):
        remove_spaces_before_token_rule.__init__(
            self, "localized", "020", token.for_generate_statement.label_colon
        )
        self.solution = "Ensure no space exists between for generate label and :"


class rule_021(remove_spaces_before_token_rule):
    """
    Check there are no spaces betwen the case generate label and :
    """

    def __init__(self):
        remove_spaces_before_token_rule.__init__(
            self, "localized", "021", token.case_generate_statement.label_colon
        )
        self.solution = "Ensure no space exists between case generate label and :"


class rule_022(remove_spaces_before_token_rule):
    """
    Check there are no spaces betwen the signal declaration and :
    """

    def __init__(self):
        remove_spaces_before_token_rule.__init__(
            self, "localized", "002", token.case_statement.label_colon
        )
        self.solution = "Ensure no space exists between case label and :"


class rule_022(remove_spaces_before_token_rule):
    """
    Check there are no spaces betwen the block label and :
    """

    def __init__(self):
        remove_spaces_before_token_rule.__init__(
            self, "localized", "002", token.case_statement.label_colon
        )
        self.solution = "Ensure no space exists between case label and :"
