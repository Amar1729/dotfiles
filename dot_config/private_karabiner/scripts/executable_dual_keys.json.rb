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
    "title" => "Dual keys (to relieve stress from your pinkies)",
    "maintainers" => ["marlonrichert"],
    "rules" => [
      {
        "description" => "Dual keys",
        "manipulators" => [
          generate_dual_key_rule("left_command", "return_or_enter", "left_command"),
          generate_dual_key_rule("right_command", "tab", "right_command"),
          generate_dual_key_rule("z", "z", "left_control"),
          generate_dual_key_rule("slash", "slash", "right_control"),
          generate_dual_key_rule("caps_lock", "escape", "caps_lock")
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

def generate_single_key_rule(input, output)
  {
    "type" => "basic",
    "from" => {
      "key_code" => input,
      "modifiers" => { "optional" => ["any"] },
    },
    "to" => [
      {
        "key_code" => output,
      },
    ],
  }
end

main()
