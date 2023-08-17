using Dates

#=A time interval in ISO8601 format.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/TimeIntervalCollection
=#
struct TimeInterval
    startTime::DateTime
    endTime::DateTime
end
function TimeInterval(;
    startTime::DateTime,
    endTime::DateTime,
)::TimeInterval
    if endTime < startTime
        error("endTime must occur after startTime.")
    end
    return TimeInterval(startTime, endTime)
end
