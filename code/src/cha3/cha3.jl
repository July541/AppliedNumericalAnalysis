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
    x_0 = zeros(size(X)[1])
    for i = 1:N
        x_1 = -inv(D)*(L+U)*x_0 + inv(D)*Y
        x_0 = x_1

        if (i == 9)
            return x_0
        end
    end
end

arr = [[8,4,6.0] [-3, 11, 3] [2, -1, 12]]
y = [20, 33, 36.0]
print(jacobi_iteration(arr, y))