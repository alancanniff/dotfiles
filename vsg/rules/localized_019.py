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


class rule_023(remove_spaces_before_token_rule):
    """
    Check there are no spaces betwen the block label and :
    """

    def __init__(self):
        remove_spaces_before_token_rule.__init__(
            self, "localized", "002", token.case_statement.label_colon
        )
        self.solution = "Ensure no space exists between case label and :"


class rule_024(remove_spaces_before_token_rule):
    """
    Check there are no spaces betwen the constant and :
    """

    def __init__(self):
        remove_spaces_before_token_rule.__init__(
            self, "localized", "002", token.constant_declaration.colon
        )
        self.solution = "Ensure no space exists between case label and :"


class rule_025(remove_spaces_before_token_rule):
    """
    Check there are no spaces betwen the constant and :
    """

    def __init__(self):
        remove_spaces_before_token_rule.__init__(
            self, "localized", "025", token.interface_constant_declaration.colon
        )
        self.solution = "Ensure no space exists between interface constant and :"


class rule_026(remove_spaces_before_token_rule):
    """
    Check there are no spaces betwen the constant and :
    """

    def __init__(self):
        remove_spaces_before_token_rule.__init__(
            self, "localized", "026", token.interface_signal_declaration.colon
        )
        self.solution = "Ensure no space exists between interface signal and :"


class rule_027(remove_spaces_before_token_rule):
    """
    Check there are no spaces betwen the constant and :
    """

    def __init__(self):
        remove_spaces_before_token_rule.__init__(
            self, "localized", "027", token.interface_variable_declaration.colon
        )
        self.solution = "Ensure no space exists between interface variable and :"


class rule_028(remove_spaces_before_token_rule):
    """
    Check there are no spaces betwen the constant and :
    """

    def __init__(self):
        remove_spaces_before_token_rule.__init__(
            self, "localized", "028", token.interface_file_declaration.colon
        )
        self.solution = "Ensure no space exists between interface file and :"


class rule_029(remove_spaces_before_token_rule):
    """
    Check there are no spaces betwen the constant and :
    """

    def __init__(self):
        remove_spaces_before_token_rule.__init__(
            self, "localized", "029", token.interface_unknown_declaration.colon
        )
        self.solution = "Ensure no space exists between interface unknown and :"
