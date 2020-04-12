using LinearAlgebra

function select_max(A::Array)
    A = A - diagm(diag(A))
    return argmax(map(item -> abs(item), A))
end

function jacobi_eigen(A::Array, epsilon::Float64=5e-4, N::Int=10^5)
    Q = Matrix{Float64}(I, size(A))
    for i in 1:N
        pos = select_max(A)
        p, q = pos[1], pos[2]
        S = Matrix{Float64}(I, size(A))

        a = (A[q, q] - A[p, p]) / (2 * A[p, q])
        t = 1 / (abs(a) + sqrt(1 + a ^ 2))
        if  a < 0
            t = -t
        end

        c = 1 / (sqrt(1 + t ^ 2)) # cos
        s = t * c # sin
        S[p, p] = c
        S[q, q] = c
        S[p, q] = s
        S[q, p] = -s
        # println(p, ", ", q)
        # println("S: ", S)

        A = S' * A * S
        # println("T: ", A, "\n")
        Q = Q * S
        if (sum(map(item -> abs(item), (A - diagm(diag(A)))))) < epsilon
            return diag(A), Q, i
        end
    end

    error("maximum iteration reached")
end

x = [1. 2 0; 2 -1 1; 0 1 3]
# print(select_max(x), x)
print(jacobi_eigen(x))
