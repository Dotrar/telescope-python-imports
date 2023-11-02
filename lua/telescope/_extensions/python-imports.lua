local actions = require "telescope.actions"
local actions_meta = require "telescope.actions.mt"
local action_state = require "telescope.actions.state"

local conf = require('telescope.config').values
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')

-- Local functions and values
local keys = {}
local function trim(s)
    return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end
local function seen(value)
    for _, v in ipairs(keys) do
        if value == v then
            return true
        end
    end
    return false
end

local ext = actions_meta.transform_mod({
    clear_keys = function()
        keys={}
    end
})

-- Extension
return require('telescope').register_extension {
    exports = {
        search = function(opts)
            opts = opts or {}

            -- for each line from RG, check if we've seen it,
            opts.entry_maker = function(line)
                line = trim(line)
                if seen(line) then
                    return nil
                end
                table.insert(keys,line)
                return {
                    value = line,
                    ordinal = line,
                    display = line
                }
            end

            pickers.new(opts, {
                prompt_title = 'Imports: ',
                finder = finders.new_oneshot_job(
                {"rg","--no-filename","-tpy","from [a-z.]* import [a-z]*"},
                opts),
                sorter = conf.generic_sorter(opts),


                -- Attach mapping to insert the selected option
                attach_mappings = function(prompt_bufnr, map)
                    -- when selected something, nvim_put it into the buffer
                    actions.select_default:replace(function()
                        local mode = vim.fn.mode()
                        actions.close(prompt_bufnr)
                        local selection = action_state.get_selected_entry()
                        local cp = vim.api.nvim_win_get_cursor(0)
                        vim.api.nvim_win_set_cursor(0, {1,0})
                        vim.api.nvim_put({ trim(selection.value)},"l", false, true)
                        vim.api.nvim_win_set_cursor(0, {cp[1]+1,cp[2]})
                        if mode == 'i' then
                            vim.cmd('startinsert')
                        end
                    end)

                    -- before we close, clear keys
                    actions.close:enhance({
                        pre = function()
                            ext.clear_keys()
                        end
                    })

                    return true
                end,
            }):find()

        end,

    },
}
