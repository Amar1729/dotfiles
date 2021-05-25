#!/usr/bin/env python3

import json


def mod_rule(from_key, to_key, modifiers, optional=None):
    return [
        {
            "from": {
                "key_code": from_key,
                "modifiers": {
                    "mandatory": modifiers,
                    "optional": optional if optional else from_key,
                },
            },
            "to": [{"key_code": from_key}],
            "type": "basic",
        },
        {
            "from": {
                "key_code": from_key,
                "modifiers": {"optional": ["any"]},
            },
            "to": [
                {
                    "key_code": to_key,
                    "modifiers": [],
                },
            ],
            "type": "basic",
        },
    ]


def main():
    return {
        'title': 'Personal rules (@amar1729) caps->escape',
        'maintainers': ['amar1729'],
        'rules': [
            {
                'description': 'Caps_Lock -> Escape, shift+Caps_Lock->Caps_Lock',
                'manipulators': mod_rule("caps_lock", "escape", ["shift"]),
            },
        ],
    }


print(json.dumps(main(), indent=4, sort_keys=True))
