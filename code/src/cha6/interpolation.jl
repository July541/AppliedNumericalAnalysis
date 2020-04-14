function lagrange_1(x, x_0, fx_0, x_1, fx_1)
    return (x - x_1) / (x_0 - x_1) * fx_0 + (x - x_0) / (x_1 - x_0) * fx_1
end

function lagrange_2(x, x_0, fx_0, x_1, fx_1, x_2, fx_2)
    t1 = fx_0 * ((x - x_1) * (x - x_2)) / ((x_0 - x_1) * (x_0 - x_2))
    t2 = fx_1 * ((x - x_0) * (x - x_2)) / ((x_1 - x_0) * (x_1 - x_2))
    t3 = fx_2 * ((x - x_0) * (x - x_1)) / ((x_2 - x_0) * (x_2 - x_1))
    return t1 + t2 + t3
end

function lagrange(x, n, xs) # size(xs) = (n, 2) n is the size of input
    L = 0.0
    for i in 1:n + 1 # here is n + 1
        l = 1.0
        for j in 1:size(xs, 1)
            if i != j
                l *= (x - xs[j, 1]) / (xs[i, 1] - xs[j, 1])
            end
        end
        println("l", i, " ", l)
        L += l * xs[i, 2]
    end
    return L
end

function newton(x::Number, xs::Array, epsilon::Float64=1e-8)
    n_0 = xs[1, 2]
    diffs = xs[:, 2]
    for i in 2:size(xs, 1)
        println(diffs)
        new_diffs = copy(diffs)
        new_diffs[i] = (diffs[i] - diffs[i - 1]) / (xs[i, 1] - xs[1, 1])
        p = 1.0
        for j in 1:i-1
            p *= (x - xs[j, 1])
        end
        n_1 = n_0 + new_diffs[i] * p
        if abs(n_1 - n_0) < epsilon
            return n_1
        end

        n_0 = n_1
        for j in i+1:size(xs, 1)
            new_diffs[j] = (diffs[j] - diffs[j - 1]) / (xs[j, 1] - xs[j - i + 1, 1])
        end
        diffs = new_diffs
    end
    return n_0
end


# xs = [0.4 -0.916291; 0.5 -0.693147; 0.7 -0.356675; 0.8 -0.223144]
# xs = [4.0002 0.6020817; 4.0104 0.6031877; 4.0233 0.6045824; 4.0294 0.6052404]
xs = [0.55 0.57815; 0.65 0.69675; 0.4 0.41075; 0.8 0.88811; 0.9 1.02652; 1.05 1.25382]
println(newton(0.596, xs))
