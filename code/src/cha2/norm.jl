using LinearAlgebra

function norm_1_vec(x::Array)
    return sum(map(item -> abs(item), x))
end

function norm_2_vec(x::Array)
    return sqrt(sum(map(item -> item^2, x)))
end

function norm_inf_vec(x::Array)
    return maximum(x)
end

function norm_1_mat(x::Array)
    return maximum(sum(map(item -> abs(item), x), dims=1))
end

function norm_2_mat(x::Array)
    return sqrt(eigmax(x' * x))
end

function norm_inf_mat(x::Array)
    return maximum(sum(map(item -> abs(item), x), dims=2))
end

function spectral_radius(x::Array)
    return maximum(map(item -> abs(item), eigvals(x)))
end

function cond_1(x::Array)
    x_inv = inv(x)
    return norm_1_mat(x) * norm_1_mat(x_inv)
end

function cond_2(x::Array)
    x_inv = inv(x)
    return norm_2_mat(x) * norm_2_mat(x_inv)
end

function cond_inf(x::Array)
    x_inv = inv(x)
    return norm_inf_mat(x) * norm_inf_mat(x_inv)
end

# x = [1, 0.5, 0, -0.3]
# println(norm_1_v(x))
# println(norm_2_v(x))
# println(norm_inf_v(x))

# x = [-2. 1 0; 1 -2 1; 0 1 -2]
# println(norm_1_mat(x))
# println(norm_2_mat(x))
# println(norm_inf_mat(x))
# println(spectral_radius(x))

# x = [1 1/2; 1/2 1/3]
# println(cond_1(x))
# println(cond_2(x))
# println(cond_inf(x))
