# # import vsg.rules.single_space_between_tokens as Rule
# import vsg.rules.whitespace_between_tokens as Rule

# # import vsg.rules.n_spaces_after_tokens as Rule
# # print(help(Rule))
# # vsg -c personal.yaml -f pulse_cdc.vhd^C-local_rules rules --fix

# from vsg import token

# lTokens = []
# lTokens.append(
#     [
#         token.concurrent_simple_signal_assignment.target,
#         token.concurrent_simple_signal_assignment.assignment,
#     ]
# )
# lTokens.append(
#     [
#         token.concurrent_conditional_signal_assignment.target,
#         token.concurrent_conditional_signal_assignment.assignment,
#     ]
# )
# lTokens.append(
#     [
#         token.concurrent_selected_signal_assignment.target,
#         token.concurrent_selected_signal_assignment.assignment,
#     ]
# )
# lTokens.append(
#     [token.constant_declaration.constant_keyword, token.constant_declaration.identifier]
# )
# lTokens.append(
#     [
#         None,  # token.constant_declaration.subtype_indication,
#         None,  # token.constant_declaration.assignment_operator,
#     ]
# )

# lTokens.append(
#     [token.association_element.assignment, token.association_element.actual_part]
# )
# lTokens.append(
#     [token.association_element.formal_part, token.association_element.assignment]
# )

# lTokens.append(
#     [token.simple_force_assignment.target, token.simple_waveform_assignment.assignment]
# )
# lTokens.append(
#     [token.simple_force_assignment.target, token.simple_force_assignment.assignment]
# )
# lTokens.append(
#     [token.simple_force_assignment.target, token.simple_release_assignment.assignment]
# )


# class rule_100(Rule):
#     """
#     Check there a single space between ...
#     """

#     def __init__(self):
#         Rule.__init__(self)
#         self.left_token = lTokens[0][0]
#         self.right_token = lTokens[0][1]
#         # self.solution = "Ensure 1 space between target and <="


# class rule_101(Rule):
#     """
#     Check there a single space between ...
#     """

#     def __init__(self):
#         super().__init__()
#         self.left_token, self.right_token = lTokens[1][0], lTokens[1][1]
#         self.solution = "Ensure 1 space between target and <="


# class rule_102(Rule):
#     """
#     Check there a single space between ...
#     """

#     def __init__(self):
#         super().__init__()
#         self.left_token, self.right_token = lTokens[2][0], lTokens[2][1]
#         self.solution = "Ensure 1 space between target and <="


# class rule_103(Rule):
#     """
#     Check there a single space between ...
#     """

#     def __init__(self):
#         super().__init__()
#         self.left_token, self.right_token = lTokens[3][0], lTokens[3][1]
#         self.solution = "Ensure 1 space between target and <="


# # class rule_104(Rule):
# #     """
# #     Check there a single space between ...
# #     """

# #     def __init__(self):
# #         super().__init__()
# #         self.left_token, self.right_token = lTokens[4][0], lTokens[4][1]
# #         self.solution = "Ensure 1 space between target and <="


# class rule_105(Rule):
#     """
#     Check there a single space between ...
#     """

#     def __init__(self):
#         super().__init__()
#         self.left_token, self.right_token = lTokens[5][0], lTokens[5][1]
#         self.solution = "Ensure 1 space between target and <="


# class rule_106(Rule):
#     """
#     Check there a single space between ...
#     """

#     def __init__(self):
#         super().__init__()
#         self.left_token, self.right_token = lTokens[6][0], lTokens[6][1]
#         self.solution = "Ensure 1 space between target and <="


# class rule_107(Rule):
#     """
#     Check there a single space between ...
#     """

#     def __init__(self):
#         super().__init__()
#         self.left_token, self.right_token = lTokens[7][0], lTokens[7][1]
#         self.solution = "Ensure 1 space between target and <="


# class rule_108(Rule):
#     """
#     Check there a single space between ...
#     """

#     def __init__(self):
#         super().__init__()
#         self.left_token, self.right_token = lTokens[8][0], lTokens[8][1]
#         self.solution = "Ensure 1 space between target and <="
