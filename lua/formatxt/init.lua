local M = {}

M.emptylines = function()
	local getBuffer = vim.api.nvim_get_current_buf()

	local _, srow, scol = unpack(vim.fn.getpos("v"))
	local _, erow, ecol = unpack(vim.fn.getpos("."))
	local lini = -1
	local lfin = -1

	local lines = {}

	if vim.fn.mode() == "V" then
		if srow > erow then
			lini, lfin = erow, srow
		else
			lini, lfin = srow, erow
		end
		lines = vim.api.nvim_buf_get_lines(0, lini - 1, lfin, true)
	end

	-- local outLines = vim.split(outTxt, "\n", true)

	-- Divide a string outTxt em linhas
	-- local outLines = {}
	-- for line in outTxt:gmatch("[\r\n]+") do
	-- 	table.insert(outLines, line)
	-- end

	local listout = {}
	for i = 1, #lines do
		if lines[i] ~= "" then
			table.insert(listout, lines[i])
		end
	end

	vim.api.nvim_buf_set_lines(getBuffer, lini - 1, lfin, false, listout)
end

M.addPrefixLines = function()
	local getBuffer = vim.api.nvim_get_current_buf()

	local _, srow, scol = unpack(vim.fn.getpos("v"))
	local _, erow, ecol = unpack(vim.fn.getpos("."))
	local lini = -1
	local lfin = -1

	local lines = {}

	if vim.fn.mode() == "V" then
		if srow > erow then
			lini, lfin = erow, srow
		else
			lini, lfin = srow, erow
		end
		lines = vim.api.nvim_buf_get_lines(0, lini - 1, lfin, true)
	end

	local listout = {}
	for i = 1, #lines do
		if lines[i] ~= "" then
			local resAddPrefix = string.gsub(lines[i], "^([ \t]*)", "%1- ")
			table.insert(listout, resAddPrefix)
		end
	end

	vim.api.nvim_buf_set_lines(getBuffer, lini - 1, lfin, false, listout)
	--
	-- -- Pegar o range de linhas atualmente selecionadas no visual mode
	-- local start_line, start_col = unpack(vim.fn.getpos("'<"), 2, 3)
	-- local end_line, end_col = unpack(vim.fn.getpos("'>"), 2, 3)
	--
	-- -- Iterar sobre cada linha no range e adicionar o prefixo
	-- for line_num = start_line, end_line do
	--   local line = vim.fn.getline(line_num)
	--   if line ~= "" then
	--     vim.fn.setline(line_num, "- " .. line)
	--   end
	-- end
end

M.addPrefixTitLines = function()
	local getBuffer = vim.api.nvim_get_current_buf()

	local _, srow, scol = unpack(vim.fn.getpos("v"))
	local _, erow, ecol = unpack(vim.fn.getpos("."))
	local lini = -1
	local lfin = -1

	local lines = {}

	if vim.fn.mode() == "V" then
		if srow > erow then
			lini, lfin = erow, srow
		else
			lini, lfin = srow, erow
		end
		lines = vim.api.nvim_buf_get_lines(0, lini - 1, lfin, true)
	end

	local listout = {}
	for i = 1, #lines do
		if lines[i] ~= "" then
			local resAddPrefix = string.gsub(lines[i], "^([ \t]*)", "%1# ")
			table.insert(listout, resAddPrefix)
		end
	end

	vim.api.nvim_buf_set_lines(getBuffer, lini - 1, lfin, false, listout)

end


M.gsubCharForBLline = function()
	local getBuffer = vim.api.nvim_get_current_buf()

	local _, srow, scol = unpack(vim.fn.getpos("v"))
	local _, erow, ecol = unpack(vim.fn.getpos("."))
	local lini = -1
	local lfin = -1

	local lines = {}

	if vim.fn.mode() == "V" then
		if srow > erow then
			lini, lfin = erow, srow
		else
			lini, lfin = srow, erow
		end
		lines = vim.api.nvim_buf_get_lines(0, lini - 1, lfin, true)
	end

	local listToString = table.concat(lines, "|")

  --local addLineBreak = string.gsub(listToString, "[,:;.|()]", "\n")
  local addLineBreak = string.gsub(listToString, "([,:;.|()])", "%1\n")

	local result = {}
	local delimiter = "\n"
	for match in (addLineBreak .. delimiter):gmatch("(.-)" .. delimiter) do
		table.insert(result, match)
	end

	local listout = {}
	for i = 1, #result do
		if result[i] ~= "" then
			local stringTrimmed = result[i]:gsub("^%s*", "")
			table.insert(listout, stringTrimmed)
		end
	end

	vim.api.nvim_buf_set_lines(getBuffer, lini - 1, lfin, false, listout)
end

M.setup = function()
	vim.keymap.set("v", "<leader>fd", function()
		M.emptylines()
	end, { desc = "DelEmptyLines" })

	vim.keymap.set("v", "<leader>fp", function()
		M.addPrefixLines()
	end, { desc = "AddPrefix" })

	vim.keymap.set("v", "<leader>ft", function()
		M.addPrefixTitLines()
	end, { desc = "AddPrefix" })

	vim.keymap.set("v", "<leader>fb", function()
		M.gsubCharForBLline()
	end, { desc = "BracketLine" })
end

return M
