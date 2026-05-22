-- Needs to be set before lazy is loaded
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move highlighted lines together
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor in same place when concatenating lines
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor in the middle during half page jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep cursor in the middle during search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- copy into your system clipboard: credit asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

--vim.keymap.set({"n", "v"}, "<leader>d", "\"_d")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

local function lsp_rename_and_write()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({
        bufnr = bufnr,
        method = vim.lsp.protocol.Methods.textDocument_rename,
    })

    if #clients == 0 then
        vim.notify("[LSP] Rename, no matching language servers with rename capability.")
        return
    end

    local client = clients[1]
    local win = vim.api.nvim_get_current_win()

    local function write_workspace_edit_buffers(workspace_edit)
        local uris = {}

        if workspace_edit.documentChanges then
            for _, change in ipairs(workspace_edit.documentChanges) do
                if change.textDocument and change.textDocument.uri then
                    uris[change.textDocument.uri] = true
                elseif change.kind == "rename" and change.newUri then
                    uris[change.newUri] = true
                elseif change.kind == "create" and change.uri then
                    uris[change.uri] = true
                end
            end
        end

        if workspace_edit.changes then
            for uri in pairs(workspace_edit.changes) do
                uris[uri] = true
            end
        end

        vim.schedule(function()
            for uri in pairs(uris) do
                local changed_bufnr = vim.uri_to_bufnr(uri)
                if vim.api.nvim_buf_is_loaded(changed_bufnr)
                    and vim.bo[changed_bufnr].modified
                    and vim.bo[changed_bufnr].buftype == ""
                then
                    local ok, err = pcall(vim.api.nvim_buf_call, changed_bufnr, function()
                        vim.cmd("silent write")
                    end)
                    if not ok then
                        vim.notify("[LSP] Rename save failed: " .. err, vim.log.levels.ERROR)
                    end
                end
            end
        end)
    end

    local function rename(new_name)
        local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
        params.newName = new_name

        client:request(vim.lsp.protocol.Methods.textDocument_rename, params, function(err, result)
            if err then
                vim.notify("[LSP] Rename failed: " .. (err.message or tostring(err)), vim.log.levels.ERROR)
                return
            end

            if not result then
                return
            end

            vim.lsp.util.apply_workspace_edit(result, client.offset_encoding)
            write_workspace_edit_buffers(result)
        end, bufnr)
    end

    vim.ui.input({ prompt = "New Name: ", default = vim.fn.expand("<cword>") }, function(input)
        if not input or input == "" then
            return
        end
        rename(input)
    end)
end

-- LSP rename symbol under cursor
vim.keymap.set("n", "<leader>rn", lsp_rename_and_write)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- find and replace word over cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
