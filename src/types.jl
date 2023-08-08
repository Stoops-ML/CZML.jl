using Dates

#=A time interval in ISO8601 format.
https://github.com/AnalyticalGraphicsInc/czml-writer/wiki/TimeIntervalCollection
=#
@with_kw struct TimeInterval
    startTime::DateTime
    endTime::DateTime
end
