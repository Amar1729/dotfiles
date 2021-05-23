# Karabiner key rebindings

I use [Karabiner-Elements](https://karabiner-elements.pqrs.org/) for arbitrary key rebindings on MacOS. It's been extremely helpful for workflow, especially in recent years when Apple removed the physical escape key in favor of a touch bar.

I referenced https://github.com/pqrs-org/KE-complex_modifications for their dual_keys script and for inspiration for my own vi_extended mode.

You can run the scripts in this directory (python or ruby) to generate a JSON blob.

That JSON should be added to a file under `assets/complex_modifications`, after which you can add those rules through the Karabiner UI.

## all key rebindings

| mode      | original          | on tap      | on hold                                     |
| ----      | ----              | ----        | ----                                        |
|           | caps_lock         | escape      |                                             |
|           | shift + caps_lock | caps_lock   |                                             |
|           | left_command      | enter       | left_command                                |
|           | right_command     | tab         | right_command                               |
|           | z                 | z           | left_control                                |
|           | /                 | /           | right_control                               |
| ----      | ----              | ----        | ----                                        |
|           | f                 | f           | vi_f_mode                                   |
| vi_f_mode | h                 | left_arrow  |                                             |
| vi_f_mode | j                 | down_arrow  |                                             |
| vi_f_mode | k                 | up_arrow    |                                             |
| vi_f_mode | l                 | right_arrow |                                             |
| ----      | ----              | ----        | ----                                        |
|           | v                 | v           | vi_v_mode (hold right_option)               |
| vi_v_mode | h                 | left_arrow  |                                             |
| vi_v_mode | j                 | down_arrow  |                                             |
| vi_v_mode | k                 | up_arrow    |                                             |
| vi_v_mode | l                 | right_arrow |                                             |
| ----      | ----              | ----        | ----                                        |
|           | r                 | r           | vi_r_mode (hold right_option + right_shift) |
| vi_r_mode | h                 | left_arrow  |                                             |
| vi_r_mode | j                 | down_arrow  |                                             |
| vi_r_mode | k                 | up_arrow    |                                             |
| vi_r_mode | l                 | right_arrow |                                             |
| ----      | ----              | ----        | ----                                        |
