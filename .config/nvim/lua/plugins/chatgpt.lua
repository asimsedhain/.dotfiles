-- return exports the whole module
-- lazy will stitch all the everything together
-- https://github.com/folke/lazy.nvim?tab=readme-ov-file#-structuring-your-plugins
--
--model = "gpt-3.5-turbo",
--model = "gpt-4-turbo-preview",
local model = 'gpt-4o'
return {
	-- ChatGPT
	{
		"jackMort/ChatGPT.nvim",
		lazy = true,
		cmd = { "ChatGPT", "ChatGPTActAs", "ChatGPTEditWithInstructions", "ChatGPTRun", "ChatGPTCompleteCode" },
		dependencies = { "muniftanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			-- ChatGPT
			require("chatgpt").setup({
				api_key_cmd = "security find-generic-password -s openai -w",
				chat = {
					welcome_message = "Start Asking....",
					loading_text = "Loading, please wait ...",
					question_sign = "🙋", -- 🙂
					answer_sign = "🤖", -- 🤖
					border_left_sign = "|",
					border_right_sign = "|",
					sessions_window = {
						active_sign = "🟩 ",
						inactive_sign = " ⬜️",
						current_line_sign = "►",
					},
				},
				popup_input = {
					prompt = " 🟢 ",
				},
				openai_params = {
					--model = "gpt-3.5-turbo",
					model = model,
					frequency_penalty = 0,
					presence_penalty = 0,
					max_tokens = 600,
					temperature = 0,
					top_p = 1,
					n = 1,
				},
				openai_edit_params = {
					model = model,
					frequency_penalty = 0,
					presence_penalty = 0,
					temperature = 0,
					top_p = 1,
					n = 1,
				},
			})
		end,
	},
}
