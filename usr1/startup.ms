checkLaunchArgs = function
	args = env.cmdLineArgs[1:]
	print "Launched with: " + args
	if args then
		if args.hasIndex(args.indexOf("-load")) then
			load args[args.indexOf("-load") + 1]
			if args.hasIndex(args.indexOf("-run")) then
				run
			end if
		end if
	else
		print "Standard Boot"
	end if
end function

reset = function
	Sound.stopAll
	globals._source = []
	globals._sourceFile = null
	_restoreGlobals
	env.importPaths = [".", "/usr/lib", "/sys/lib"]
	return null
end function

checkLaunchArgs()