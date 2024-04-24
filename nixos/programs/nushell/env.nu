let zoxide_cache = ("~/.cache/zoxide" | path expand)
if ($"($zoxide_cache)/nuinit.nu" | path exists) {
  return
}

if not ($zoxide_cache | path exists) {
  mkdir $zoxide_cache
}
zoxide init nushell --cmd cd 
| save --force $"($zoxide_cache)/nuinit.nu"
