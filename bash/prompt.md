Options to customize your prompt

| Text Format        | Foreground (text) color | Background color |
| ------------------ | ----------------------- | ---------------- |
| 0: normal text     | 30: Black               | 40: Black        |
| 1: bold            | 31: Red                 | 41: Red          |
| 4: Underlined text | 32: Green               | 42: Green        |
|                    | 33: Yellow              | 43: Yellow       |
|                    | 34: Blue                | 44: Blue         |
|                    | 35: Purple              | 45: Purple       |
|                    | 36: Cyan                | 46: Cyan         |
|                    | 37: White               | 47: White        |


We will use the `\e` special character at the beginning and an `m` at the end to indicate that what follows is a color sequence.

In this sequence the three values (**background**, **format**, and **foreground**) are separated by commas (if no value is given the default is assumed).

Source: [tecmint](https://www.tecmint.com/customize-bash-colors-terminal-prompt-linux/)
