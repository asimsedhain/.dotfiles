-- lazy will stitch all the everything together
-- https://github.com/folke/lazy.nvim?tab=readme-ov-file#-structuring-your-plugins
local cmd_prefix = "Cp"
local map = require("utils").map
return {
	{
		"robitx/gp.nvim",
		config = function()
			require("gp").setup({
				openai_api_key = { "security", "find-generic-password", "-s", "openai", "-w" },
				whisper = {
					disable = true
				},
				image = {
					disable = true
				},
				cmd_prefix = cmd_prefix,
				hooks = {
					UnitTests = function(gp, params)
						local template = "I have the following code from {{filename}}:\n\n"
							.. "```{{filetype}}\n{{selection}}\n```\n\n"
							.. "Respond by writing table driven unit tests for the code above.\n"
							.. "The goal should be test edge cases rather than the obvious simple case."
						local agent = gp.get_command_agent()
						gp.Prompt(params, gp.Target.popup, agent, template)
					end,
					Explain = function(gp, params)
						local template = "I have the following code from {{filename}}:\n\n"
							.. "```{{filetype}}\n{{selection}}\n```\n\n"
							.. "Respond by explaining the code above."
						local agent = gp.get_chat_agent()
						gp.Prompt(params, gp.Target.popup, agent, template)
					end,
					CodeReview = function(gp, params)
						local template = "I have the following code from {{filename}}:\n\n"
							.. "```{{filetype}}\n{{selection}}\n```\n\n"
							.. "Analyze for code smells and suggest improvements."
							.. "Focus on proper typing (if applicable), and common pitfalls."
						local agent = gp.get_chat_agent()
						gp.Prompt(params, gp.Target.popup, agent, template)
					end,
					ProofRead = function(gp, params)
						local template = "I want you act as a proofreader.\n"
							.. "I will provide you texts and I would like you to review them for any spelling, grammar, or punctuation errors.\n"
							.. "Once you have finished reviewing the text, respond exclusively with the improved text\n\n"
							.. "```{{selection}}```"
						local agent = gp.get_chat_agent()
						gp.Prompt(params, gp.Target.rewrite, agent, template)
					end,
					DocString = function(gp, params)
						local template = "I have the following code from {{filename}}:\n\n"
							.. "```{{filetype}}\n{{selection}}\n```\n\n"
							.. "Respond by writing docstring for the code."
							.. "Focus on following best practice for the given language\n"
							.. "Pay attention to parameters, return types (if applicable)\n"
							.. "and any errors that might be raised or returned, depending on the language\n\n"
							.. "Respond exclusively with the docstring and the original snippet"
						local agent = gp.get_chat_agent()
						gp.Prompt(params, gp.Target.rewrite, agent, template)
					end,
				}
			})

			--Removing unused commands
			local cmd_to_delete = { "Append", "Prepend", "Enew", "New", "Vnew", "Tabnew", "Popup", "Agent" }
			for _, cmd in ipairs(cmd_to_delete) do
				vim.api.nvim_del_user_command(cmd_prefix .. cmd)
			end

			-- add remaps
			map("n", "<C-q>", ":" .. cmd_prefix .. "ChatToggle<CR>", { desc = "Toggle ChatGPT chat" })
			map("n", "<C-w>", ":" .. cmd_prefix .. "ChatRespond<CR>", { desc = "Request ChatGPT to respond" })
		end,
	}
}
