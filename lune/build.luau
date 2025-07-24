local process = require("@lune/process")

process.spawn("multitarget", { "build", "-y", "--luau", "--roblox", "--build-files", "slick", "lib.luau" }, {
	stdio = "forward",
})
