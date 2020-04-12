include(joinpath(@__DIR__, "..", "cha2", "elimination.jl"))

function power_method(A::Array, epsilon::Float64=1e-8, N::Int=10^5)
    v_0 = rand(Float64, size(A, 2))
    v_1 = A * v_0
    lbd = v_1[1] / v_0[1]

    for i in 1:N
        v_0 = v_1
        v_1 = A * v_1

        new_lbd = v_1[1] / v_0[1]
        if abs(new_lbd - lbd) < epsilon
            eig_vals = v_1 / (new_lbd ^ i)
            # this line is just to limit the eigen values suit the book, page 57
            eig_vals /= eig_vals[end]
            return new_lbd, eig_vals
        end

        lbd = new_lbd
    end
    error("maximum iteration reached")
end

function power_method_improved(A::Array, v::Array=ones(size(A, 2)),
    epsilon::Float64=1e-8, N::Int=10^5)
    lbd_0 = 0.0
    lbd = maxabs(v)
    u = v / lbd

    for i in 1:N
        v = A * u
        println("v: ", v)
        lbd = maxabs(v)
        println("lambda_0: ", lbd_0)
        println("lambda: ", lbd)
        if lbd == 0.0
            return 0.0, u
        end
        u = v / lbd
        println("u: ", u, "\n")
        if abs(lbd - lbd_0) < epsilon
            return lbd, u
        end
        lbd_0 = lbd
    end
    error("maximum iteration reached")
end

function power_method_acceleration(A::Array, t::Number, epsilon::Float64=1e-8,
    N::Int=10^5)
    v::Array=ones(size(A, 2))
    lbd_0 = 0.0 - t
    lbd = maxabs(v) - t
    u = v / lbd

    for i in 1:N
        v = A * u
        # println("v: ", v)
        lbd = maxabs(v)
        # println("lambda_0: ", lbd_0)
        # println("lambda: ", lbd)
        if lbd == 0.0
            return 0.0, u
        end
        u = v / lbd
        # println("u: ", u, "\n")
        if abs(lbd - lbd_0) < epsilon
            return lbd, u, i
        end
        lbd_0 = lbd
    end
    error("maximum iteration reached")
end

function inverse_power_method_with_inv(A::Array, v::Array=ones(Float64,
    size(A, 2)), epsilon::Float64=1e-8, N::Int=10^5)
    u = v / maxabs(v)
    println("u: ", u)
    A = inv(A)
    lbd = 0.0

    for i in 1:100
        v = A * u
        print(1 / maxabs(v), " ")
        u = v / maxabs(v)
        println("u: ", u)

        if abs(maxabs(v) - lbd) < epsilon
            return 1 / maxabs(v), u
        end

        lbd = maxabs(v)
    end
    error("maximum iteration reached")
end

function maxabs(x::Array)
    return x[findmax(map(item -> abs(item), x))[2]]
end

function minabs(x::Array)
    return x[findmin(map(item -> abs(item), x))[2]]
end

function inverse_power_method(A::Array, v::Array=ones(Float64, size(A, 2)),
    epsilon::Float64=1e-86, N::Int=10^5)
    u = v / maximum(v)
    lbd = maximum(v)

    for i in 1:6
        v = gauss_elimination_column_pivot(A, u)
        new_lbd = minabs(1 ./ v)
        println(u, " ", new_lbd)
        if abs(new_lbd - lbd) < epsilon
            return new_lbd, u, i
        end
        u = v / maxabs(v)
        lbd = new_lbd
    end
end

function inverse_power_method_eigvec(A::Array, lbd::Float64)
    A = A - lbd * I(size(A, 2))
    _, u = inverse_power_method(A)
    return u
end

# x = [1. -1 2; -2 0 5; 6 -3 6]
x = [2. -1 0; -1 2 -1; 0 -1 2]
# x = [2. 1 0; 1 3 1; 0 1 4]
# x = [-11. 11 1; 11 9 02; 1 -2 13]
# x = [6. 2 1; 2 3 1; 1 1 1]
println(inverse_power_method(x))
