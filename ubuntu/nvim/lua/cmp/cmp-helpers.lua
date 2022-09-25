local Module = {}
Module.handle_cmp_tab = function(cmp, direction)
    return function(fallback)
        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        if cmp.visible() then
            if direction == 1 then
                cmp.select_next_item()
            elseif direction == -1 then
                cmp.select_prev_item()
            end
        elseif require("luasnip").expandable() then
            require("luasnip").expand({})
        elseif require("luasnip").jumpable(direction) then
            require("luasnip").jump(direction)
        elseif direction == 1 and has_words_before() then
            cmp.complete()
        else
            fallback()
        end
    end
end
return Module
