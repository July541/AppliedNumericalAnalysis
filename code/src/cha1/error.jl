#=
error:
- Julia version: 1.4.0
- Author: July541
- Date: 2020-03-25
=#

function absolute_error(x::Number, x_star::Number)
    return abs(x_star - x)
end