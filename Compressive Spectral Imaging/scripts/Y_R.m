function [R, t1] = Y_R(dim)
M = dim(1);
N = dim(2);
L = dim(3);
Y = reshape(1:M * N *L, [M, N, L]);

cont = 1;
for i = 1:N
    for j = 1:L
        a(1, cont) = j;
        a(2, cont) = i;
        cont = cont + 1;
    end
end

cont1 = 1;
for i = 1:M
    for j = 1:N * L
        t1(cont1, 1) = Y(i, a(2, j), a(1, j));  
        cont1 = cont1 + 1;
    end
end

R = sparse(1:M * N * L, t1, 1);

end

