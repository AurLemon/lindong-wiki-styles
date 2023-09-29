local p = {}

function p.infobox(frame)
    local args = frame:getParent().args
    local lineName = args.Name or ""
    local lineColor = args.Color or "gray"
    local company = args.Company or ""
    local ticket = args.Ticket or ""
    local firstTrain = args.FirstTrain or ""
    local lastTrain = args.LastTrain or ""

    local output = mw.html.create("div")
    output:addClass("infobox-card")

    local header = output:tag("div"):addClass("header")
    header:tag("div"):addClass("line-name"):wikitext(lineName)

    local detail = header:tag("div"):addClass("detail")
    detail:tag("div"):addClass("company"):wikitext(company)

    local time = header:tag("div"):addClass("time")
    time:tag("div"):addClass("first-train"):wikitext(firstTrain)
    time:tag("div"):addClass("last-train"):wikitext(lastTrain)
    time:tag("div"):addClass("ticket"):wikitext(ticket)

    local stationList = output:tag("ul"):addClass("station-list")
	stationList:wikitext("<div class='line' style='background-color:" .. lineColor .. ";'></div>")

    local stationIndex = 1
    local insertedLine = false
    while args["Sta" .. stationIndex] do
        local stationInfo = args["Sta" .. stationIndex]
        local staName = mw.ustring.match(stationInfo, "([^|]+)")
        
        if staName then
            local li = stationList:tag("li")
            local stationDiv = li:tag("div"):addClass("name"):wikitext(mw.text.unstrip(staName))
        end

        stationIndex = stationIndex + 1
    end

    return tostring(output)
end

return p
