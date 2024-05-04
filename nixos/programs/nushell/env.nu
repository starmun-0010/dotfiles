$env.PATH = ($env.PATH | split row (char esep)
  | append /usr/local/bin
  | append ($env.HOME | path join .cargo/bin)
  | append ($env.HOME | path join .local bin)
  | uniq) # filter so the paths are unique


let zoxide_cache = ("~/.cache/zoxide" | path expand)
if not ($"($zoxide_cache)/nuinit.nu" | path exists) {
  if not ($zoxide_cache | path exists) {
    mkdir $zoxide_cache
  }
  zoxide init nushell --cmd cd 
  | save --force $"($zoxide_cache)/nuinit.nu"
}
