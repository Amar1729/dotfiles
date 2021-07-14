#!/usr/bin/env python3

import json

mode_name = 'vi_{}_mode'

trigger_key_normal = 'f'
trigger_key_movemt = 'r'
trigger_key_visual = 'v'
trigger_key_delete = 'd'

arrow_dict = {
    'h': 'left_arrow',
    'j': 'down_arrow',
    'k': 'up_arrow',
    'l': 'right_arrow',
}

mod_dict = {
    trigger_key_normal: [],
    trigger_key_movemt: ['right_option'],
    trigger_key_visual: ['right_option', 'right_shift'],
    # note: delete_or_backspace is not a modifier
    # also 'delete' mode would only really have one keybind: delete-backward
    #trigger_key_delete: ['right_option', 'delete_or_backspace'],
}

def generate_to_directive(to_key, modifiers):
    j = {
        'key_code': to_key,
    }

    if modifiers:
        j['modifiers'] = modifiers

    return j

def generate_vi_mode(trigger_key, from_key, to_key, modifiers=None):
    return [
        {
            'type': 'basic',
            'from': {
                'key_code': from_key,
                'modifiers': {'optional': ['any']},
            },
            'to': [
                generate_to_directive(to_key, modifiers),
            ],
            'conditions': [
                {
                    'type': 'variable_if',
                    'name': mode_name.format(trigger_key),
                    'value': 1,
                },
            ],
        },
        {
            'type': 'basic',
            'from': {
                'simultaneous': [
                    { 'key_code': trigger_key, },
                    { 'key_code': from_key },
                ],
                'simultaneous_options': {
                    'key_down_order': 'strict',
                    'key_up_order': 'strict_inverse',
                    'to_after_key_up': [
                        {
                            'set_variable': {
                                'name': mode_name.format(trigger_key),
                                'value': 0,
                            },
                        },
                    ],
                },
                'modifiers': {'optional': ['any']},
            },
            'to': [
                generate_to_directive(to_key, modifiers),
                {
                    'set_variable': {
                        'name': mode_name.format(trigger_key),
                        'value': 1,
                    },
                },
            ],
            'parameters': {
                'basic.simultaneous_threshold_milliseconds': 500,
            },
        },
    ]

def generate_manipulators():
    for trigger, mods in mod_dict.items():
        for from_key, to_key in arrow_dict.items():
            for directive in generate_vi_mode(trigger, from_key, to_key, mods):
                yield directive

        if trigger == trigger_key_movemt:
            fk = tk = "delete_or_backspace"
            for directive in generate_vi_mode(trigger, fk, tk, mods):
                yield directive

def main():
    return {
        'title': 'Personal rules (@amar1729) vi_expanded_mode',
        'maintainers': ['amar1729'],
        'rules': [
            {
                'description': 'Expanded Vi Mode (rev 1)',
                'manipulators': [
                    m for m in generate_manipulators()
                ],
            },
        ],
    }

print(json.dumps(main(), indent=4, sort_keys=True))
