vim.api.nvim_buf_create_user_command(0, "Jq", "<line1>,<line2>!jq .", { range = "%" })
