$env.PATH = ($env.PATH | split row (char esep)
  | append /usr/local/bin
  | append ($env.HOME | path join .cargo/bin)
  | append ($env.HOME | path join .local bin)
  | uniq) # filter so the paths are unique


zoxide init --cmd cd nushell | save -f ~/.zoxide.nu

$env.STARSHIP_CONFIG = ($env.HOME | path join .config starship starship.toml)
starship init nushell | save -f ~/.starship.nu
