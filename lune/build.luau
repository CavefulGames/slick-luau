--!strict

local process = require("@lune/process")
local pathfs = require("../lune_packages/pathfs")

process.spawn("multitarget", { "build", "-y", "--luau", "--roblox", "--build-files", "slick", "luau" }, {
	stdio = "forward",
})

-- Remove .luaurc files from target/roblox because it's useless in roblox
for _, entry in pathfs.getDescendantEntries("target/roblox") do
	if not entry.file or entry.file.path:fileName() ~= ".luaurc" then
		continue
	end
	entry.file:removeFile()
end
