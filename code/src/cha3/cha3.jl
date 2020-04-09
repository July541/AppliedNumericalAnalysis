#=
cha3:
- Julia version: 1.4.0
- Author: July541
- Date: 2020-04-08
=#

using LinearAlgebra

function LDU(arr::Array)
    D = Diagonal(arr)
    L = LowerTriangular(arr) - D
    U = UpperTriangular(arr) - D
    return L, D, U
end

function jacobi_iteration(X::Array, Y::Array, epsilon::Float64=1e-8, N::Int=10^5)
    L, D, U = LDU(arr)
    x_0 = zeros(size(X, 2))
    for i = 1:N
        x_1 = -inv(D) * (L + U) * x_0 + inv(D) * Y

        if abs(norm(x_1, Inf) - norm(x_0, Inf)) < epsilon
            return x_1
        end
        x_0 = x_1
    end
end

function gauss_seidel(X::Array, Y::Array, epsilon::Float64=1e-8, N::Int=10^5)
    L, D, U = LDU(X)
    x_0 = zeros(size(X, 2))
    for i in 1:N
        x_1 = -inv(D + L) * U * x_0 + inv(D + L) * Y

        if abs(norm(x_1, Inf) - norm(x_0, Inf)) < epsilon
            return x_1
        end
        x_0 = x_1
    end
end

function sor(X::Array, Y::Array, omega::Float64, epsilon::Float64=1e-8, N::Int=10^5)
    L, D, U = LDU(X)
    x_0 = zeros(size(X, 2))
    for i in 1:N
        x_1 = inv(D + omega .* L) * ((1 - omega) .* D - omega .* U) * x_0 +
            omega .* inv(D + omega .* L) * Y
        if abs(norm(x_1, Inf) - norm(x_0, Inf)) < epsilon
            return x_1
        end
        x_0 = x_1
    end
end

function steepest_descent_method(X::Array, Y::Array, epsilon::Float64=1e-8, N::Int=10^5)
    x_0 = zeros(size(X, 2))
    r = Y - X * x_0

    for i in 1:N
        alpha = dot(r, r) / dot(X * r, r)
        y = x_0 + alpha .* r
        r = Y - X * y
        if norm(r, 1) < epsilon || norm(y - x_0, 1) < epsilon
            return y
        end
        x_0 = y
    end
end

function conjugate_gradient_method(X::Array, Y::Array, epsilon::Float64=1e-8, N::Int=10^5)
    x_0 = zeros(size(X, 2))

    for i in 1:N
        r = Y - X * x_0
        p = r
        alpha = dot(r, r) / dot(X * p, p)
        x_1 = x_0 + alpha .* p
        r_1 = r - alpha .* X * p
        beta = dot(r_1, r_1) / dot(r, r)
        p_1 = r_1 + beta .* p
        if norm(r, 1) < epsilon || dot(X * p, p) < epsilon
            return x_0
        end
        x_0 = x_1
    end
    error("error2")
end

arr = [[8,4,6.0] [-3, 11, 3] [2, -1, 12]]
y = [20, 33, 36.0]
print(conjugate_gradient_method(arr, y))
