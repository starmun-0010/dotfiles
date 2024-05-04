alias sudo = bash -c sudo "PATH=$PATH"
env.config = {
    edit_mode: vi

    history: {
        max_size: 100000
    }
}
source ~/.cache/zoxide/nuinit.nu
