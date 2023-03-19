#!/usr/bin/env ruby

# NOTE - slightly modified from parent repo:
# https://github.com/pqrs-org/KE-complex_modifications/blob/a8f78f8f1cddc4cd2820d3d31066969971f78efa/src/json/dual_keys.json.rb

PARAMETERS = {
  :to_if_alone_timeout_milliseconds => 300,
  :to_delayed_action_delay_milliseconds => 0,
  :to_if_held_down_threshold_milliseconds => 0,
  :simultaneous_threshold_milliseconds => 50,
}.freeze

require 'json'
# require_relative '../lib/karabiner.rb'

def main
  puts JSON.pretty_generate(
    "title" => "Dual keys (shift/enter)",
    "maintainers" => ["amar1729"],
    "rules" => [
      {
        "description" => "Dual keys: enter->enter/shift on hold. Helpful for smaller keyboards.",
        "manipulators" => [
          generate_dual_key_rule("return_or_enter", "return_or_enter", "right_shift"),
          generate_dual_key_rule("left_arrow", "left_arrow", "right_command"),
          generate_dual_key_rule("down_arrow", "down_arrow", "right_option"),
        ],
      },
    ],
  )
end

def generate_dual_key_rule(input, alone, held_down)
  {
    "type" => "basic",
    "from" => {
      "key_code" => input,
      "modifiers" => { "optional" => ["any"] },
    },
    "to_if_alone" => [
      {
        "key_code" => alone,
      },
    ],
    "to_if_held_down" => [
      {
        "key_code" => held_down,
      },
    ],
    'parameters' => {
      'basic.to_if_alone_timeout_milliseconds' => PARAMETERS[:to_if_alone_timeout_milliseconds],
      'basic.to_if_held_down_threshold_milliseconds' => PARAMETERS[:to_if_held_down_threshold_milliseconds],
    },
  }
end

main()
