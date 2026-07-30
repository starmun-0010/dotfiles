$env.PATH = ($env.PATH | split row (char esep)
  | append /usr/local/bin
  | append ($env.HOME | path join .cargo/bin)
  | append ($env.HOME | path join .local bin)
  | uniq) # filter so the paths are unique


zoxide init --cmd cd nushell | save -f ~/.zoxide.nu

$env.STARSHIP_CONFIG = ($env.HOME | path join .config starship starship.toml)
starship init nu | save -f ~/.starship.nu

# starship's character module can't detect nushell's vi mode (upstream TODO),
# so it's disabled in starship.toml and these take over instead: same glyphs
# (bold catppuccin green, red on last command's failure) styled to match.
$env.PROMPT_INDICATOR_VI_INSERT = {||
    if $env.LAST_EXIT_CODE != 0 {
        $"(ansi -e '1;38;2;243;139;168m')❯ (ansi reset)"
    } else {
        $"(ansi -e '1;38;2;166;227;161m')❯ (ansi reset)"
    }
}
$env.PROMPT_INDICATOR_VI_NORMAL = {||
    if $env.LAST_EXIT_CODE != 0 {
        $"(ansi -e '1;38;2;243;139;168m')❮ (ansi reset)"
    } else {
        $"(ansi -e '1;38;2;166;227;161m')❮ (ansi reset)"
    }
}
