
@inline function add_dbfp_db(x::Double{T,E}, y::T) where {T<:AbstractFloat, E<:Emphasis}
    xhi, xlo = HILO(x)
    xhi, xlo = add_2(y, xhi, xlo)
    return Double(E, xhi, xlo)
end

@inline function sub_dbfp_db(x::Double{T,E}, y::T) where {T<:AbstractFloat, E<:Emphasis}
    xhi, xlo = HILO(x)
    xhi, xlo = add_2(-y, xhi, xlo)
    return Double(E, xhi, xlo)
end

# Algorithm 9 from Tight and rigourous error bounds. relative error <= 2u²
@inline function mul_dd_fl(xhi::T, xlo::T, y::T) where T<:IEEEFloat
    hi, lo = mul_(xhi, y)
    t = lo + xlo*y
    hi, lo = add_hilo_(hi, t)
    return hi, lo
end

@inline function mul_dbfp_db(x::Double{T,E}, y::T) where {T<:AbstractFloat, E<:Emphasis}
    xhi, xlo = HILO(x)
    xhi, xlo = mul_dd_fl(xhi, xlo, y)
    return Double(E, xhi, xlo)
end

@inline function dve_dbfp_db(x::Double{T,E}, y::T) where {T<:AbstractFloat, E<:Emphasis}
    xhi, xlo = HILO(x)
    yinv = inv(y)
    xhi, xlo = mul_2(yinv, xhi, xlo)
    return Double(E, xhi, xlo)
end
