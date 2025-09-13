timeout = function(args)
	argsMap = {"start":10,"stop":1,"mode":"up"}
	
	if args then
		args = args.split(" ")
		for i in range(0, args.len - 1)
			args[i] = args[i].split(":")
		end for
	else
		args = [["",""],["",""],["",""]]
	end if
	
	if args.len < 3 then
		found = [null, null, null]
		missing = [null, null, null]
		for arg in args
			if arg[0] == "start" then found[0] = "start"
			if arg[0] == "stop" then found[1] = "stop"
			if arg[0] == "mode" then found[2] = "mode"
		end for
		
		print found
		
		for arg in found
			print found
			if arg == "start" then found.remove(found.indexOf(arg)) else missing[0] = "start"
			if arg == "stop" then found.remove(found.indexOf(arg)) else missing[1] = "stop"
			if arg == "mode" then found.remove(found.indexOf(arg)) else missing[2] = "mode"
			print found
		end for
		
		for miss in missing
			if miss == "start" then args.push ["start","10"]
			if miss == "stop" then args.push ["stop","1"]
			if miss == "mode" then args.push ["mode","down"]
		end for
		
		print missing
		print args
	end if
	
	for i in range(0, args.len - 1)
		if args[i][0] == "start" then argsMap.start = args[i][1].val
		if args[i][0] == "stop" then argsMap.stop = args[i][1].val
		if args[i][0] == "mode" then argsMap.mode = args[i][1].val
	end for
	
	if argsMap.mode == "up" then
		temp = argsMap.start - 1
		argsMap.start = argsMap.stop
		argsMap.stop = temp
	end if
	
	for i in range(argsMap.start, argsMap.stop)
		print "Time Left: " + i + " ", char(13)
		text.row += 1
		wait 1
	end for
	
	print "Okay, you can go."
	key.clear
end function