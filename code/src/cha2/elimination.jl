function small_enough(v::Number, epsilon=1e-8)
    return abs(v - 0.0) < epsilon
end

function gauss_elimination(X::Array, b::Array)
    A = hcat(x, b)
    row_num = size(A, 1)

    # elimination
    for i in 1:row_num-1
        pivot = A[i, i]
        for j in i+1:row_num
            base = A[j, i] / pivot
            A[j,:] = A[j,:] - (base .* A[i,:])
        end
    end

    if small_enough(A[row_num, row_num])
        error("Can not elimination.")
    end

    # feedback
    b = A[:, end]
    b[end] /= A[end, end-1] # last line
    for i in row_num-1:-1:1
        pivot = A[i,i]
        b[i] -= sum(A[i,i+1:end-1] .* b[i+1:end])
        b[i] /= pivot
    end

    print(b)
    return b
end


function gauss_elimination_column_pivot(X::Array, b::Array)
    A = hcat(X, b)
    row_num = size(A, 1)
    for i in 1:row_num-1
        target = map(item -> abs(item), A[i:end, i])
        max_val = maximum(target)
        if small_enough(max_val)
            error("Can not elimination")
        end

        max_index = findfirst(target .== max_val)
        if max_index != 1
            A[i, :], A[max_index, :] = A[max_index, :], A[i, :]
        end

        pivot = A[i, i]
        for j in i+1:row_num
            base = A[j, i] / pivot
            A[j,:] = A[j,:] - (base .* A[i,:])
        end
    end

    b = A[:, end]
    b[end] /= A[end, end-1] # last line
    for i in row_num-1:-1:1
        pivot = A[i,i]
        b[i] -= sum(A[i,i+1:end-1] .* b[i+1:end])
        b[i] /= pivot
    end

    print(b)
    return b
end

x = [1. 2. 3.; 2 7 5; 1 4 9]
b = [1; 6; -3.]
gauss_elimination(x, b)
