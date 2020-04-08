#=
cha5:
- Julia version: 1.4.0
- Author: July541
- Date: 2020-03-31
=#

function bisection_method(f::Function, a:: Number, b::Number, epsilon::Float64=1e-8, N::Number=10^5)
    if a > b
        a, b = b, a
    end

    for i = 1:N
        x = (a + b) / 2
        x_e = (b - a) / 2

        if x_e < epsilon
            return x
        end

        fx = f(x)
        if abs(fx) < epsilon
            return x
        end

        fa = f(a)
        if fa * fx < 0
            b = x
        else
            a = x
        end
    end
    error("Maximum iteration reached.")
end

function deriv(f::Function, x::Number)
    epsilon = 1e-8
    return (f(x) - f(x - epsilon)) / epsilon
end

function newton_method(f::Function, init_value::Number=0.0, epsilon::Float64=1e-8, N::Number=10^5)
    for i = 1:N
        f_deriv = deriv(f, init_value)
        if abs(f_deriv - 0) < epsilon
            error("derivtion equals zero")
        end

        x = init_value - f(init_value) / f_deriv
        if abs(x - init_value) < epsilon || abs(f(x)) < epsilon
            return x
        end
        init_value = x
    end
    error("Maximum iteration reached.")
end

function simple_newton_method(f::Function, init_value::Number=0.0, epsilon::Float64=1e-8, N::Number=10^5)
    f_deriv = deriv(f, init_value)
    if abs(f_deriv - 0) < epsilon
        error("derivtion equals zero")
    end

    for i = 1:N
        x = init_value - f(init_value) / f_deriv
        if abs(x - init_value) < epsilon || abs(f(x)) < epsilon
            return x
        end
        init_value = x
    end

    error("Maximum iteration reached.")
end

function newton_down_hill_method(f::Function, init_value::Number=0.0, epsilon::Float64=1e-8, N::Int=10^5)
    lambda = 2.0

    # choose lambda
    next_value = init_value
    while abs(f(next_value)) >= abs(f(init_value))
        lambda /= 2
        next_value = init_value - lambda * (f(init_value) / deriv(f, init_value))
    end

    for i = 1:N # x_1 is recalculated
        next_value = init_value - lambda * (f(init_value) / deriv(f, init_value))
        if abs(next_value - init_value) < epsilon
            return next_value
        end

        init_value = next_value
    end

    error("Maximum iteration reached.")
end

function secant_method(f::Function, x_0::Number, x_1::Number, epsilon::Float64=1e-8, N::Int=10^5)
    for i = 1:N
        x_0 = x_1 - (x_1 - x_0) * f(x_1) / (f(x_1) - f(x_0))
        if abs(x_0 - x_1) < epsilon
            return x_0
        end
        x_0, x_1 = x_1, x_0
    end
    error("Maximum iteration reached.")
end

function improved_secant_method(f::Function, x_0::Number, x_1::Number, epsilon::Float64=1e-8, N::Int=10^5)
    for i = 1:N
        delta_x = -(x_1 - x_0) * f(x_1) / (f(x_1) - f(x_0))
        if abs(delta_x) < epsilon
            return x_1
        end
        x_0 = x_1
        x_1 = x_1 + delta_x
    end
    error("Maximum iteration reached.")
end

function aitken(f::Function, x_0::Number=0.0, epsilon::Float64=1e-8, N::Int=10^5)
    for i = 1:N
        x_1 = f(x_0)
        x_2 = f(x_1)
        x = x_0 - (x_1 - x_0) ^ 2 / (x_2 - 2 * x_1 + x_0)
        if abs(x - x_0) < epsilon
            return x
        end
        x_0 = x
    end
end

f(x) = (10 / (x + 4)) ^ (1/2)
println(aitken(f, 1.5))