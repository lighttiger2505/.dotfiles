local ok, ui2 = pcall(require, "vim._core.ui2")
if ok then
    require("vim._core.ui2").enable({
        enable = true,
        msg = {
            targets = "cmd",
            cmd = {
                height = 0.5,
            },
            dialog = {
                height = 0.5,
            },
            msg = {
                height = 0.5,
                timeout = 4000,
            },
            pager = {
                height = 1,
            },
        },
    })
    vim.opt.cmdheight = 0
end
