def sudo [name:string] {
    ^sudo (^which $name)
}
$env.config = {
    edit_mode: vi

    history: {
        max_size: 100000
    }
}
source ~/.cache/zoxide/nuinit.nu
