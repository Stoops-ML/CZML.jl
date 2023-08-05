function srrm2sddm(arr::Vector{T})::Vector{T} where {T<:AbstractFloat}
    out = copy(arr)
    for i in 1:4:length(out)
        out[i+1] = rad2deg(out[i+1])
        out[i+2] = rad2deg(out[i+2])
    end
    return out
end

function sddm2srrm(arr::Vector{T})::Vector{T} where {T<:AbstractFloat}
    out = copy(arr)
    for i in 1:4:length(out)
        out[i+1] = deg2rad(out[i+1])
        out[i+2] = deg2rad(out[i+2])
    end
    return out
end

function rrm2ddm(arr::Vector{T})::Vector{T} where {T<:AbstractFloat}
    out = copy(arr)
    for i in 1:3:length(out)
        out[i] = rad2deg(out[i])
        out[i+1] = rad2deg(out[i+1])
    end
    return out
end

function ddm2rrm(arr::Vector{T})::Vector{T} where {T<:AbstractFloat}
    out = copy(arr)
    for i in 1:3:length(out)
        out[i] = deg2rad(out[i])
        out[i+1] = deg2rad(out[i+1])
    end
    return out
end
