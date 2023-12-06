function [R , t1] = CASSI_R( dim )

M = dim(1);
N = dim(2);
L = dim(3);

X = reshape(1:M * N * L, [M, N, L]);

cont = 1;
b2 = [];
for i = 1:L
    cont2 = 0;
    for j = 1:i
        a(1, cont) = j;
        a(2, cont) = i - j + 1;
        cont = cont + 1;
        cont2 = cont2 + 1;
    end
    b2 = [b2; cont2];
end

for i = L + 1:N
    cont2 = 0;
    for j = 1:L
        a(1, cont) = j;
        a(2, cont) = i - j + 1;
        cont = cont + 1;
        cont2 = cont2 + 1;
    end
    b2 = [b2; cont2];
end

for i = 2:L
    cont2 = 0;
    for j=i:L
        a(1, cont) = j;
        a(2, cont) = N - j + i;
        cont = cont + 1; 
        cont2 = cont2 + 1;
    end
    b2 = [b2; cont2];
end

B2 = [];
cont1 = 1;

for i = 1:M
    for j = 1:N*L
        t1(cont1, 1) = X(i, a(2, j), a(1, j));  
        cont1 = cont1 + 1;
    end
    B2 = [B2; b2];
end

R = sparse(1:M * N * L, t1, 1);

end

