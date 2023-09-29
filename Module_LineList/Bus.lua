--
-- 柠檬写的 230909
-- For 临东定制
--

local p = {}

function p.infobox(frame)
	local args = frame:getParent().args
	local lineName = args.Name
	local lineColor = args.Color
	local company = args.Company
	local ticket = args.Ticket
	local firstTrain = args.FirstTrain
	local lastTrain = args.LastTrain
	
	local output = mw.html.create("div")
	output:addClass("infobox-card")
	
	if args.Clear ~= nil then
		output:cssText('clear: unset;')
	end
	
	local header = output:tag("div"):addClass("header")
	header:tag("div"):addClass("line-name"):wikitext(lineName)
	
	local detail = header:tag("div"):addClass("detail")
	detail:tag("div"):addClass("company"):wikitext(company)
	
	local time = header:tag("div"):addClass("time")
	time:tag("div"):addClass("first-train"):wikitext(firstTrain)
	time:tag("div"):addClass("last-train"):wikitext(lastTrain)
	time:tag("div"):addClass("ticket"):wikitext(ticket)
	
	local stationList = output:tag("ul"):addClass("station-list")
	if args.Direction then
		local direction = args.Direction
		stationList:tag("div"):addClass("direction"):wikitext(direction)
	end
	stationList:wikitext("<div class='line' style='background-color:" .. lineColor .. ";'></div>")
	
	local maxStationIndex = 0
	for key, _ in pairs(args) do
		local stationIndex = tonumber(key:match("^Sta(%d+)$"))
		if stationIndex and stationIndex > maxStationIndex then
			maxStationIndex = stationIndex
		end
	end
	
	for stationIndex = 1, maxStationIndex do
		local stationInfo = args["Sta" .. stationIndex]
		if stationInfo then
			local li = stationList:tag("li")
			local stationDiv = li:tag("div"):addClass("name")
			local stationDivCircle = stationDiv:tag("div"):addClass("circle"):cssText('border: 4px solid ' .. lineColor .. ';')
			local expandedText = frame:preprocess(stationInfo)
			stationDiv:wikitext(expandedText)
			
			-- 未开放
			if args["Sta" .. stationIndex .. "Unopen"] then
				stationDiv:cssText('color: var(--color-base--subtle);')
				stationDivCircle:cssText('border: 4px solid var(--color-surface-4);')
			end
			
			-- 单向运营
			local way = args["Sta" .. stationIndex .. "Way"]
			if way then
				if string.lower(way) == "up" then
					stationDiv:addClass("dir-tag__up")
				elseif string.lower(way) == "down" then
					stationDiv:addClass("dir-tag__down")
				end
			end
		end
	end
	
	return tostring(output)
end

return p
