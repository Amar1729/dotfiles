#!/usr/bin/env python3

import json


def generate_fn_to():
    return [
        {
            'type': 'basic',
            'from': {
                'key_code': 'fn',
                'modifiers': {
                    'optional': ['any'],
                },
            },
            'to': [
                {
                    'key_code': 'left_option',
                    'modifiers': ['left_control'],
                },
            ],
            'conditions': [
                {
                    'type': 'frontmost_application_if',
                    'bundle_identifiers': ["^org\\.mozilla\\.firefox$"],
                },
            ],
        },
    ]


def main():
    return {
        'title': 'Personal rules (@amar1729) rebind fn -> alt+ctrl',
        'maintainers': ['amar1729'],
        'rules': [
            {
                'description': 'fn -> ctrl+alt (rev 1)',
                'manipulators': generate_fn_to(),
            },
        ],
    }


print(json.dumps(main(), indent=4, sort_keys=True))
