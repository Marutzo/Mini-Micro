import "json"
import "stringUtil"
import "dateTime"
context = []
context.push "Assistant is a large language model capable of "
context.push "helping the user in many ways, including writing "
context.push "code, poetry, stories, and more."
context.push "Knowledge cutoff: 2022-09"
context.push "Current date: " + dateTime.now("yyyy-MM-dd")

apiKey = function
	if outer.hasIndex("_apiKey") then return _apiKey
	data = file.readLines("/usr/API-key.txt")
	if data == null then
		print "API-key.txt file not found."
		exit
	end if
	outer._apiKey = data[0]
	return _apiKey
end function

respond = function(prompt, temperature=0.5)
	url = "https://api.openai.com/v1/completions"
	headers = {}
	headers["Content-Type"] = "application/json"
	headers["Authorization"] = "Bearer " + apiKey
	data = {}
	data.model = "text-davinci-003"
	data.prompt = prompt
	data.temperature = temperature
	data.max_tokens = 2048
	
	globals.rawResult = http.post(url, json.toJSON(data), headers)
	globals.result = json.parse(rawResult)
	if result == null or not result.hasIndex("choices") then
		return rawResult
	end if
	return result.choices[0].text.trim
end function

clear
print "Talk to GPT-3!"
_printMark "(Enter `quit` to exit.)"
while true
	inp = input(">")
	if inp.lower == "quit" or inp.lower == "exit" then break
	context.push "User: " + inp
	context.push "Assistant: "
	resp = respond(context.join(char(13)))
	context[-1] = "Assistant: " + resp
	oldColor = text.color; text.color = color.aqua
	for line in resp.wrap
		print line
	end for
	text.color = oldColor
end while

print "Thank you for talking to GPT-3, and have a nice day."